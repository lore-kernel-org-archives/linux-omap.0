From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] Regulator: Modifying Kconfig to choose from the
 available PMICs
Date: Mon, 11 Jan 2010 11:22:18 +0000
Message-ID: <20100111112218.GE20717@rakim.wolfsonmicro.main>
References: <1262973486-32610-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58797 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751496Ab0AKLWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:22:20 -0500
Content-Disposition: inline
In-Reply-To: <1262973486-32610-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, Jan 08, 2010 at 11:28:06PM +0530, Anuj Aggarwal wrote:

> +config PMIC_TWL4030
> +	bool "TWL4030/TPS65950 Power Module"
> +	default y
> +	depends on TWL4030_CORE && MACH_OMAP3EVM
> +	select REGULATOR_TWL4030 if REGULATOR
> +	help
> +	  Say yes here if you are using the TWL4030/TPS65950 based power module
> +	  for the EVM boards.
> +

Perhaps this should select the TWL4030 driver rather than depending on
it?  Configuration variables that require selection over different menus
can be a bit obscure for users since (in this case) they need to know to
go to the MFD menu, enable the TWL4030 then go back down into the OMAP
menu to enable the board-specific support.
