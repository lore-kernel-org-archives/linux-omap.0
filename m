From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] MFD: TWL6025: add phoenix lite support to
	twl6030
Date: Thu, 12 May 2011 15:24:43 +0100
Message-ID: <20110512142443.GA16218@sirena.org.uk>
References: <1305206878-18094-1-git-send-email-gg@slimlogic.co.uk> <1305206878-18094-2-git-send-email-gg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305206878-18094-2-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Thu, May 12, 2011 at 02:27:55PM +0100, Graeme Gregory wrote:
> Phoenix Lite is based on the twl6030 family of PMICs. It has mostly the
> same feature set of twl6030 but with small changes. The codec block has
> also been removed. It also has a new charger block and new features in
> its ADC block. VUSB handling also differs.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>

> +	pdata->driver_data = (void *)features;
> +

You never need to cast to void, and doing needless casts can mask bugs.
