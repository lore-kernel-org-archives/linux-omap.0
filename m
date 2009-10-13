From: Gregoire Gentil <gregoire-cO8BdTktXKTQT0dZR+AlfA@public.gmane.org>
Subject: Re: New project announcement: gst-dsp, with beagleboard
 demo image
Date: Mon, 12 Oct 2009 23:26:13 -0700
Message-ID: <1255415173.27277.15.camel@gregoire-laptop>
References: <94a0d4530910121431r4f0e6d3dw2b87d22adc393842@mail.gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <grbounce-mhDLDAUAAACCWz0gcxlWH96hoF08oTo0=gchbu-beagleboard=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <94a0d4530910121431r4f0e6d3dw2b87d22adc393842-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/beagleboard/subscribe>,
	<mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: gstreamer-openmax-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gstreamer-embedded-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, maemo-developers-41UWDLvetLrYtjvyW6yDsg@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openmax-devel-8+VKa2cMCdNg9hUCZPvPmw@public.gmane.org, Eray =?ISO-8859-1?Q?=D6zt=FCrk?= <erayozturk1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Kang <paulchainkang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


It definitely seems to be a very nice effort that will be very useful to
many projects. I will integrate on the Touch Book. Thanks,

Gr=C3=A9goire

On Tue, 2009-10-13 at 00:31 +0300, Felipe Contreras wrote:
> Hi,
>=20
> This is the first public release of gst-dsp; a native GStreamer plug-in t=
o
> access Texas Instruments' DSP algorithms for OMAP3 platforms.
>=20
> The code came originally from a series of TI projects: tiopenmax[1], and
> libbridge[2]. gst-dsp replaces these two layers and talks directly to the=
 DSP
