From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 03/11] DT: regulator: Helper routine to extract
 regulator_init_data
Date: Thu, 15 Sep 2011 14:44:27 +0100
Message-ID: <20110915134427.GJ7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58344 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933238Ab1IONo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:44:29 -0400
Content-Disposition: inline
In-Reply-To: <1316085727-15023-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:51:59PM +0530, Rajendra Nayak wrote:

>  .../devicetree/bindings/regulator/regulator.txt    |   37 +++++++++
>  drivers/of/Kconfig                                 |    6 ++
>  drivers/of/Makefile                                |    1 +
>  drivers/of/of_regulator.c                          |   85 ++++++++++++++++++++
>  include/linux/of_regulator.h                       |   23 +++++

Don't go hiding the bindings for things away from the code they're
binding.  Bindings for the regualtor API are a regulator API thing and
should be part of the regulator API code.

> +Required properties:
> +- compatible: Must be "regulator";

Is this idiomatic or should we just have a helper that parses a big list
of properties from the device node?

> +- mode-fast: boolean, Can handle fast changes in its load
> +- mode-normal: boolean, Normal regulator power supply mode
> +- mode-idle: boolean, Can be more efficient during light loads
> +- mode-standby: boolean, Can be most efficient during light loads

I guess these are actually permissions to set the given modes?  The
documentation should be clearer.

> +- apply-uV: apply uV constraint if min == max

This seems a bit Linux/runtime policy specific (especially the last
bit).
