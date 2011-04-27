From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANN] gst-dsp 0.9.0 released
Date: Thu, 28 Apr 2011 00:07:57 +0300
Message-ID: <BANLkTi=yeoryHPdbO1S+SzJWX87hyhT==Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1D0VH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 17:07:58 -0400
Received: by fxm17 with SMTP id 17so1411250fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 14:07:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gst-dsp <gst-dsp@googlegroups.com>
Cc: beagleboard@googlegroups.com, linux-omap@vger.kernel.org, gstreamer-embedded@lists.freedesktop.org

Hi,

gst-dsp is a GStreamer plug-in to utilize Texas Intruments' DSP
algorithms for OMAP3 platforms using the tidspbridge driver.

This is a major release, many features have been implemented:

 * Huge reorganization
 * Support for IPP (image post-processor)
 * Support for AAC decoder
 * Support for VPP (video post-processor)
 * Huge optimization for video encoders
 * Improvements on caps negotiation
 * Improvements on H.264 keyframe generation
 * Improvements on hang detection
 * Memory leaks fixed
 * Fixes for WMV
 * H.264 encoder tuning
 * Support for gtk-doc
 * Fix for JPEG encoder

Again, we have a lot of contributors. Thanks to everyone!

You can download the tarball from the usual place:
http://code.google.com/p/gst-dsp/downloads/list

And here's the amazing shortlog:

Arvind Gupta (2):
      base: USN socket node interface changes
      vdec: initialize the frame index for WMV

Elamparithi Shanmugam (19):
      ipp: scaffold element
      ipp: socket-node creation
      ipp: add algo initialization
      base: add some vmethods
      ipp: add pipe init
      ipp: add pipe deinit
      ipp: add buffer processing
      ipp: add error handling mechanism
      ipp: add dmm_buffer_begin/end
      ipp: add yuv420p to yuv422i conversion
      ipp: add chroma suppression
      ipp: add EENF
      ipp: add dynamic parameter support for eenf
      ipp: add YUV420p input support
      ipp: update colour format in sink capability.
      ipp: overwrite input buffer
      ipp: fix to exit gracefully if error occurs
      ipp: check for valid height and width value
      venc: use 4 output buffers

