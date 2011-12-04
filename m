From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 1/4] regulator: helper routine to extract
	regulator_init_data
Date: Sun, 4 Dec 2011 15:54:35 +0000
Message-ID: <20111204155433.GA16287@opensource.wolfsonmicro.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com> <1321615040-13257-2-git-send-email-rnayak@ti.com> <CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40163 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319Ab1LDPyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Dec 2011 10:54:36 -0500
Content-Disposition: inline
In-Reply-To: <CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, robherring2@gmail.com, linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Sun, Dec 04, 2011 at 06:51:23PM +0530, Thomas Abraham wrote:

> For regulators that are not turned on by bootloader, and which require
> 'apply_uV' constraint, is there any alternative for turning on the
> regulator when using dt?

If the regulator isn't software managed then always_on covers this - the
regulator core will enable any always_on regulators that haven't been
enabled already.

>  	/* do we need to apply the constraint voltage */
> -	if (rdev->constraints->apply_uV &&
> -	    rdev->constraints->min_uV == rdev->constraints->max_uV) {
> +	if ((rdev->constraints->apply_uV &&
> +	    rdev->constraints->min_uV == rdev->constraints->max_uV) ||
> +		(!rdev->constraints->boot_on && rdev->constraints->always_on)) {
>  		ret = _regulator_do_set_voltage(rdev,
>  						rdev->constraints->min_uV,
>  						rdev->constraints->max_uV);

I'm not sure I understand the intended logic there.  Voltage constraints
and enable/disable constraints are orthogonal here.
