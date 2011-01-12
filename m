From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] omap3: beaglexm: fix power on of DVI
Date: Tue, 11 Jan 2011 16:15:09 -0800
Message-ID: <20110112001509.GA4957@atomide.com>
References: <1294766017-12182-4-git-send-email-nm@ti.com>
 <20110111232329.GY4957@atomide.com>
 <4D2CEDD7.4020507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59287 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637Ab1ALAPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 19:15:18 -0500
Content-Disposition: inline
In-Reply-To: <4D2CEDD7.4020507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

* Nishanth Menon <nm@ti.com> [110111 15:54]:
> Tony Lindgren had written, on 01/11/2011 05:23 PM, the following:
> [..]
> >>-
> >>-	gpio_request(gpio + 1, "EHCI_nOC");
> >>-	gpio_direction_input(gpio + 1);
> >>+	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
> >>+		gpio_request(gpio + 1, "EHCI_nOC");
> >>+		gpio_direction_input(gpio + 1);
> >>+	}
> >
> >The return value for gpio_request must be checked.
> Ack.
> we can go down two paths:
> a) I can redo this patch as in v6.patch (attached)

Yes let's do that, one comment below though..

> OR
> b) we take this patch and do another one cleaning the function up -
> gpio-check.patch

That can be done later.
 
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
> +		if (!r) {
> +			r = gpio_direction_output(gpio + 1, 0);
> +			if (r)
> +				gpio_free(gpio + 1);
> +		}
> +		if (r)
> +			pr_err("%s: unable to configure nDVI_PWR_EN\n",
> +				__func__);
> +		r = gpio_request(gpio + 2, "DVI_LDO_EN");
> +		if (!r) {
> +			r = gpio_direction_output(gpio + 2, 1);
> +			if (r)
> +				gpio_free(gpio + 1);
> +		}
> +		if (r)
> +			pr_err("%s: unable to configure DVI_LDO_EN\n",
> +				__func__);
> +	}
> +

Should the second gpio_free be gpio + 2 instead of gpio + 1?

Tony
