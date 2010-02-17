From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Wed, 17 Feb 2010 16:15:09 +0000
Message-ID: <20100217161509.GA13324@rakim.wolfsonmicro.main>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49067 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750847Ab0BQQPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 11:15:13 -0500
Content-Disposition: inline
In-Reply-To: <1266420255-4307-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Feb 17, 2010 at 08:54:14PM +0530, Rajendra Nayak wrote:

>  		/* use the first in-range value */
> -		if (min_uV <= uV && uV <= max_uV)
> +		if (min_uV <= uV && uV <= max_uV) {
> +			if (twl_class_is_6030())
> +				/*
> +				 * Use the below formula to calculate vsel
> +				 * mV = 1000mv + 100mv * (vsel - 1)
> +				 */
> +				vsel = (LDO_MV(mV) - 1000)/100 + 1;
>  			return twlreg_write(info, TWL_MODULE_PM_RECEIVER,
>  							VREG_VOLTAGE, vsel);

This looks wrong - this code is inside a loop over vsel->voltage
mappings, if that mapping is wrong and needs to be ignored (which is
what this code is doing) then we shouldn't be looking at it at all.
