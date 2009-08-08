From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] Regulator: Add board-omap35x-pmic.c to
 arch/arm/mach-omap2/
Date: Sat, 8 Aug 2009 08:41:36 +0100
Message-ID: <20090808074135.GA4519@sirena.org.uk>
References: <1249658966-11062-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:58584 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933564AbZHHHlm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Aug 2009 03:41:42 -0400
Content-Disposition: inline
In-Reply-To: <1249658966-11062-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 07, 2009 at 08:59:26PM +0530, Anuj Aggarwal wrote:

> Added arch/arm/mach-omap2/board-omap35x-pmic.c file which will
> have the board specific information for different regulators
> and will do the regulator initialization depending on the one
> which is available.

Should this have an "evm" or something in the filename, possibly?  There
will be some boards that aren't so directly cloned from the reference
designs.

> +static inline int detect_pmic(void)
> +{
> +#if defined(CONFIG_TWL4030_CORE)
> +	flag_pmic_twl4030 = 1;
> +#endif

This isn't actually detecting anything on the board, it's just flagging
the things that have drivers built in.  Will everything continue to work
OK if support for more than one of the PMICs is built into the kernel or
will things break?  If they'll break you might want to have something to
detect that and flag it up.

> +int oma35x_pmic_init(void)
> +{

Typo there.
