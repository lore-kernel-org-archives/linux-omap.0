From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Sun, 8 Mar 2009 22:41:45 +0000
Message-ID: <20090308224145.GD18035@sirena.org.uk>
References: <20090226140450.GB8595@sirena.org.uk> <200903061607.16825.david-b@pacbell.net> <20090307162233.GA12858@sirena.org.uk> <200903081354.36044.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1431 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZCHWmA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Mar 2009 18:42:00 -0400
Content-Disposition: inline
In-Reply-To: <200903081354.36044.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Mar 08, 2009 at 12:54:35PM -0800, David Brownell wrote:

> but the bootloader turned the regulator on, then drivers
> can't disable the regulator (on penalty of a stackdump!)
> unless they issue a spurious/pointless/undesirable enable()
> beforehand ...

We can't easily have both reference counting and unbalanced disables,
sadly.

>  - Regulators not marked as "boot_on" or "always_on" won't
>    be active (and usecount will be 0) on return from setup.

This breaks the idea that we don't do anything unless explictly told to
do so.  I did actually still consider adding code to power off the
regulator but thought that there may also be situations where the state
really is unknown (eg, it depends on what the system booted from) and
it'd be useful to be able to punt to the consumers to figure it out.

I'm a bit ambivalent on this one, though - avoiding a sprawl of options
is certainly neater.  An enum for the initial power state has an appeal
here.

> -	/* are we enabled at boot time by firmware / bootloader */
> -	if (rdev->constraints->boot_on)
> -		rdev->use_count = 1;
> -

That's not there with the current regulator tree (this was the bug with
not being able to disable boot_on regulators, there's no way to drop
that use count later on).

Much of the rest of your patch will fail to apply due to similar
changes; the logic that's there now is roughly the same as what you have
here except we don't bother to check is_enabled() any more (no harm
adding that back, it'd be useful if enable() can't be called for an
already enabled regulator) and we don't disable the regulator.

> +		} else if (is_enabled < 0) {
> +			pr_warning("%s: hoping regulator '%s' is %sd...\n",
> +				       __func__, name, "enable");
> +		}

I'm really not loving this %s for the enabled - yes, it'll save a small
amount of memory but it hurts gepability.