> bridge driver.
>=20
> The main advantages are code simplification (5k vs 50k), and better perfo=
rmance
> (at least 4 times less CPU usage). However, not all of the codecs have be=
en
> implemented, only MPEG-4 and H.263 video encoders and decoders, the JPEG
> encoder, and H.264 is partially supported.
>=20
> Currently it's used in the Nokia N900.
>=20
> In order to make it easier for people to try it out, I created a demo ima=
ge for
> the beagleboard with all the required components: GStreamer, gst-dsp, DSP
> public binaries, and a kernel with DSS2 and DSP bridge driver.
>=20
> The linux kernel (DSS2 + dspbridge) is at the v2.6.32-felipec1 tag in:
> http://gitorious.org/~felipec/linux-omap/felipec
>=20
> The DSP algorithms are public, and come from tiopenmax:
> https://gforge.ti.com/gf/download/frsrelease/170/1399/tiopenmax-0.3.5.tar=
.gz
>=20
> Here's the demo rootfs with the kernel image and instructions:
> http://people.freedesktop.org/~felipec/beagle-2.6.32-rc3/
>=20
> And here's the video showing it on action for both playback and recording=
:
> http://www.youtube.com/watch?v=3DSN-Nw_yDQUs
>=20
> The main repository is hosted on github:
> http://github.com/felipec/gst-dsp
>=20
> And there's also one specific for maemo:
> http://maemo.gitorious.org/maemo-multimedia/gst-dsp
>=20
> This code wouldn't have been possible without all the contributions and
> specially thanks to TI for making their code open source.
>=20
> Here's the shortlog for 0.6.0:
>=20
> Andriy Shevchenko (1):
>       base: fix a crash on send codec data
>=20
> Felipe Contreras (180):
>       Initial commit
>       Register dsp node
>       Add README
>       Fix and update copyrights
>       Add ALLOCATE_HEAP and ALLOCATE_SN to dsp_bridge
>       Add handy dsp_send_message
>       dummy: use dsp_send_message
>       Rename gstdsp.* to plugin.*
>       Makefile: cleanup
>       dummy: trivial clanups
>       Add log utility
>       Use log utility
>       dmm_buffer: size_t improvements
>       dmm_buffer: always unmap when freeing
>       dmm_buffer: use getpagesize()
>       dmm_buffer: alignment improvements
>       dmm_buffer: add user_data field
>       Add MPEG-4 video decoder
>       README: update
>       mp4vdec: trivial cleanup
>       mp4vdec: send signal to output_loop
>       mp4vdec: flush output buffers too
>       mp4vdec: reset output port
>       mp4vdec: extra check for null buffer
>       mp4vdec: use atomic operations for status
>       mp4vdec: use more atomic operations for status
>       mp4vdec: send stop signal before
>       mp4vdec: re-use comm buffers
>       dmm_buffer: reorganize a bit
>       dmm_buffer: add dmm_buffer_reserve
>       dmm_buffer: allow to re-reserve memory
>       dmm_buffer: allow re-mapping
>       mp4vdec: trivial cleanup
>       dmm_buffer: unmap before unreserving
>       mp4vdec: re-use mappings for output buffers
>       mp4vdec: convert flush condition to semaphore
>       Remove cond.h
>       Rename mp4vdec to vdec
>       vdec: trivial cleanup
>       vdec: trivial reorganization
>       vdec: prepare for multiple algos
>       vdec: move create_node to dsp_start
>       vdec: start dsp node after getting the caps
>       vdec: initial support for H.264
>       vdec: add Juha to authors list
>       README: update
>       vdec: cleanup
>       vdec: make dsp_thread static
>       vdec: reorganize a bit
>       New base class
>       Add new video encoder
>       base: handle more commands
>       base: reorganize got_message a bit
>       venc: improve jpeg args
>       venc: send jpeg dynamic params
>       base: cleanup setup_output_buffers
>       base: remove unused buffer_count
>       base: reorganize a bit
>       base: add use_pad_alloc option
>       base: free mapped buffers on dsp_stop()
>       base: be more verbose on get_slot()
>       README: update
>       Makefile: check for missing symbols
>       New utility gstdsp_register()
>       base: detect dsp errors
>       base: properly handle dsp errors
>       base: post error in the bus
>       base: extra check for status in outout_loop()
>       base: free events array
>       base: reinitialize state on NULL->READY
>       base: use circular buffer for timestamps
>       base: increase ts_array
>       base: increase mapping cache
>       dummy: reorganize map_buffer
>       dummy: input buffers don't need alignment
>       dummy: cleanup
>       dummy: don't map buffers
>       venc: increase framesize limit for jpeg
>       base: add gstdsp_post_error()
>       venc: allocate a buffer when framesize is unaligned
>       base: decrease wait for events timeout
>       base: more error messages
>       base: re-initialize on READY->PAUSED
>       base: don't panic on wrong status
>       base: destroy node at the right time
>       base: catch playback completed message
>       base: possible memleak fixes
>       vdec: send codec data for MPEG-4
>       base: make map cache optional
>       plugin: set more proper ranks
>       vdec: add framerate workaround
>       vdec: remove gstdsp_send_buffer()
>       base: add create_node() vmethod
>       base: add parsing facilities
>       Add h263 parser
>       parse: update framesize only when unset
>       Random cleanups
>       base: add support for stream params
>       venc: add H.263
>       venc: use h263 by default
>       Reorganize encoders
>       base: send codec data for all the codecs
>       base: keep trying if parse func fails
>       base: trivial cleanup
>       Trivial cleanups
>       log: don't display info level
>       log: decrease log level for buffer allocs
>       log: add pr_test
>       base: rename array to cache
>       base: rename 'buffer' to 'comm'
>       base: event cleanup
>       base: reorganize a bit
>       base: assume output buffer is always there
>       base: remove out_buffer, use port buffer
>       base: store input buffer
>       base: trivial cleanup
>       base: flush ports on stop
>       base: plug some possible leaks
>       base: make map_buffer() more conservative
>       base: trigger semaphore after buffer modifications
>       base: re-use input buffer
>       base: add port index field
>       Add async queue
>       base: allow multiple buffers
>       base: allow child elements to configure the ports
>       vdec: increase the number of buffers to 2
>       venc: trivial fixes
>       log: add missing include
>       base: re-enable queues properly
>       venc: decrease input buffer size
>       base: wait for eos
>       base: possible fix
>       Initial MPEG-4 video encoder support
>       gstdspvenc.h: preemptively add H.264 to the list
>       base: add send_codec_data() helper
>       vdec: use send_codec_data()
>       vdec: extra checks
>       Add skip hack
>       Revert "venc: forcing mpeg4 I frame each i_frame_interval"
>       venc: reorganize stream/dynamic params
>       base: trivial cleanup
>       base: properly set param virt addr
>       Add param argument to buffer callbacks
>       Add buffer argument to buffer callbacks
>       base: add buffer recv_cb
>       base: add check for end addr alignment
>       vdec: fix extra unref for codec-data
>       base: trivial cleanups
>       Rename dmm_buffer_flush() to dmm_buffer_clean()
>       base: fix memory read
>       dmm_buffer: clean instead of flush
>       dmm_buffer: add cache 'flush' function back
>       Use more proper cache functions
>       base: handle bad node termination
>       base: make EOS alignment an option
>       jpegenc: enable eos align
>       venc: improve integer framerate calculation
>       venc: fix bitrate calculation
>       venc: cleanup bitrate calculation
>       venc: remove jpeg from bitrate calculation
>       venc: tweak bitrate calculation
>       venc: trivial cleanups
>       venc: add 'quality' field
>       venc: calculate smaller buffer sizes
>       Fix some static analysis warnings
>       log: avoid pr_info when gst debugging is off
>       base: remove use_map_cache
>       Trivial cleanups
>       Cleanup type registrations
>       base: improve some compiler hints
>       dmm-buffer: check cache flush size
>       base: properly free node resources
>       Create custom dsp_node_t
>       dsp-bridge: store node heap ourselves
>       dsp-bridge: store node msgbuf ourselves
>       dsp-bridge: cleanup node_free
>       base: copy buffers when appropriate
>       base: remove unnecessary cache flushing
>       venc: set rate-control to variable
>       base: post critical error mesages to the bus
>=20
> Hoseok Chang (1):
>       venc: tune mp4v parms for better performance
>=20
> Juha Alanen (5):
>       vdec: set profile based on the frame size
>       vdec: improve H.263 args
>       vdec: initial support for WMV9
>       venc: set profile correctly for H.263 and MPEG4
>       venc: disable single scan output for JPEG encoder
>=20
> Marco Ballesio (8):
>       vdec: fix srcpad setup
>       venc: rename mp4venc_stream_params
>       venc: add mp4venc_out_stream_params
>       base: use proper buffer length
>       venc: forcing mpeg4 I frame each i_frame_interval
>       venc: reordered mp4venc_args initialization
>       venc: added bitrate computation formula
>       venc: propagate keyframes properly
>=20
> Mark Nauwelaerts (2):
>       base: safer buffer allocation and freeing
>       base: fix element ref leak
>=20
> Miguel Verdu (2):
>       venc: tune MPEG-4 parameters
>       venc: tune MPEG-4 parameters for quality
>=20
> Ren=C3=A9 Stadler (3):
>       base: fix thread leak
>       base: advance timestamp pointer for empty output buffers
>       base: don't use DSP flushing
>=20
> Tim-Philipp M=C3=BCller (1):
>       base: unref unused output buffer when skipping output
>=20
> Cheers.
>=20
> [1] https://gforge.ti.com/gf/project/openmax/
> [2] https://gforge.ti.com/gf/project/omapbridge/
>=20
