From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
Date: Wed, 29 Sep 2010 20:16:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02BA7@dbde02.ent.ti.com>
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<877hi5740v.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
 <87d3rw62ft.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41622 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0I2Oqw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:46:52 -0400
In-Reply-To: <87d3rw62ft.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]

<<snip>>

> >>
> >> I found a little snag with this series.  Try testing with
> >> omap2plus_defconfig and changing CONFIG_OMAP_WATCHDOG=n.
> >>
> >> If CONFIG_OMAP_WATCHDOG is not enabled in the kernel config, the system
> >> will reboot soon after bootup.
> >
> > Thanks for finding this issue.
> >
> > After watchdog module reset, the WDTs are enabled. The default time
> > for a system reset after a watchdog module reset is ~10s as per the
> > default value of the WDT registers. Hence the above problem is observed.
> >
> > If CONFIG_OMAP_WATCHDOG is defined, wdt's probe is called within this
> > 10s time and watchdog_disable is called during probe. Hence we are not
> > finding this issue if CONFIG_OMAP_WATCHDOG is defined.
> >
> > Ideally, because of the above, watchdog should be with
> > HWMOD_INIT_NO_RESET flag.
> >
> > If agreed, I would send the below patch (extended to other OMAPs)
> > on top of my watchdog timer hwmod series with proper change log.
> 
> Using HWMOD_INIT_NO_RESET makes us still dependent on the bootloader
> settings.

Agreed.

> 
> Instead, I would rather have a small piece of code in omap_init_wdt()
> which disarms the watchdog so we don't have any assumptions about
> bootloader behavior.
> 
> The question remains whether this disarm should be
> #ifndef CONFIG_OMAP_WATCHDOG or if it should happen all the time.  In
> case the watchdog is a module, it's probe may not happen within the
> timeout period and they system may reboot also, so I lean towards
> disarming the watchdog unconditionally.

Agreed. But this shall be handled in mach-omap2/devices.c by directly
accessing the watchdog registers and disabling it, as the watchdog driver
would not be available by this time. If this okay, I would send a
separate patch on top my hwmod series to handle this.

-V Charulatha

<<snip>>
