From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] ARM: OMAP: gpmc: request CS address space for
	ethernet chips
Date: Tue, 12 Mar 2013 11:08:48 +0000
Message-ID: <20130312110848.GG30923@n2100.arm.linux.org.uk>
References: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33162 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab3CLLJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 07:09:06 -0400
Content-Disposition: inline
In-Reply-To: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Jon Hunter <jon-hunter@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Sun, Mar 10, 2013 at 06:18:22PM +0100, Javier Martinez Canillas wrote:
> +static int gpmc_probe_ethernet_child(struct platform_device *pdev,
> +				     struct device_node *child)
> +{
> +	int ret, cs;
> +	unsigned long base;
> +	struct resource res;
> +	struct platform_device *of_dev;
> +
> +	if (of_property_read_u32(child, "reg", &cs) < 0) {
> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	if (of_address_to_resource(child, 0, &res)) {
> +		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	ret = gpmc_cs_request(cs, resource_size(&res), &base);
> +	if (IS_ERR_VALUE(ret)) {

NAK.  ret < 0 is the correct way to test here.  Don't use IS_ERR_VALUE
unless you have a _very_ good reason to.  That's a good bit of advice
for everything in linux/err.h.  Don't use *anything* from there without
a damned good reason.
