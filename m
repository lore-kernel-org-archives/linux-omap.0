From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap5: build opp4xxx_data.c
Date: Tue, 25 Jun 2013 19:20:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50937 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab3FYTUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 15:20:04 -0400
In-Reply-To: <20130621204250.GA16139@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Santosh,

On Fri, 21 Jun 2013, Nishanth Menon wrote:

> 	/*
> 	 * XXX Will depend on the process, validation, and binning
> 	 * for the currently-running IC. Use OMAP4 data for time being.
> 	 */
> #ifdef CONFIG_PM_OPP
> 	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
> 	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
> 	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
> #endif
> 
> Should we just remove this instead? these are obviously wrong.

Are the OMAP4460 values expected to work and be safe for OMAP5, or not?  
If the latter, please send a patch to remove them.

thanks

- Paul
