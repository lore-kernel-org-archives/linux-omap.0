From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter Card
 Support
Date: Thu, 29 Jan 2009 12:17:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA78FFBC@dbde02.ent.ti.com>
References: <20090107083931.226e1898@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20090107083931.226e1898@pedra.chehab.org>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Mauro Carvalho Chehab [mailto:mchehab@infradead.org]
> Sent: Wednesday, January 07, 2009 4:10 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; video4linux-list@redhat.com; linux-
> media@vger.kernel.org
> Subject: Re: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter
> Card Support
> 
> On Wed, 7 Jan 2009 15:51:53 +0530
> "Hiremath, Vaibhav" <hvaibhav@ti.com> wrote:
> 
> 
> > [Hiremath, Vaibhav] Mauro, the Daughter card not only supports
> TVP1546/sensor but also supports USB EHCI. So this driver may not be
> fit into V4L driver. Daughter card driver (board-omap3evm-dc.c) only
> does basic initialization which happens during arch_init. The
> underneath V4L drivers are omap34xxcam.c (drivers/media/video) and
> TVP514x.c (drivers/media/video).
> 
> Understood. This makes things a little more complicated. I suggest
> then to
> split the V4L specific part into a separate file, in order to allow
> a better
> maintenance (something like board-omap3evm-dc-v4l.c), since I'd like
> to review
> the changes there.
> >
[Hiremath, Vaibhav] Mauro sorry for delayed response, again as I mentioned I was busy with our internal commitments. 

I do agree with your point and will change accordingly. Now the config option will look like something - 

Arch/arm/mach-omap2/Kconfig - 

config MACH_OMAP3EVM_MMDC
        bool "OMAP 3530 EVM Mass Market daughter card board"
        depends on ARCH_OMAP3 && ARCH_OMAP34XX && MACH_OMAP3EVM

arch/arm/mach-omap2/Makefile - 

obj-$(CONFIG_MACH_OMAP3EVM_MMDC)        += board-omap3evm-dc-v4l.o

In the future we may want to add board-omap3evm-dc-usb.c under the same option.

> > > > +/* include V4L2 camera driver related header file */
> > > > +#if defined(CONFIG_VIDEO_OMAP3) ||
> > > defined(CONFIG_VIDEO_OMAP3_MODULE)
> > > > +#include <../drivers/media/video/omap34xxcam.h>
> > > > +#include <../drivers/media/video/isp/ispreg.h>
> > > > +#endif				/* #ifdef CONFIG_VIDEO_OMAP3 */
> > > > +#endif				/* #ifdef CONFIG_VIDEO_TVP514X*/
> > >
> > > Please, don't use ../* at your includes. IMO, the better is to
> > > create a
> > > drivers/media/video/omap dir, and put omap2/omap3 files there,
> > > including board-omap3evm-dc.c.
> > > This will avoid those ugly includes.
> > >
> > [Hiremath, Vaibhav] I do agree with this. I have mentioned this in
> my TODO list.
> 
> A cleaner solution is to add something like this at the Makefile:
> 
> EXTRA_CFLAGS += -Idrivers/media/video
> EXTRA_CFLAGS += -Idrivers/media/video/isp
> 
> Then, all you need to do is to use:
> 
> #include <omap34xxcam.h>
> #include <ispreg.h>
> 
> >
> > > Btw, drivers/media/video/isp/ currently doesn't exist. Please
> submit
> > > the patch for it first.
> > >
[Hiremath, Vaibhav] I do agree with this, but I have seen there are some other board specific files including the header files in this way, 
arch/arm/mach-omap2/board-n800-camera.c
arch/arm/mach-omap2/board-n800.c

> > [Hiremath, Vaibhav] Following up with Sergio on this, and soon
> will be available.
> 
> Ok, thanks.
> 
> Cheers,
> Mauro

