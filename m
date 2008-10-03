From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [PATCH] OMAP 2/3 V4L2 display driver on video planes
Date: Fri, 3 Oct 2008 20:10:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D603E9FB@dbde02.ent.ti.com>
References: <200810031633.43418.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYJCOlJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:41:09 -0400
In-Reply-To: <200810031633.43418.hverkuil@xs4all.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>


> -----Original Message-----
> From: Hans Verkuil [mailto:hverkuil@xs4all.nl]
> Sent: Friday, October 03, 2008 8:04 PM
> To: video4linux-list@redhat.com
> Cc: Shah, Hardik; linux-omap@vger.kernel.org; linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on video planes
> 
> On Wednesday 17 September 2008 17:05:42 Hardik Shah wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > OMAP 2/3 V4L2 display driver sits on top of DSS library
> > and uses TV overlay and 2 video pipelines (video1 and video2)
> > to display image on TV. It exposes 2 V4L2 nodes for user
> > interface.
> > It supports standard V4L2 ioctls.
> >
> > Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
> > 		Hari Nagalla <hnagalla@ti.com>
> > 		Hardik Shah <hardik.shah@ti.com>
> > 		Manju Hadli <mrh@ti.com>
> > 		R Sivaraj <sivaraj@ti.com>
> > 		Vaibhav Hiremath <hvaibhav@ti.com>
> 
> I've taken a quick look and I have a two main comments:
> 
> 1) Please use video_ioctl2 rather than setting up your own ioctl
> callback. New drivers should use it.
> 
> 2) Can you describe what the non-standard v4l2 ioctls are used for? I
> suspect that some of these can be done differently. Something like a
> chromakey is already available in v4l2 (through VIDIOC_G/S_FBUF and
> VIDIOC_G/S_FMT), things like mirror is available as a control, and
> rotation should perhaps be a control as well. Ditto for background
> color. These are just ideas, it depends on how it is used exactly.
[Shah, Hardik] Hans I will revisit the code and will provide you with the sufficient information.
> 
> 3) Some of the lines are broken up rather badly probably to respect the
> 80 column maximum. Note that the 80 column maximum is a recommendation,
> and that readability is more important. So IMHO it's better to have a
> slightly longer line and break it up at a more logical place. However,
> switching to video_ioctl2 will automatically reduce the indentation, so
> this might not be that much of an issue anymore.
[Shah, Hardik] 80 column was implemented to make the checkpatch pass.  Point noted and will take care of this.
> 
> It is possible to setup a mercurial repository on linuxtv.org? I thought
> that Manju has an account by now. This is useful as well for all the
> other omap camera patches. I've seen omap patches popping up all over
> the place for the past six months (if not longer) but it needs to be a
> bit more organized if you want it to be merged. Setting up v4l-dvb
> repositories containing the new patches is a good way of streamlining
> the process.
> 
> Obviously the process is more complicated for you since the omap stuff
> relies on various subsystems and platform code. Perhaps someone within
> TI should be coordinating this?
[Shah, Hardik] we are in process of coordinating this.
> 
> Regards,
> 
> 	Hans
> 
> > ---
> >  drivers/media/video/Kconfig             |   10 +-
> >  drivers/media/video/Makefile            |    2 +
> >  drivers/media/video/omap/Kconfig        |   12 +
> >  drivers/media/video/omap/Makefile       |    2 +
> >  drivers/media/video/omap/omap_vout.c    | 3524
> > +++++++++++++++++++++++++++++++
> > drivers/media/video/omap/omap_voutdef.h |  196 ++
> >  drivers/media/video/omap/omap_voutlib.c |  283 +++
> >  drivers/media/video/omap/omap_voutlib.h |   34 +
> >  include/linux/omap_vout.h               |   60 +
> >  9 files changed, 4121 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/media/video/omap/omap_vout.c
> >  create mode 100644 drivers/media/video/omap/omap_voutdef.h
> >  create mode 100644 drivers/media/video/omap/omap_voutlib.c
> >  create mode 100644 drivers/media/video/omap/omap_voutlib.h
> >  create mode 100644 include/linux/omap_vout.h

