From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 5/5 v3] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Fri, 27 Aug 2010 20:09:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCA86F2A@dbde02.ent.ti.com>
References: <1281965809-20585-1-git-send-email-charu@ti.com>
	<1281965809-20585-2-git-send-email-charu@ti.com>
	<1281965809-20585-3-git-send-email-charu@ti.com>
	<1281965809-20585-4-git-send-email-charu@ti.com>
	<1281965809-20585-5-git-send-email-charu@ti.com>
	<1281965809-20585-6-git-send-email-charu@ti.com>
 <874oehx9h3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56174 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab0H0OjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:39:23 -0400
In-Reply-To: <874oehx9h3.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wim@iguana.be" <wim@iguana.be>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, August 27, 2010 4:34 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; wim@iguana.be; paul@pwsan.com; Cousson,
> Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH 5/5 v3] OMAP2PLUS: WDT: Conversion to runtime PM
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch converts the OMAP Watchdog timer driver to
> > get adapted to HWMOD FW and to use the runtime PM APIs.
> 
> Technically, the driver knows nothing about the HWMOD framework, as
> that's an OMAP core implementation detail.
> 
> What's really happening here is two separate things:
> 
> 1) conversion of driver to runtime PM instead of clock framework
> 2) convert platform_device/_data over to be omap_device-based
> 
> These should be done in two separate patches (and in that order.)

Okay.

> 
> Other than that, the patch contents look good.  Some minor comments
> below...
> 
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Basak, Partha <p-basak2@ti.com>
> > ---
> >  arch/arm/plat-omap/devices.c |   64 ++++++++++++++++++++++++++++-------
> ------
> >  drivers/watchdog/omap_wdt.c  |   43 +++++-----------------------
> >  2 files changed, 52 insertions(+), 55 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> > index 76b58ab..7645ca3 100644
> > --- a/drivers/watchdog/omap_wdt.c
> > +++ b/drivers/watchdog/omap_wdt.c
> > @@ -38,13 +38,14 @@
> >  #include <linux/err.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/moduleparam.h>
> > -#include <linux/clk.h>
> >  #include <linux/bitops.h>
> >  #include <linux/io.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/slab.h>
> > +#include <linux/pm_runtime.h>
> >  #include <mach/hardware.h>
> >  #include <plat/prcm.h>
> > +#include <plat/omap_device.h>
> 
> This should not be needed in the driver, as there is no need for driver
> to call omap_device API.
> 


Yes, I will not include it.

> [...]
> 
> Kevin

