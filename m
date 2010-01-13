From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [ANN] gst-dsp 0.7.0 released
Date: Thu, 14 Jan 2010 00:07:09 +0200
Message-ID: <94a0d4531001131407r46b6a428i493cfaceef69d65a__21286.0672771514$1263420479$gmane$org@mail.gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e645ba44007a64047d12fe95
Return-path: <3EEROSwAAC-0QTPVaTQdPgSVddVaTVgdjeh.Rdb-JX7+OpRa80S8N/ZHIG5xj07CuiCeIGUxQQ4Iyu8u01E@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=>,
	<mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=>,
	<mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=>,
	<mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: gst-dsp <gst-dsp-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: gstreamer-embedded-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--0016e645ba44007a64047d12fe95
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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

Thanks to all the people that contributed to this release. Here's the short=
log:

Felipe Contreras (49):
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
Felipe Contreras

--0016e645ba44007a64047d12fe95
Content-Type: text/plain; charset=ISO-8859-1

-- 
You received this message because you are subscribed to the Google Groups "Beagle Board" group.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/beagleboard?hl=en.



--0016e645ba44007a64047d12fe95--
