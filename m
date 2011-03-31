From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/8] OMAP2+: omap_hwmod: manage the omap_devices the
	wake-up latency constraints
Date: Thu, 31 Mar 2011 12:29:05 +0100
Message-ID: <20110331112905.GA17547@n2100.arm.linux.org.uk>
References: <1301498364-726-1-git-send-email-j-pihet@ti.com> <1301498364-726-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50332 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab1CaL3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Mar 2011 07:29:21 -0400
Content-Disposition: inline
In-Reply-To: <1301498364-726-5-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>

On Wed, Mar 30, 2011 at 05:19:20PM +0200, jean.pihet@newoldbits.com wrote:
> +/*
> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
> + *
> + * @oh: struct omap_hwmod* to which the target device belongs to.
> + * @cookie: identifier of the constraints list for @oh.
> + * @min_latency: the minimum allowed wake-up latency for @oh.
> + *
> + * Returns 0 upon success.
> + */
> +int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
> +				       void *cookie, long min_latency)
> +{
> +	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	if (!PTR_ERR(pwrdm)) {
> +		pr_err("%s: Error: could not find powerdomain "
> +		       "for %s\n", __func__, oh->name);
> +		return -EINVAL;
> +	}

If omap_hwmod_get_pwrdm() returns errors encoded into pointers, then:

	if (IS_ERR(pwrdm)) {
		...
		return PTR_ERR(pwrdm);
	}

If it doesn't, then:

	if (!pwrdm) {
		...
		return -EINVAL;
	}

Note that PTR_ERR returns true for both valid error codes and valid
pointers.  Use the interface correctly and don't take shortcuts.  They
don't work.
