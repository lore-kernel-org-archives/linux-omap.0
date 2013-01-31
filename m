From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug
Date: Thu, 31 Jan 2013 08:28:36 +0100
Message-ID: <D0DE2843-AA5C-4DFA-ADBE-61BC11D24836@dominion.thruhere.net>
References: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:37390 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab3AaH2k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 02:28:40 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so1319419eei.3
        for <linux-omap@vger.kernel.org>; Wed, 30 Jan 2013 23:28:39 -0800 (PST)
In-Reply-To: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, linux@arm.linux.org.uk, hvaibhav@ti.com, vaibhav.bedia@ti.com


Op 30 jan. 2013, om 15:39 heeft Hebbar Gururaja <gururaja.hebbar@ti.com> het volgende geschreven:

> am33xx_cm_wait_module_ready() checks if register offset is NULL.
> 
> int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> {
> 	int i = 0;
> 
> 	if (!clkctrl_offs)
> 		return 0;
> 
> In case of AM33xx, CLKCTRL register offset for different clock domains
> are not uniformly placed. An example of this would be the RTC clock
> domain with CLKCTRL offset at 0x00.
> In such cases the module ready check is skipped which leads to a data
> abort during boot-up when RTC registers is accessed.
> 
> Remove this check here to avoid checking module readiness for modules
> with clkctrl register offset at 0x00.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>

I can confirm that this fixes the crash on boot with CONFIG_RTC_DRV_OMAP=y with 3.8-rc5

regards,

Koen