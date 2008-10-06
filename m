From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] OMAP 2/3 V4L2 display driver on
 video planes
Date: Mon, 6 Oct 2008 13:22:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810061320170.9028@anakin>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D61074A6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:49926 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbYJFLXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 07:23:48 -0400
Received: from winston.telenet-ops.be (unknown [195.130.137.75])
	by yergi.telenet-ops.be (Postfix) with ESMTP id 848F95CA847
	for <linux-omap@vger.kernel.org>; Mon,  6 Oct 2008 13:23:13 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D61074A6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shah, Hardik" <hardik.shah@ti.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "Hadli, Manjunath" <mrh@ti.com>, Mauro Carvalho Chehab <mchehab@infradead.org>

On Mon, 6 Oct 2008, Shah, Hardik wrote:
> > -----Original Message-----
> > From: Hans Verkuil [mailto:hverkuil@xs4all.nl]
> > On Monday 06 October 2008 08:06:30 Shah, Hardik wrote:
> > > > -----Original Message-----
> > > > From: Mauro Carvalho Chehab [mailto:mchehab@infradead.org]
> > > 4.  VIDIOC_S/G_OMAP2_COLORKEY:  Color keying allows the pixels with
> > > the defined color on the video pipelines to be replaced with the
> > > pixels on the graphics pipelines.  I believe similar feature must be
> > > available on almost all next generation of video hardware. We can add
> > > new ioctl for this feature in V4L2 framework. I think VIDIOC_S_FBUF
> > > ioctl is used for setting up the buffer parameters on per buffer
> > > basis.  So IMHO this ioctl is not a natural fit for the above
> > > functionality. Please provide your comments on same.
> > 
> > Do I understand correctly that if the color in the *video* streams
> > matches the colorkey, then it is replaced by the color in the
> > *framebuffer* (aka menu/overlay)? Usually it is the other way around:
> > if the framebuffer (menu) has chromakey pixels, then those pixels are
> > replaced by pixels from the video stream. That's what the current API
> > does
> [Shah, Hardik] This is a hardware provided feature. It can be both ways as
> hardware supports both the features. It means replacing the graphics
> pipelines pixels with video pipeline pixels and other way is also true.
> When both graphics and video pipelines are going to the same output device
> and when the colorkeying is enabled then the pixels of the video pipelines
> of specific color are replaced by the pixels of the graphics pipeline.
> This is done automatically done by the overlay manager aka compositor.
> Graphics pipeline can be controlled by frame buffer interface or V4L2
> interface.
> In driver we only need to enable the color keying and state that whether
> it is a source color keying or destination color keying along with the
> color code.

As video input usually contains noise: is it an exact color match, or a
range? IIRC, I saw a similar feature on a different chip some years ago,
and there the color key was a (YCbCr) range.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
