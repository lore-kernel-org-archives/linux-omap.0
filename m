From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
Date: Tue, 25 Sep 2012 18:52:55 +0100
Message-ID: <20120925175255.GA13823@sirena.org.uk>
References: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, b-cousson@ti.com, balbi@ti.com, santosh.shilimkar@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 05, 2012 at 05:06:04PM +0530, Sourav Poddar wrote:

> +static struct regmap_config smsc_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = SMSC_MAX_REGISTER - 1;
> +		.cache_type = REGCACHE_COMPRESSED,
> +};

That definition of max_register looks wrong - why are we subtracting 1
from a macro called MAX_REGISTER to get it?

Indentation here is a bit odd too.

> +static int smsc_i2c_remove(struct i2c_client *i2c)
> +{
> +	return 0;
> +}

Remove empty functions.
