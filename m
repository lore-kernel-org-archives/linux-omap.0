From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 20 Jul 2009 19:04:06 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404329D670F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59555 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbZGTNef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 09:34:35 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. This patch series adds support for TWL6030 irq framework, and 
driver support for RTC and regulator.

	drivers/mfd/twl6030-irq.c  files is newly added as INTERRUPT status 
		registers, ack and clear mechanism has changed from twl4030,5030.
	drivers/rtc/rtc-twl.c will support twl4030,twl5030, and also twl6030 rtc
	drivers/regulator/twl-regulator.c will support twl regulators.
	include/linux/i2c/twl.h  will have TWL4030 and TWL6030 offsets selected 
		at compile time by CONFIG_TWL4030_CORE / CONFIG_TWL6030_CORE

These patches are generated against mainline 2.6.31-rc1 and has dependancy on 
my 1st series[1].
Patch list:
	[RFC][PATCH 1/4] OMAP4: PMIC: Add support for twl6030 irq framework
	[RFC][PATCH 2/4] OMAP4: PMIC: Add support for twl6030 RTC
	[RFC][PATCH 3/4] OMAP4: PMIC: Add support for twl6030 regulators
	[RFC][PATCH 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030 regulators

Needed board-* changes and defconfig changes will be done later.Please let me 
know your feedback/suggestion on this patch series.

Thanks and Regards,
Balaji T K
[1] http://marc.info/?l=linux-omap&m=124757921417187&w=2
  [PATCH 0/4] TWL patch series 
