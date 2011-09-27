From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/9] regulator: helper routine to extract
 fixed_voltage_config
Date: Tue, 27 Sep 2011 13:16:22 +0100
Message-ID: <20110927121622.GD4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57102 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753536Ab1I0MQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 08:16:24 -0400
Content-Disposition: inline
In-Reply-To: <1317118372-17052-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:48PM +0530, Rajendra Nayak wrote:
> The helper routine of_get_fixed_voltage_config() extracts
> fixed_voltage_config structure contents from device tree.
> 
> Also add documenation for additional bindings for fixed
> regulators that can be passed through dt.

Why not just add device tree support into the driver directly?

> +Optional properties:
> +- regulator-fixed-supply: Name of the regulator supply

This is going to be confusing with respect to the generic regulator
supply property.

> +- regulator-fixed-enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low

Word wrap for legibility please.
