From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 3/6] regulator: omap smps regulator driver
Date: Tue, 19 Jul 2011 16:38:18 +0100
Message-ID: <20110719153818.GJ9652@opensource.wolfsonmicro.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
 <1311010522-5868-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46513 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751818Ab1GSPiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 11:38:20 -0400
Content-Disposition: inline
In-Reply-To: <1311010522-5868-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, toddpoynor@google.com, lrg@ti.com

On Mon, Jul 18, 2011 at 08:35:19PM +0300, Tero Kristo wrote:
> OMAP SMPS regulator driver provides access to OMAP voltage processor
> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
> layer for the actual voltage regulation operations.


> +config REGULATOR_OMAP_SMPS
> +	tristate "TI OMAP SMPS Power Regulators"
> +	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM && TWL4030_CORE

Why does this depend on TWL4030_CORE or PM?
