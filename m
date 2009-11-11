From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Regulator: Adding header file for initializing
 OMAP35x PMICs
Date: Wed, 11 Nov 2009 15:54:26 +0000
Message-ID: <20091111155425.GB30354@rakim.wolfsonmicro.main>
References: <1257950678-32452-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59026 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757564AbZKKPyV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 10:54:21 -0500
Content-Disposition: inline
In-Reply-To: <1257950678-32452-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Wed, Nov 11, 2009 at 08:14:38PM +0530, Anuj Aggarwal wrote:

Looking at a lot of this it feels like it would be cleaner to just have
a file defining the completely standard supplies, prototype them in the
header files and then link to them from the board code.  I'm finding the
macro stuff really hard to read.

More specific stuff:

> +/* Add/define supplies to the specific regulator */
> +#define REGULATOR_COMSUMER_DEFINE(s, device) \

These names are all very likely to clash with any similar macros added
to the regulator API.

> +               { \
> +                       .supply = #s, \
> +                       .dev = device, \
> +               }
> +

You should be using dev_name not dev for maximuim flexibility.

> +/* Define regulator with no supplies attached to it */
> +#define REGULATOR_CONSUMER_NO_SUPPLY(regulator) \
> +	REGULATOR_COMSUMER_START(regulator) = {}

> +/* VDAC */
> +#define TWL_VDAC_DATA	REGULATOR_INIT_DATA(vdac, VDAC, 1800000, 1800000, \
> +						TWL_REGULATOR_MODES_DEFAULT, \
> +						TWL_REGULATOR_OPS_DEFAULT, \
> +						true)

This is the sort of thing that looks like it should be defined in one
common place rather than having multiple copies of the structure, one in
every board using it.
