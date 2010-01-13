From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANN] gst-dsp 0.7.0 released
Date: Thu, 14 Jan 2010 00:07:09 +0200
Message-ID: <94a0d4531001131407r46b6a428i493cfaceef69d65a__11873.5519041822$1263420457$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:34931 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab0AMWHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 17:07:09 -0500
Received: by mail-iw0-f197.google.com with SMTP id 35so16751105iwn.4
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 14:07:09 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gst-dsp <gst-dsp@googlegroups.com>
Cc: gstreamer-embedded@lists.sourceforge.net, beagleboard@googlegroups.com, linux-omap@vger.kernel.org

Hi,

gst-dsp is GStreamer plug-in to utilize Texas Intruments' DSP
algorithms for OMAP3 platforms (using dsp-bridge). It's used in the
official Nokia N900 system, but should work on any platform (has been
tested on beagleboard).

It's time for the next release. There have been a huge amount of
changes, mostly for stabilization, but also some new features:

 * dynamic bitrate for venc
 * support to force keyfrane on venc
 * WMV support
 * Improved H.264 decoder support
 * New H.264 video encoder
 * Improved venc latency

In general it seems almost ready for the 1.0 release... once the WMV3
issues have been solved, and the parsers are finalized.

Thanks to all the people that contributed to this release. Here's the s=
hortlog:

=46elipe Contreras (49):
      Makefile: trivial cleanup
      plugin: update ranks to primary
      Trivial cleanups
      base: add a few more branch prediction hints
      h264enc: enable bytestream by default
      h264enc: fix default bytestream mode
      New skip hack
      venc: cleanup some cache operations
      Implement multiple parameters
      venc: use a global frame_index
      venc: increase number of buffers
      Makefile: trivial cleanup
      venc: improve setcaps()
      venc: enable packet-mode for H.263
      venc: disable unrestricted mv for H.263
      venc: set a more proper intra_frame_interval
      venc: h264enc: mark keyframes
      log.h: fix trivial warnings
      vdec: refactor sink_setcaps a bit
      get-version: trivial cleanup
      vdec: trivial cleanups
      dummy: trivial code-style fixes
      dsp-bridge: add proc get info stuff
      dsp-bridge: make dsp_node_get_attr() public
      dsp-bridge: add dsp_enum_nodes()
      log: generic improvements
      vdec: setup h264 params
      venc: add missing buffer clean for jpegenc
      venc: add bitrate property
      jpegenc: force ports to have only one buffer
      log: reorganization for better pr_test
      venc: support dynamic bitrate configuration
      Makefile: add -fPIC
      Trivial cleanups
      {venc,vdec}: rename {send,recv}_cb
      {venc,vdec}: add send_cb for output buffers
      base: trivial simplification
      Update code style for switches
      Trivial parent_class improvements
      base: add {src,sink}_event virtual methods
      venc: add empty event handlers
      venc: add finalize function
      venc: initial 'force keyframe' support
      venc: store event to push downstream
      venc: add upstream 'force keyframe' support
      base: safety check for buffer length
      venc: add 'mode' property
      venc: start using 'mode' property
      venc: set rate control based on the mode

Juha Alanen (12):
      Initial support for H.264 encoder
      venc: add generic and h264 specific structs
      venc: add bytestream property for h264
      venc: add recv_buffer callback for h264
      vdec: modify MPEG4 create phase parameters
      base: use proper buffer length in send_buffer
      vdec: modify some WMV parameters
      vdec: add support for WMV3 decoding
      vdec: add support for WVC1 decoding
      vdec: add recv_cb for wmv
      vdec: send dynamic parameters for wmv
      vdec: update frame index in wmvdec_send_cb

Mark Nauwelaerts (8):
      vdec: call send_cb earlier
      base: make error handler helper public
      vdec: add priv_data for h264 lol
      vdec: add h264dec_transform_codec_data
      vdec: transform h264 buffers to bytestream
      vdec: cater for h264 node output parameters
      vdec: add extra size checks for h264 transform
      vdec: handle the case where NAL size prefix is < 3

Tim-Philipp M=C3=BCller (3):
      base: fix some minor but recurrent memory leaks
      Fix refcount leak when setting up pad templates
      base: don't leak input buffer if we have a non-OK flow return

Youness Alaoui (1):
      Plugin a leak on video encoders

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
