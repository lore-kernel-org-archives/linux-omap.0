From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v4 0/8] TWL6030 patch series
Date: Sun, 13 Dec 2009 23:32:25 +0100
Message-ID: <20091213223224.GC10094@sortiz.org>
References: <19F8576C6E063C45BE387C64729E73940437210E66@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:17570 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbZLMWay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 17:30:54 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940437210E66@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "wim@iguana.be" <wim@iguana.be>

Hi Balaji,

On Fri, Dec 11, 2009 at 09:25:09PM +0530, Krishnamoorthy, Balaji T wrote:
> The TWL6030 is companion chip for OMAP4 like the current TWL4030
> for OMAP3. This patch series adds support for TWL6030 irq framework, and 
> driver support for RTC and regulator.
> 
> 
> 	[PATCH v4 01/08] ARM: OMAP: Rename twl4030* driver files to enable re-use
> 	[PATCH v4 02/08] ARM: OMAP: Rename all twl4030_i2c*.
> 	[PATCH v4 03/08] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it 	
> 				generic rtc
> 	[PATCH v4 04/08] ARM: OMAP: Rename twl4030_ to twl_ in twl-regulator.c to 
> 				make it generic reg
> 	[PATCH v4 05/08] OMAP4: PMIC: Add support for twl6030 irq framework
> 	[PATCH v4 06/08] OMAP4: PMIC: Add support for twl6030 RTC
> 	[PATCH v4 07/08] OMAP4: PMIC: Add support for twl6030 regulators
> 	[PATCH v4 08/08] OMAP4: PMIC: Update TWL mfd driver to create twl6030 
> 				Regulators
> 
> This patch series v4 is rebased version of series v3[1]
> Tested with SDP 3430.
All 8 patches applied, thanks.
I had to export a few symbols to make it build with a modularized rtc-twl.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
