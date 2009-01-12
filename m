From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [Linux-fbdev-devel] [PATCH 02/12] DSS: Display subsystem for
	OMAP2/3
Date: Mon, 12 Jan 2009 18:36:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E67825AE@dbde02.ent.ti.com>
References: <20090112130158.GF9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55400 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbZALNG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 08:06:56 -0500
In-Reply-To: <20090112130158.GF9373@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Monday, January 12, 2009 6:32 PM
> To: Tomi Valkeinen
> Cc: linux-fbdev-devel@lists.sourceforge.net; linux-omap@vger.kernel.org
> Subject: Re: [Linux-fbdev-devel] [PATCH 02/12] DSS: Display subsystem for
> OMAP2/3
> 
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [090112 14:37]:
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > ---
> >
> >  arch/arm/plat-omap/Kconfig                |    2
> >  arch/arm/plat-omap/Makefile               |    2
> >  arch/arm/plat-omap/dss/Kconfig            |   71 +
> >  arch/arm/plat-omap/dss/Makefile           |    6
> >  arch/arm/plat-omap/dss/dispc.c            | 2113
> +++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/dss/display.c          |  787 +++++++++++
> >  arch/arm/plat-omap/dss/dpi.c              |  344 +++++
> >  arch/arm/plat-omap/dss/dss.c              |  774 +++++++++++
> >  arch/arm/plat-omap/dss/dss.h              |  274 ++++
> >  arch/arm/plat-omap/dss/sdi.c              |  174 ++
> >  arch/arm/plat-omap/include/mach/display.h |  462 ++++++
> >  11 files changed, 5009 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-omap/dss/Kconfig
> >  create mode 100644 arch/arm/plat-omap/dss/Makefile
> >  create mode 100644 arch/arm/plat-omap/dss/dispc.c
> >  create mode 100644 arch/arm/plat-omap/dss/display.c
> >  create mode 100644 arch/arm/plat-omap/dss/dpi.c
> >  create mode 100644 arch/arm/plat-omap/dss/dss.c
> >  create mode 100644 arch/arm/plat-omap/dss/dss.h
> >  create mode 100644 arch/arm/plat-omap/dss/sdi.c
> >  create mode 100644 arch/arm/plat-omap/include/mach/display.h
> 
> Sorry, no subdirectories allowed under arch/arm/*omap*. Please move
> these to live under drivers/video somewhere.
> 
> Also, you should not need to use cpu_is_omapxxxx() macros under
> drivers, please separate out the low-level init to happen under
> arch/arm/*omap* and pass the necessary things to the driver in
> the platform_data. See how usb and mmc are doing it for example.
> 
[Shah, Hardik] Hi Tony,
DSS library will be used by both V4L2 driver and the FBDEV driver.  So will you please suggest the ideal directory for the DSS library?  Moving the DSS library files under /drivers/video will break V4L2 will moving it under /drivers/media/video/ will break fbdev.

Thanks and Regards,
Hardik Shah

> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

