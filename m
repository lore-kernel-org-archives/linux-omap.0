From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: [PATCH v3 0/4] TWL patch series
Date: Thu, 1 Oct 2009 17:35:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436CF8BF5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39553 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756510AbZJAMFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:05:30 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>

This patch series v3 incorporates comments received earlier[1].

The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. The common modules like RTC, Regulator creates opportunity
to re-use the most of the code from twl4030.

	[PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to enable re-use
	[PATCH v3 02/04] ARM: OMAP: Rename all twl4030_i2c*.
	[PATCH v3 03/04] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it 	
				generic rtc
	[PATCH v3 04/04] ARM: OMAP: Rename twl4030_ to twl_ in twl-regulator.c to 
				make it generic reg

[1] http://marc.info/?l=linux-omap&m=124757921417187&w=2
  [PATCH 0/4] TWL patch series
