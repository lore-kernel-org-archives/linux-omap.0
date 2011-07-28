From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device
	internals
Date: Thu, 28 Jul 2011 11:10:12 +0100
Message-ID: <20110728101012.GA8446@n2100.arm.linux.org.uk>
References: <1311292338-11830-1-git-send-email-khilman@ti.com> <1311292338-11830-4-git-send-email-khilman@ti.com> <20110722085716.GI32058@legolas.emea.dhcp.ti.com> <20110728055346.GA11921@foobar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46782 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1G1KKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 06:10:40 -0400
Content-Disposition: inline
In-Reply-To: <20110728055346.GA11921@foobar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 28, 2011 at 12:53:47AM -0500, Nishanth Menon wrote:
> +struct device *omap_hwmod_to_device(const char *oh_name)
> +{
> +	struct omap_hwmod *oh;
> +
> +	if (!oh_name) {
> +		WARN(1, "%s: no hwmod name!\n", __func__);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	oh = _lookup(oh_name);
> +	if (IS_ERR_OR_NULL(oh)) {
> +		WARN(1, "%s: no hwmod for %s\n", __func__,
> +			oh_name);
> +		return ERR_PTR(-ENODEV);

It is good practice to always propagate back the error codes from functions
which failed.  So you may need something like:

		return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);

here.

> +	}
> +	if (IS_ERR_OR_NULL(oh->od)) {
> +		WARN(1, "%s: no omap_device for %s\n", __func__,
> +			oh_name);
> +		return ERR_PTR(-ENODEV);

Same here.
