From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH v3] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL
 check" bug
Date: Thu, 31 Jan 2013 08:24:00 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB59E84@DBDE01.ent.ti.com>
References: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
 <D0DE2843-AA5C-4DFA-ADBE-61BC11D24836@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35897 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954Ab3AaIYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 03:24:13 -0500
In-Reply-To: <D0DE2843-AA5C-4DFA-ADBE-61BC11D24836@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

On Thu, Jan 31, 2013 at 12:58:36, Koen Kooi wrote:
> 
> Op 30 jan. 2013, om 15:39 heeft Hebbar Gururaja <gururaja.hebbar@ti.com> het volgende geschreven:
> 
> > am33xx_cm_wait_module_ready() checks if register offset is NULL.
> > 
> > int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, CLKCTRL register offset for different clock domains
> > are not uniformly placed. An example of this would be the RTC clock
> > domain with CLKCTRL offset at 0x00.
> > In such cases the module ready check is skipped which leads to a data
> > abort during boot-up when RTC registers is accessed.
> > 
> > Remove this check here to avoid checking module readiness for modules
> > with clkctrl register offset at 0x00.
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> 
> I can confirm that this fixes the crash on boot with CONFIG_RTC_DRV_OMAP=y with 3.8-rc5

Could you please share the crash log for my reference?

> 
> regards,
> 
> Koen


Regards, 
Gururaja
