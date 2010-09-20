From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANN] gst-dsp 0.8.0 released
Date: Mon, 20 Sep 2010 12:45:34 +0300
Message-ID: <AANLkTinAbBNWpd3eR_mVJMBED7QEkb35KfME-qhomd2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36011 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab0ITJpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 05:45:35 -0400
Received: by yxp4 with SMTP id 4so1246553yxp.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Sep 2010 02:45:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gst-dsp@googlegroups.com
Cc: gstreamer-embedded@lists.sourceforge.net, linux-omap@vger.kernel.org, beagleboard@googlegroups.com

Hi,

gst-dsp is a GStreamer plug-in to utilize Texas Intruments' DSP
algorithms for OMAP3 platforms using the tidspbridge driver.

This is a major release, many features have been implemented:

 * Refactoring of DMA API
 * Fixes for newer DSP API versions
 * Add JPEG decoder implementation
 * Fix WMV support
 * Reorganize the way EOS is handled
 * Improve H.264 keyframe handling
 * Improve deinitialization on fatal errors (like MMU faults)
 * Fixes for ARMv7 speculative pre-fetching
 * Several improvements for encoding bitrate calculation
 * Add support for I420 color format
 * Correctly propagate aspect-ratio

And the usual bunch of cleanups and reorganization.

Also it's worth noting that this code has been tested on Nokia N900,
beagleboard, and future Nokia hw; with different DSP binaries;
L23.i3.8, L23.i3.3, and 0.3.5; and different DSP bridge driver
versions. For very old binaries, build with DSP_API=3D0, it's not
necessary to set SN_API yet, as the structures are binary compatible
with all the versions.

Moreover, this time I decided to package, this, and some related
packages in tarballs in order to help some distributions:
http://code.google.com/p/gst-dsp/downloads

This time we have slightly more contributors, including even some
patches from TI. Thanks everyone!

Unfortunately this is still not ready for 1.0, the parsers need to be
cleaned up, fixed, and merged. And once tidspbridge 0.4 is tagged,
move to the new DMA API ioctls.

=46inally, most likely the core of gst-dsp will move to a separate
library (not related to GStreamer): libtidsp, in order to be useful in
other projects. A sample of that has been submitted to FFmpeg for
review:
http://article.gmane.org/gmane.comp.video.ffmpeg.devel/116798

Enjoy ;)

Arvind Gupta (3):
      vdec: MPEG4 sn to use double buffer
      hack: venc: strip SPS and PPS headers on keyframes
      vdec: return last frame EOS from MPEG4, H.263 and WMV decoders

=46elipe Contreras (111):
      venc: fix default mode
      base: reorganize status check in output_loop()
      base: reorganize error checks in output_loop()
      log: fix log level 3 when DEBUG is on
      base: continue deinit on errors
      base: make sure stop message was sent
      base: detect algorithm errors
      base: don't print messages as errors
      base: reorganize error handling a bit
      base: exit dsp_thread more cleanly
      Allow more granularity in dspbridge API
      build: add DSP_API option
      Plug a few memleaks when node_create() fails
      bridge: trivial cleanups
      bridge: fix a small exceptional leak
      vdec: always clear params
      build: add option for socket-node API version
      Trivial cleanups
      dmm-buffer: we are using a proc handle, not node
      base: avoid yoda conditions
      base: improve send_buffer()
      venc: remove unnecessary buffer_clean()s
      dummy: invalidate before sending
      vdec: remove h264dec_in_stream_params
      Trivial cleanups
      base: check for errors in dsp_wait_for_events()
      base: avoid buffer duplication on corner-case
      Refactor some code into dmm_buffer_calloc()
      Refactor code into gstdsp_port_setup_params()
      Add new gstdsp_send_alg_ctrl()
      base: free alg_ctrl on exceptions
      Rework cache maintainance functions
      base: always invalidate out buffers afterwards
      Add DMA direction information
      Start using new DMA API
      dmm-buffer: remove _unmap()
      dmm-buffer: we know the page size
      dmm-buffer: let's not be too smart about unreserve
      dmm-buffer: put map and reserve together
      Manually call dmm_buffer_map()
      Add manual calls to dmm_buffer_unmap()
      dmm-buffer: remove clean/invalidate/flush
      build: general improvements
      venc: fix for MPEG-4 SN_API=3D1
      venc: add keyframe-interval property
      Move ARRAY_SIZE to util.h
      vdec: log actual SN used
      Trivial improvements
      venc: improve bitrate calculation
      vdec: propagate aspect-ratio
      Support multiple SN_API's
      venc: register conversions library for jpegenc
      venc: fix jpegenc params
      Remove unnecessary assigns
      build: add dist target
      bridge: fix bad ioctls
      bridge: update copyright
      log: generic improvements
      vdec: fix trivial warning
      build: check for deprecated gst stuff
      Fix depreated stuff from gst
      vdec: trivial cleanup
      Create ports in base class
      log: trivial whitespace cleanups
      Update copyright notices
      Update licence notices
      Add LICENSE file
      build: only link to needed libraries
      get-version: trivial improvements
      build: a bit more warnings
      parse: fix compilation warning
      base: don't loose buffers on EOS
      base: fix a non-atomic check for self->status
      base: use atomic 'deferred_eos' instead of 'eos'
      base: reorganize EOS handling
      base: remove redundant checks for use_eos_align
      base: clear deferred_eos when appropriate
      base: refactor code into pause_task()
      Remove 'use_eos_align'
      base: a few more compiler hints
      venc: extract codec-data for MPEG-4
      venc: simplify avr mode workaround
      venc: trivial cleanups
      hack: h264enc: manually force keyframes
      venc: add property for intra-refresh
      venc: fix check_supported_levels()
      venc: pick max bitrate at same level of mbps
      venc: limit max_bitrate to the true maximum
      venc: add check for invalid level
      venc: cap bitrate to max_bitrate
      venc: remove redundant max_bitrate check for H.264
      vdec: calculate real coded framesize
      vdec: add crop framesize
      vdec: update buffer len based on crop size
      base: update gst buffersize based on dmm_buffer len
      Rename dsp_{start,stop}
      dmm_buffer: whitespace cleanups
      bridge: whitespace cleanups
      bridge: trivial cleanups
      bridge: reorganize return code handling
      bridge: cleanup return codes
      bridge: remove typedefs
      Remove usage of typedefs
      bridge: truly remove typedefs
      dummy: use correct socket-node
      dummy: fix mapping sequence
      dummy: improve mapping
      Trivial cleanups
      dummy: add proper DSP event handling
      dummy: improve error handling
      Update README

