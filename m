From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 20 Jul 2009 17:29:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404329D66BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbZGTL7z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 07:59:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. This patch series adds support for TWL6030 irq framework, and 
driver support for RTC and regulator.

	drivers/mfd/twl6030-irq.c  files is newly added as INTERRUPT status 
		registers, ack and clear mechanism has changed from twl4030,5030.
	drivers/rtc/rtc-twl.c will support twl4030,twl5030, and also twl6030 rtc
	drivers/regulator/twl-regulator.c will support twl regulators.
	include/linux/i2c/twl.h  will have TWL4030 and TWL6030 offsets selected 
		at compile time by CONFIG_TWL4030_CORE / CONFIG_TWL6030_CORE

These patches are generated against mainline 2.6.31-rc1 and dependancy on my
1st series[1].
Patch list:
	[RFC][PATCH 1/4] OMAP4: PMIC: Add support for twl6030 irq framework
	[RFC][PATCH 2/4] OMAP4: PMIC: Add support for twl6030 RTC
	[RFC][PATCH 3/4] OMAP4: PMIC: Add support for twl6030 regulators
	[RFC][PATCH 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030 regulators

Needed board-* changes and defconfig chages will be done later.Please let me 
know your feedback/suggestion on this patch series.

Thanks and Regards,
Balaji T K
[1] http://marc.info/?l=linux-omap&m=124757921417187&w=2
  [PATCH 0/4] TWL patch series 

