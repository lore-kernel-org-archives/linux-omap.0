From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 2/7] capebus: Add beaglebone board support
Date: Tue, 30 Oct 2012 12:39:40 -0700
Message-ID: <20121030193939.GR11908@atomide.com>
References: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
 <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121030 12:00]:
> +
> +	priv->lcdc_oh = omap_hwmod_lookup("lcdc");
> +	if (priv->lcdc_oh == NULL) {
> +		dev_err(&pdev->dev, "Failed to lookup omap_hwmod lcdc\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->lcdc_pdev = omap_device_build("da8xx_lcdc", 0, priv->lcdc_oh,
> +			&priv->lcd_pdata,
> +			sizeof(struct da8xx_lcdc_platform_data),
> +			NULL, 0, 0);
> +	if (priv->lcdc_pdev == NULL) {
> +		dev_err(&pdev->dev, "Failed to build LCDC device\n");
> +		return -ENODEV;
> +	}

..and these kind of things need to become private to
arch/arm/mach-omap2, we already have it working for other
devices with device tree.

Regards,

Tony