Juha Alanen (7):
      vdec: update WMV create phase parameters
      base: use hexadecimal format when printing the error code
      vdec: register conversions library
      vdec: add send_cb for MPEG4 decoder
      vdec: add recv_cb for MPEG4 decoder
      vdec: enable {send,recv}_cb for H.263 decoder
      venc: fix supported levels for H.264

Karunesha Uh (2):
      vdec: add support for I420
      base: add virtual method flush_frames

Laxman Raju (1):
      venc: set right profile for JPEG enc

Marco Ballesio (1):
      hack: venc: avoid intra frame interval

Mark Nauwelaerts (16):
      base: appropriately flush queued events
      base: keyframe marking must be thread-safe
      base: additional checks for NULL buffers
      base: ensure codec data is sent to node and not silently dropped
      base: enhance eos aligned EOS sending
      venc: add support for I420 YUV format
      base: disable queues when pausing src task
      base: free comm buffers in dsp_stop
      base: do not consume buffer timestamp for a 0-length output buffe=
r
      venc: adjust h264 encoder frametype check
      base: more state variable cleanup when stopping
      base: add reset() vmethod
      venc: implement reset() vmethod for state variable cleanup
      vdec: fix codec-data transformation
      venc: update jpegenc params to release L23.i3.4
      venc: no automagic changes to property values

Martin Storsjo (1):
      bridge: fix for DSP_API=3D0

Miguel Verdu (2):
      venc: add supported levels
      venc: H.264 CBR mode uses CIR

Olivier Cr=C3=AAte (1):
      venc: add max-bitrate property

Raju Laxman (1):
      venc: update jpeg encoder API

Tommi My=C3=B6h=C3=A4nen (1):
      base: check EOS before reallocating out buffer

V=C3=ADctor Manuel J=C3=A1quez Leal (23):
      bridge: add dsp_node_connect()
      bridge: add dsp_stream_open()
      bridge: add dsp_stream_close()
      bridge: add dsp_stream_allocate_buffers()
      bridge: add dsp_stream_idle()
      bridge: add dsp_stream_get_info()
      bridge: add dsp_stream_reclaim()
      bridge: add dsp_stream_free_buffers()
      bridge: add dsp_stream_issue()
      dsp-bridge: check for attr before deferring
      base: add du_port_alloc_buffers()
      base: delay the comm port allocation
      Delay allocation of port buffers
      jpegdec: initial implementation
      bridge: dsp_uuid_t normally is const
      vdec: add and use configure_caps()
      vdec: i420 support for jpgdec
      vdec: check for structures in caps
      vdec: allowed_caps makes more sense
      vdec: trivial cleanup
      bridge: add dsp_stop()
      bridge: add dsp_load()
      bridge: add dsp_start()

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
