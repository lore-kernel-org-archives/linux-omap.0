From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 5/5] omap2plus: voltage: Trivial linking fix
 for'EINVAL' undeclared
Date: Wed, 5 Jan 2011 17:06:09 +0530
Message-ID: <769ddee220c7dca3239db8f5a73896b3@mail.gmail.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
 <1294225024-21857-5-git-send-email-santosh.shilimkar@ti.com> <20110105111945.GA8717@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46585 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507Ab1AELgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 06:36:12 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so5961965yxt.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 03:36:11 -0800 (PST)
In-Reply-To: <20110105111945.GA8717@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, tony@atomide.com, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Wednesday, January 05, 2011 4:50 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; Nishanth Menon;
> tony@atomide.com; Kevin Hilman; Thara Gopinath; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 5/5] omap2plus: voltage: Trivial linking fix
> for'EINVAL' undeclared
>
> On Wed, Jan 05, 2011 at 04:27:04PM +0530, Santosh Shilimkar wrote:
> > CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
> > In file included from arch/arm/plat-
> omap/include/plat/omap_hwmod.h:38,
> >                  from arch/arm/mach-
> omap2/omap_hwmod_common_data.c:20:
> > arch/arm/plat-omap/include/plat/voltage.h: In function
> 'omap_voltage_late_init':
> > arch/arm/plat-omap/include/plat/voltage.h:145: error: 'EINVAL'
> undeclared (first use in this function)
> > arch/arm/plat-omap/include/plat/voltage.h:145: error: (Each
> undeclared identifier is reported only once
> > arch/arm/plat-omap/include/plat/voltage.h:145: error: for each
> function it appears in.)
> > make[1]: *** [arch/arm/mach-omap2/omap_hwmod_common_data.o] Error
> 1
> > make: *** [arch/arm/mach-omap2] Error 2
>
> The correct include for this is linux/errno.h, not linux/err.h - you
> want the errno definitions, not the IS_ERR/PTR_ERR/ERR_PTR stuff.


In this series, newly added stub of 'omap_voltage_domain_lookup'
in [PATCH v2 4/5] make use of 'ERR_PTR' which needs linux/err.h.


Regards
Santosh
