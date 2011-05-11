From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 0/8] OMAP: DSS2: Miscellaneous patches
Date: Wed, 11 May 2011 09:12:53 +0300
Message-ID: <1305094373.2097.2.camel@deskari>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0B9D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37893 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751426Ab1EKRQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 13:16:06 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0B9D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, 2011-05-11 at 09:15 +0530, Janorkar, Mayuresh wrote:
> 
> > -----Original Message-----
> > From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> > owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
> > Sent: Tuesday, May 10, 2011 9:54 PM
> > To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> > Cc: Valkeinen, Tomi
> > Subject: [PATCH 0/8] OMAP: DSS2: Miscellaneous patches
> > 
> > Here are some smallish fixes and cleanups I made while porting N800's
> > display
> > driver to DSS2.
> > 
> >  Tomi
> > 
> > Tomi Valkeinen (8):
> >   OMAP: DSS2: Add missing dummy functions
> >   OMAPFB: fix wrong clock aliases and device name
> >   OMAP: DSS2: RFBI: add rfbi_bus_lock
> >   OMAP: DSS2: RFIB: clock enable/disable changes
> RFIB a typo?
> 
> >   OMAP: DSS2: RFBI: add omap_rfbi_configure
> >   OMAP: DSS2: RFIB: cleanup
> Same here
> 
> >   OMAP: DSS2: OMAPFB: remove dead code
> >   OMAP: DSS2: OMAPFB: Reduce stack usage
> > 
> >  arch/arm/plat-omap/include/plat/display.h |    4 +
> >  drivers/video/omap/dispc.c                |    4 +-
> >  drivers/video/omap/omapfb_main.c          |    2 +-
> >  drivers/video/omap/rfbi.c                 |    2 +-
> 
> If the series touches drivers/video/omap then the title should be "DSS and DSS2" using only DSS2 is misleading.

Right you are. Although the old driver was never called "DSS", but I'll
improve the subject. Thanks!

 Tomi


