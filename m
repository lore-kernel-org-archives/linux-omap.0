From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 20 Jul 2009 15:11:57 +0300
Message-ID: <20090720121157.GA13867@nokia.com>
References: <19F8576C6E063C45BE387C64729E739404329D66BE@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45175 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbZGTMLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 08:11:52 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404329D66BE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi,

On Mon, Jul 20, 2009 at 01:59:41PM +0200, ext Krishnamoorthy, Balaji T wrote:
> The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> for OMAP3. This patch series adds support for TWL6030 irq framework, and 
> driver support for RTC and regulator.
> 
> 	drivers/mfd/twl6030-irq.c  files is newly added as INTERRUPT status 
> 		registers, ack and clear mechanism has changed from twl4030,5030.
> 	drivers/rtc/rtc-twl.c will support twl4030,twl5030, and also twl6030 rtc
> 	drivers/regulator/twl-regulator.c will support twl regulators.
> 	include/linux/i2c/twl.h  will have TWL4030 and TWL6030 offsets selected 
> 		at compile time by CONFIG_TWL4030_CORE / CONFIG_TWL6030_CORE
> 
> These patches are generated against mainline 2.6.31-rc1 and dependancy on my
> 1st series[1].
> Patch list:
> 	[RFC][PATCH 1/4] OMAP4: PMIC: Add support for twl6030 irq framework
> 	[RFC][PATCH 2/4] OMAP4: PMIC: Add support for twl6030 RTC
> 	[RFC][PATCH 3/4] OMAP4: PMIC: Add support for twl6030 regulators
> 	[RFC][PATCH 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030 regulators
> 
> Needed board-* changes and defconfig chages will be done later.Please let me 
> know your feedback/suggestion on this patch series.

send these to lkml and Cc linux-omap. Also add to Cc:

Samuel Ortiz <sameo@openedhand.com>
Wim Van Sebroeck <wim@iguana.be>
Timo Kokkonen <timo.t.kokkonen@nokia.com>
Ben Dooks <ben-linux@fluff.org>
linux-i2c@vger.kernel.org
linux-kernel@vger.kernel.org

-- 
balbi
