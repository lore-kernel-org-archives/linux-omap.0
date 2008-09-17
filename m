From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on
	video planes
Date: Wed, 17 Sep 2008 21:12:08 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD770929@dbde02.ent.ti.com>
References: <48D1227D.5070207@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <48D1227D.5070207@nokia.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sakari Ailus <sakari.ailus@nokia.com>, "Shah, Hardik" <hardik.shah@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

Hi Ailus,

Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

> -----Original Message-----
> From: video4linux-list-bounces@redhat.com [mailto:video4linux-list-bounces@redhat.com] On Behalf Of
> Sakari Ailus
> Sent: Wednesday, September 17, 2008 9:00 PM
> To: Shah, Hardik
> Cc: video4linux-list@redhat.com; linux-omap@vger.kernel.org; linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on video planes
> 
> Hi, Hardik!
> 
> ext Hardik Shah wrote:
> > diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
> > index 2703c66..e899dd2 100644
> > --- a/drivers/media/video/Kconfig
> > +++ b/drivers/media/video/Kconfig
> > @@ -762,8 +762,6 @@ source "drivers/media/video/au0828/Kconfig"
> >
> >  source "drivers/media/video/ivtv/Kconfig"
> >
> > -source drivers/media/video/omap/Kconfig
> > -
> >  source "drivers/media/video/cx18/Kconfig"
> >
> >  config VIDEO_M32R_AR
> > @@ -802,6 +800,14 @@ config VIDEO_OMAP2
> >  	---help---
> >  	  Driver for an OMAP 2 camera controller.
> >
> > +config VIDEO_OMAP3
> 
> This is the same configuration option as we are using for the OMAP 3
> camera driver at the moment.
> 
> Could you, for example, call this VIDEO_OMAP3_VIDEOOUT?
> 
> CONFIG_VIDEO_OMAP2 enables the OMAP 2 camera driver.
> 
I am aware of camera config options, but since now V4l started supporting
output devices (like display) widely, we should have some meaningful
config options here. I propose something following -

config VIDEO_OMAP3
        bool "OMAP2/OMAP3 V4L2 drivers"
        depends on VIDEO_DEV && (ARCH_OMAP24XX || ARCH_OMAP34XX)
        default y
        help
          V4L2 DSS driver support for OMAP2/3 based boards.

source "drivers/media/video/omap/Kconfig"

config VIDEO_OMAP3_CAMERA
        tristate "OMAP 3 Camera support"
        select VIDEOBUF_GEN
        select VIDEOBUF_DMA_SG
        select VIDEO_OMAP3_ISP
        depends on VIDEO_V4L2 && ARCH_OMAP34XX && VIDEO_OMAP3
        default VIDEO_OMAP3
        ---help---
          Driver for an OMAP 3 camera controller.

source "drivers/media/video/isp/Kconfig"


> > diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
> > index 3e580e8..10f879c 100644
> > --- a/drivers/media/video/Makefile
> > +++ b/drivers/media/video/Makefile
> > @@ -107,6 +107,8 @@ obj-$(CONFIG_VIDEO_CAFE_CCIC) += cafe_ccic.o
> >  obj-$(CONFIG_VIDEO_OV7670) 	+= ov7670.o
> >
> >  obj-$(CONFIG_VIDEO_OMAP2) += omap24xxcam.o omap24xxcam-dma.o
> > +obj-$(CONFIG_VIDEO_OMAP3) += omap/
> 
> It's just two C source code files --- how about putting them into the
> parent directory? The omap directory has just one driver in it, the OMAP
> 1 camera driver. I think at some point it was intended to be moved to
> the parent directory although this hasn't happened.
> 

But with addition of V4L2 display patch the number of files got increased, now we
have 4 files for display driver. I would prefer other way, move OMAP specific files
to omap directory.

> Best regards,
> 
> --
> Sakari Ailus
> sakari.ailus@nokia.com
> 
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
