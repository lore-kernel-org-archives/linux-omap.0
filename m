From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 17 Aug 2009 02:00:01 +0200
Message-ID: <20090816235959.GC4266@sortiz.org>
References: <19F8576C6E063C45BE387C64729E739404329D670F@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E73940432AF3EB6@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E73940432B7A0B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:30202 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751201AbZHPX54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 19:57:56 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940432B7A0B6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "me@felipebalbi.com" <me@felipebalbi.com>

Hi Balaji,

On Tue, Aug 11, 2009 at 06:30:24PM +0530, Krishnamoorthy, Balaji T wrote:
> Hi All,
> 
> Can I have your comments on this so that I can rebase the patch for the upcoming merge window.
> 
I looked at the mfd related files, from patchwork.kernel.org.
A few comments:

* Besides making it look nicer, is there any other reason to change the
twl4030-core.c name ?
* You should also change drivers/mfd/Kconfig to reflect the more generic twl
support.

* in drivers/mfd/twl-core.c:
-		status = twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
+		status = twl_init_irq(client->irq, pdata->irq_base,
+			 pdata->irq_end);

Please remove it as it's unrelated to this patchset.

* Same for the
-	( (devgrp) << 13 | 1 << 12 | (grp) << 9 | (type2) << 7 \
+	((devgrp) << 13 | 1 << 12 | (grp) << 9 | (type2) << 7 \

lines from include/linux/i2c/twl4030.h

* Why are you moving twl_init_irq and twl_exit_irq to twl.h ?

Cheers,
Samuel.


> Thanks and Regards,
> Balaji T K
> > -----Original Message-----
> > From: Krishnamoorthy, Balaji T
> > Sent: Thursday, August 06, 2009 2:28 PM
> > To: sameo@linux.intel.com
> > Cc: linux-omap@vger.kernel.org; tony@atomide.com; khilman@deeprootsystems.com;
> > david-b@pacbell.net; Shilimkar, Santosh; Nayak, Rajendra;
> > sameo@openedhand.com; wim@iguana.be; timo.t.kokkonen@nokia.com; ben-
> > linux@fluff.org; broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk;
> > Krishnamoorthy, Balaji T
> > Subject: RE: [RFC][PATCH 0/4] TWL6030 patch series
> > 
> > Hi Samuel,
> > 
> > Could you please add your comments on the following patch series.
> > 
> > series 1
> > [PATCH 1/4] ARM: OMAP: Rename twl4030* driver files to enable re-use
> > [PATCH 2/4] ARM: OMAP: Rename all twl4030_i2c*.
> > [PATCH 3/4] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it generic rtc
> > [PATCH 4/4] ARM: OMAP: Rename twl4030_ to twl_ in twl-regulator.c to make it
> > generic reg
> > 
> > series 2 dependent on series 1
> > [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030
> > regulators
> > [RFC][PATCH v2 3/4] OMAP4: PMIC: Add support for twl6030 regulators
> > [RFC][PATCH v2 2/4] OMAP4: PMIC: Add support for twl6030 RTC
> > [RFC][PATCH v2 1/4] OMAP4: PMIC: Add support for twl6030 irq framework
> > 
> > Thanks and Regards,
> > Balaji T K
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Krishnamoorthy, Balaji T
> > > Sent: Monday, July 20, 2009 7:04 PM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: linux-i2c@vger.kernel.org; linux-omap@vger.kernel.org; tony@atomide.com;
> > > khilman@deeprootsystems.com; david-b@pacbell.net; Shilimkar, Santosh; Nayak,
> > > Rajendra; sameo@openedhand.com; wim@iguana.be; timo.t.kokkonen@nokia.com;
> > ben-
> > > linux@fluff.org; broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk
> > > Subject: [RFC][PATCH 0/4] TWL6030 patch series
> > >
> > > The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> > > for OMAP3. This patch series adds support for TWL6030 irq framework, and
> > > driver support for RTC and regulator.
> > >
> > > 	drivers/mfd/twl6030-irq.c  files is newly added as INTERRUPT status
> > > 		registers, ack and clear mechanism has changed from twl4030,5030.
> > > 	drivers/rtc/rtc-twl.c will support twl4030,twl5030, and also twl6030 rtc
> > > 	drivers/regulator/twl-regulator.c will support twl regulators.
> > > 	include/linux/i2c/twl.h  will have TWL4030 and TWL6030 offsets selected
> > > 		at compile time by CONFIG_TWL4030_CORE / CONFIG_TWL6030_CORE
> > >
> > > These patches are generated against mainline 2.6.31-rc1 and has dependancy
> > on
> > > my 1st series[1].
> > > Patch list:
> > > 	[RFC][PATCH 1/4] OMAP4: PMIC: Add support for twl6030 irq framework
> > > 	[RFC][PATCH 2/4] OMAP4: PMIC: Add support for twl6030 RTC
> > > 	[RFC][PATCH 3/4] OMAP4: PMIC: Add support for twl6030 regulators
> > > 	[RFC][PATCH 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030
> > > regulators
> > >
> > > Needed board-* changes and defconfig changes will be done later.Please let
> > me
> > > know your feedback/suggestion on this patch series.
> > >
> > > Thanks and Regards,
> > > Balaji T K
> > > [1] http://marc.info/?l=linux-omap&m=124757921417187&w=2
> > >   [PATCH 0/4] TWL patch series
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
