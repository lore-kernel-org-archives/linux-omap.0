From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Fri, 1 Oct 2010 20:16:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0C2@dbde02.ent.ti.com>
References: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@li
Cc: "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>
List-Id: linux-omap@vger.kernel.org

Kishore, 

<<snip>>

A minor comment

> +int twl6030_mmc_card_detect(struct device *dev, int slot)
> +{
> +	int ret = -EIO;
> +	u8 read_reg = 0;
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	if (pdev->id) {
> +		/* TWL6030 provide's Card detect support for
> +		 * only MMC1 controller.
> +		 */

Check multiline comment style

> +		pr_err("Unkown MMC controller %d in %s\n", 
> pdev->id, __func__);
> +		return ret;
> +	}
> +	/*
> +	 * BIT0 of MMC_CTRL on TWL6030 provides card status for MMC1
> +	 * 0 - Card not present ,1 - Card present
> +	 */
> +	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &read_reg,
> +						TWL6030_MMCCTRL);
> +	if (ret >= 0)
> +		ret = read_reg & STS_MMC;
> +	return ret;
> +}
> +EXPORT_SYMBOL(twl6030_mmc_card_detect);
> +

<<snip>>