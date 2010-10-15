From: Gary Thomas <gary@mlbassoc.com>
Subject: Camera/ISP questions
Date: Fri, 15 Oct 2010 16:56:30 -0600
Message-ID: <4CB8DC1E.6050002@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:60090 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab0JOW4c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 18:56:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Discussion of the angstrom distribution development <angstrom-distro-devel@linuxtogo.org>

Sorry for cross-posting, but I'm not sure where best to get help :-(

I'm working on an OMAP/3530 board (similar to the BeagleBoard,
but of local design).  I'm using the 2.6.32+ kernel from Angstrom
which has the DVSDK support, including ISP camera support using
V4L2.  My camera is NTSC or PAL composite input through a TVP5150m1
decoder into the ISP, using 8 bit BT-656 data.  This mostly works,
but I'm suffering some strange problems.  My queries to the TI forums
have not yielded any [useful] feedback, so I'm hoping someone on these
lists can help.

I'm wondering if the BT-656 data from the TVP5150m1 device is compatible
with the ISP, based on the comments in TRM 12.1.1 which implies that
interlaced data is not supported via BT-656 and I'm pretty sure the
data from the TVP _is_ interlaced since it came from an interlaced
TV/video camera.  Of course, I could be reading this incorrectly...

My problem is the raw data from the ISP (UYVY422, grabbed using
gstreamer v4l2src (*)) does not seem to be quite right.  If I just
look at it, e.g.
   gst-launch v4l2src ! 'video/x-raw-yuv,width=720,height=576,format=(fourcc)UYVY' ! \
              ffmpegcolorspace ! 'video/x-raw-yuv,format=(fourcc)YV12' ! xvimagesink
the images will "tear" and streak if there is any motion.  Sometimes,
there are ghosts (faded after-images) left behind that last for many
seconds.  Eventually, they will clear up, especially if the image
becomes more static.  If I try to do much more processing of these images,
e.g. encode them into some compressed format like H264, the results
are horrible.

(*) I also wrote a very simple program to grab the data from the camera
instead of using gstreamer v4l2src.  This produces the same poorly constructed
UYVY stream, so I don't think the problem is in the v4l2src component (but
it _could_ be in the v4l2 kernel code, but it doesn't really do anything
with the camera data except for managing the DMA+buffers)

I created a known data source (not from the camera interface), using
ffmpeg to produce a UYVY422 data file from an MP4 that I know looks good.
I used this to test the back-end of the pipeline.  It does not suffer these
problems, even when the image has lots of motion.

What leads me to think this is all about the camera/ISP path
is that if I introduce a scaling component, I get even stranger
results.  For example, this pipeline
   gst-launch v4l2src always-copy=FALSE ! video/x-raw-yuv,width=720,height=576 ! \
              TIVidResize name=qos-scaler contiguousInputFrame=TRUE ! \
              'video/x-raw-yuv,format=(fourcc)UYVY,width=320,height=240' !
              ffmpegcolorspace ! 'video/x-raw-yuv,format=(fourcc)YV12' ! xvimagesink
often has a Venetian-blind look - alternating good data with dark grey
bars (that seem to have the desired data underneath).  The image tearing
and ghosting is much exaggerated.

Running that same pipeline with the known good UYVY data file does
not exhibit these behaviours.

Does anyone have any ideas what might be causing these problems?
Ever seen such before?
Any ideas what I can look at or, if necessary, a better place to ask?
I'm pretty sure I'm up against hardware problems (could be the design,
could be the driver or configuration).

If anyone has ideas or can help and need to see any of these data, I'll
gladly provide them.

Thanks for any help/ideas

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
