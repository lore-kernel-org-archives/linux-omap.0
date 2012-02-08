From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/16] ARM: omap: fix section mismatch errors in TWL
 PMIC driver
Date: Wed, 8 Feb 2012 10:47:01 -0800
Message-ID: <20120208184700.GG29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAX3-0006HF-Bf@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60440 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757169Ab2BHSrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:47:03 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAX3-0006HF-Bf@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:07]:
> WARNING: drivers/mfd/built-in.o(.devinit.text+0x258): Section mismatch in reference from the function twl_probe() to the function .init.text:twl4030_power_init()
> The function __devinit twl_probe() references
> a function __init twl4030_power_init().
> If twl4030_power_init is only used by twl_probe then
> annotate twl4030_power_init with a matching annotation.
> 
> twl4030_power_init() references other __init marked functions, so
> these too must become __devinit.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

We'll take a look at sorting this out for v3.4 properly.
Meanwhile:

Acked-by: Tony Lindgren <tony@atomide.com>
