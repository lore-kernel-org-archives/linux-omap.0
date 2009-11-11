From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Wed, 11 Nov 2009 15:46:17 +0000
Message-ID: <20091111154616.GA30354@rakim.wolfsonmicro.main>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44474 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754149AbZKKPqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 10:46:13 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

On Wed, Nov 11, 2009 at 08:26:07PM +0530, Gupta, Ajay Kumar wrote:

> +	/* get ehci regulator and enable */
> +	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
> +		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
> +			continue;
> +		sprintf(supply, "ehci%d", i);

The use of sprintf() here looks suspicious - these things would normally
be completely fixed.  I appreciate that that's the result, it just looks
suspicous.  Picking out of an array of fixed names would be more
idiomatic.  It'd also be idiomatic to use whatever the supply on the
chip is called in the datasheet - ehci might be accurate but it'd be a
bit of a surprising choice, it'd be good to check.

If you do stick with this approach you probably want to use snprintf()
and make supply be 6 bytes rather than 5 bytes long.

> +	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
> +		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
> +			continue;
> +		if (omap->regulator[i]) {
> +			if (regulator_is_enabled(omap->regulator[i]))
> +				regulator_disable(omap->regulator[i]);
> +			regulator_put(omap->regulator[i]);
> +		}

For robustness I'd drop the first check for MODE_UNKNOWN here - it
doesn't add anything.  You also want to call regulator_disable() before
you free the regulator.
