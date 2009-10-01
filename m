From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: [PATCH v3 0/4] TWL6030 patch series
Date: Thu, 1 Oct 2009 17:52:04 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436CF8BFA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40395 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756510AbZJAMWL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:22:11 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>

This patch series v3 incorporates comments received earlier[1].

The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. This patch series adds support for TWL6030 irq framework, and 
driver support for RTC and regulator.

These patches has dependancy on TWL patch series[2]
	[PATCH v3 01/04] OMAP4: PMIC: Add support for twl6030 irq framework
	[PATCH v3 02/04] OMAP4: PMIC: Add support for twl6030 RTC
	[PATCH v3 03/04] OMAP4: PMIC: Add support for twl6030 regulators
	[PATCH v3 04/04] OMAP4: PMIC: Update TWL mfd driver to create twl6030 
				Regulators

[1] http://marc.info/?l=linux-omap&m=125050037530307&w=2
[RFC][PATCH 0/4] TWL6030 patch series

[2] http://marc.info/?l=linux-omap&m=125439874001377&w=2
[PATCH v3 0/4] TWL patch series
