From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: [PATCH v4 0/8] TWL6030 patch series
Date: Fri, 11 Dec 2009 21:25:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940437210E66@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46107 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbZLKPzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 10:55:42 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "sameo@linux.intel.com" <sam>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "wim@iguana.be" <wim@iguana.be>

The TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. This patch series adds support for TWL6030 irq framework, and 
driver support for RTC and regulator.


	[PATCH v4 01/08] ARM: OMAP: Rename twl4030* driver files to enable re-use
	[PATCH v4 02/08] ARM: OMAP: Rename all twl4030_i2c*.
	[PATCH v4 03/08] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it 	
				generic rtc
	[PATCH v4 04/08] ARM: OMAP: Rename twl4030_ to twl_ in twl-regulator.c to 
				make it generic reg
	[PATCH v4 05/08] OMAP4: PMIC: Add support for twl6030 irq framework
	[PATCH v4 06/08] OMAP4: PMIC: Add support for twl6030 RTC
	[PATCH v4 07/08] OMAP4: PMIC: Add support for twl6030 regulators
	[PATCH v4 08/08] OMAP4: PMIC: Update TWL mfd driver to create twl6030 
				Regulators

This patch series v4 is rebased version of series v3[1]
Tested with SDP 3430.

[1] [PATCH v3 0/4] TWL6030 patch series
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17065.html