=46elipe Contreras (96):
      build: use newer DSP API
      venc: fix bitrate caping
      Fix clang warnings
      bridge: fix dsp_wait_for_events() for DSP_API < 2
      vdec: trivial cleanup
      venc: move level fetching to setcaps()
      venc: properly check for H.264 stream-format
      venc: only strip sps/pps when marked as keyframe
      h264enc: remove 'bytestream' property
      venc: store level
      venc: send max-bitrate to the sn instead of bitrate
      venc: general cleanups
      venc: unref caps after gst_pad_set_caps()
      base: remove warning for empty buffer
      build: make SN_API=3D2 the default
      vdec: shuffle h264
      vdec,venc: get rid of foo_data
      vdec,venc: move profile_id selection to the args func
      vdec,venc: reorganize arg_data stuff
      vdec: create separate extra_data() handlers
      base: introduce td_codec structure
      vdec: reorganize into td_codec
      venc: reorganize into td_codec
      venc: fix compilation warnings
      Make global gstdsp_set_codec_data_caps()
      Create tidsp library, and split codecs
      tidsp: generic cleanups
      tidsp: h264enc: remove dead code
      parse: properly update crop framesize
      plugin: set a sane source package
      Add gtk-doc
      build: include tidsp dir on dependencies
      tidsp: h.264 dec: trivial fix for I420
      base: refactor ts_array/event_array
      base: also use buffer durations
      Rename 'id' to 'index'
      base: decouple stream id from port index
      vpp: add scaffold
      vpp: add codec info
      vpp: improve output framesize negotiation
      Fix compilation warnings
      tidsp: fix JPEG encoder for old SN
      base: export send_buffer()
      Get rid of gstdsp_send_buffer()
      ipp: add vmethods' scaffolds
      ipp: trivial cleanups
      ipp: refactor get_yuvc_params()
      ipp: add INTERNAL_FORMAT define
      ipp: add support for older SN
      ipp: move eenf params to ipp structure
      ipp: fix the port allocation
      ipp: trivial cleanups
      ipp: reset semaphore correctly
      ipp: fix memleak on errors
      ipp: cleanup reset()
      ipp: trivial cleanups
      ipp: cleanup error handling
      ipp: detect fatal errors
      Trivial cleanup
      base: trivial cleanup
      base: introduce td_buffer
      base: reorganize td_buffer stuff a bit
      base: add port to td_buffer
      base: trivial improvements in send_buffer()
      Use td_buffer in {send,recv}_cb
      base: use td_buffer in the queues
      base: use td_buffer in send_buffer()
      ipp: fix td_buffer handling
      base: reorganize send_buffer()
      Move 'user_data' field from dmm_buffer to td_buffer
      Move 'used' field from dmm_buffer to td_buffer
      Move 'keyframe' field from dmm_buffer to td_buffer
      base: remove 'used' field in td_buffer
      Fix gtk-doc stuff for ipp
      Trivial cleanups
      Add conditional compiling checks for caps_to_str
      build: improve build for c99
      tidsp: h264dec: trivial cleanup
      base: trivial cleanup
      Add new gst-dsp-buffer
      venc: increase number of output buffers for JPEG
      Add option to reuse output buffers
      base: don't flush initial pinned buffer
      base: don't flush last pinned buffer
      base: trivial cleanup in send_buffer()
      {h264,mp4v}enc: enable buffer recycling
      sem: add new g_sem_down_timed()
      Avoid hangs with g_sem_down_timed()
      base: avoid possible leaks with pinned buffers
      dmm_buffer: check for zero length on mm operations
      tidsp: h264enc: move I frame interval to right place
      Remove hack to manually force keyframes
      tidsp: h264enc: re-add intra frame interval
      tidsp: h264enc: always strip/ignore sps/pps
      tidsp: mp4venc: only try to extract extra-data for MPEG-4
      Trivial coverity cleanups

Juha Alanen (5):
      venc: mux SPS/PPS only when in bytestream mode
      venc: update H.264 encoder output parameters
      vdec: fix handling of WMV codec_data in WMV3 case
      vdec: update parameters for WMV
      venc: decouple H.264 mode and intra-refresh

Karunesha Uh (1):
      venc: add mbs per frame field in codec level tables

Lauri Lehtinen (7):
      ipp: add framerate to out caps
      ipp: add event handler
      ipp: eenf dynamic params parsing from an event
      ipp: add noise filter strength enum property
      ipp: fix memleak by consuming eenf-params event
      ipp: performance hooks
      jpegenc: expose quality as a property

Mark Nauwelaerts (7):
      base: adjust buffer allocation
      base: unref caps going to READY
      base: free some more buffer arrays at _stop time
      vdec: specify need for complete au's in H.264
      td_h264dec: do not leak transformed codec data
      base: check for unexpected buffers
      build: also clean in tidsp subdirectory

Miguel Verdu (5):
      venc: provide correct level to H.264 encoder
      venc: check level takes bitrate as target
      venc: h264: tune QP value for Initial frame
      gst-dsp-buffer: fix memory leak
      base: remove unnecessary gst-dsp-buffer creation

Stefan Kost (2):
      headers: adhear to gtk-docs weired gobject requirements
      doc: fixes and improvements

Tommi My=C3=B6h=C3=A4nen (1):
      ipp: fix EENF params parsing

V=C3=ADctor Manuel J=C3=A1quez Leal (4):
      vdec: remove destroy_node()
      td_jpegdec: compute the correct structure size
      base: add codec update_params() callback
      adec: aac decoder implementation

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
