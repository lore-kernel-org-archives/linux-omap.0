From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display
 options on OMAP3
Date: Tue, 16 Nov 2010 15:50:37 +0200
Message-ID: <1289915437.2668.107.camel@tubuntu>
References: <1288063074-8879-1-git-send-email-samreen@ti.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:47386 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565Ab0KPNut (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 08:50:49 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nilofer, Samreen" <samreen@ti.com>, ext Tony Lindgren <tony@atomide.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-11-16 at 07:09 +0100, ext Nilofer, Samreen wrote:
> Hi,
>   Any more comments on this patch?

I'm not sure if enabling kernel options by default is a good thing.
Somehow I remember that enabling things by default is not looked kindly
at. Shouldn't they be enabled in the arch/arm/configs config file, if
they are wanted?

Tony, do you have opinnion on this? Should DSS features be enabled by
default in the Kconfig files, or only in the board config file?

Also, see one comment inline.

> Warm Regards,
> Samreen 
> Nilofer, Samreen wrote:
> > The defconfig options for display are taken in the respective
> > Kconfig to enable display by default on OMAP3 platforms
> > 
> > Signed-off-by: Samreen <samreen@ti.com>
> > ---
> >  Version4:
> >        Remove the enabling of the display panels by default.
> > 
> >  Version3:
> >        Eliminate the separate default number of FBs for
> > different architecture. Keeping default FBs as 3 as before.
> > 
> >  Version2:
> >         Enables by default NEC panel used in zoom2/3/3630sdp,
> > instead of  Sharp LQ043T1DG01 panel enabled in previous
> > version of this patch.
> > 
> >  drivers/video/omap2/dss/Kconfig    |    6 ++++--
> >  drivers/video/omap2/omapfb/Kconfig |    1 +
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/omap2/dss/Kconfig
> > b/drivers/video/omap2/dss/Kconfig index 43b6440..f3244a2 100644
> > --- a/drivers/video/omap2/dss/Kconfig
> > +++ b/drivers/video/omap2/dss/Kconfig
> > @@ -1,6 +1,7 @@
> >  menuconfig OMAP2_DSS
> >          tristate "OMAP2/3 Display Subsystem support (EXPERIMENTAL)"
> >          depends on ARCH_OMAP2 || ARCH_OMAP3
> > +	default y
> >          help
> >            OMAP2/3 Display Subsystem support.
> > 
> > @@ -9,7 +10,7 @@ if OMAP2_DSS
> >  config OMAP2_VRAM_SIZE
> >  	int "VRAM size (MB)"
> >  	range 0 32
> > -	default 0
> > +	default 4
> >  	help
> >  	  The amount of SDRAM to reserve at boot time for video RAM use.
> >  	  This VRAM will be used by omapfb and other drivers
> > that need @@ -102,7 +103,8 @@ config OMAP2_DSS_FAKE_VSYNC
> > config OMAP2_DSS_MIN_FCK_PER_PCK
> >  	int "Minimum FCK/PCK ratio (for scaling)"
> >  	range 0 32
> > -	default 0
> > +	default 4  if ARCH_OMAP2 || ARCH_OMAP3
> > +	default 0  if ARCH_OMAP4

I think having default ratio of 4 would mean that for example high res
modes wouldn't work on beagle. They require high pixel clock, which
requires 1/2 pck/lck ratio.

> >  	help
> >  	  This can be used to adjust the minimum FCK/PCK ratio.
> > 
> > diff --git a/drivers/video/omap2/omapfb/Kconfig
> > b/drivers/video/omap2/omapfb/Kconfig
> > index 65149b2..923bf48 100644
> > --- a/drivers/video/omap2/omapfb/Kconfig
> > +++ b/drivers/video/omap2/omapfb/Kconfig
> > @@ -1,6 +1,7 @@
> >  menuconfig FB_OMAP2
> >          tristate "OMAP2/3 frame buffer support (EXPERIMENTAL)"
> >          depends on FB && OMAP2_DSS
> > +	default y
> > 
> >  	select OMAP2_VRAM
> >  	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3


