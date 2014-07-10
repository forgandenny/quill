child_process = require('child_process')

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
  )

  require('./grunt/build')(grunt)
  require('./grunt/test')(grunt)

  grunt.registerTask('dev', 'All the tasks for Quill development', ->
    done = this.async()
    child_process.spawn('grunt', ['test:karma'], { stdio: 'inherit'})
    child_process.spawn('grunt', ['server'], { stdio: 'inherit' })
  )

  grunt.registerTask('dist', ['clean', 'lodash', 'browserify', 'uglify', 'stylus', 'concat'])
  grunt.registerTask('release', ['dist', 'shell:examples', 'copy', 'compress'])

  grunt.registerTask('server', ['shell:server'])

  grunt.registerTask('test', ['karma:test'])

  grunt.registerTask('test:karma', ['karma:karma'])
  grunt.registerTask('test:unit', ['karma:test'])
  grunt.registerTask('test:unit:remote', ['karma:remote-mac', 'karma:remote-windows', 'karma:remote-linux', 'karma:remote-mobile', 'karma:remote-legacy'])

  grunt.registerTask('test:coverage', ['coffee:src', 'shell:instrument', 'karma:coverage', 'clean:coffee', 'clean:coverage'])
