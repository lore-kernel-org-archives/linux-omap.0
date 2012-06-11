From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
Date: Sun, 10 Jun 2012 23:34:17 -0700
Message-ID: <20120611063416.GT12766@atomide.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63413 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab2FKGeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 02:34:18 -0400
Content-Disposition: inline
In-Reply-To: <20120611004617.20034.21714.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

Hi,

Similar comments to the asess patch on this one below.

* Paul Walmsley <paul@pwsan.com> [120610 17:57]:
> --- /dev/null
> +++ b/include/linux/platform_data/fsusb.h

This would be better as include/linux/platform_data/omap-usb.h.

> +#include <plat/omap_hwmod.h>

This include should not be needed here if the hwmod function is
a static function in the some hwmod*.c file.

> +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS register */
> +#define HCCOMMANDSTATUS			0x0008
> +
> +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag */
> +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)

I think these already have standard defines in some OHCI header?
Felipe may be able to comment more on this?

> +static int fsusb_reset_host_controller(const char *name, void __iomem *base)
> +{
> +	int i;
> +
> +	writel(HCCOMMANDSTATUS_HCR_MASK, base + HCCOMMANDSTATUS);
> +
> +	for (i = 0; i < MAX_FSUSB_HCR_TIME; i++) {
> +		if (!(readl(base + HCCOMMANDSTATUS) & HCCOMMANDSTATUS_HCR_MASK))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i == MAX_FSUSB_HCR_TIME) {
> +		pr_warn("%s: %s: host controller reset failed (waited %d usec)\n",
> +			__func__, name, MAX_FSUSB_HCR_TIME);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

This should be "static inline int fsusb_reset_host_controller" as it's
in a header.

> +static int __maybe_unused hwmod_fsusb_preprogram(struct omap_hwmod *oh)
> +{
> +	void __iomem *va;
> +
> +	va = omap_hwmod_get_mpu_rt_va(oh);
> +	if (!va)
> +		return -EINVAL;
> +
> +	fsusb_reset_host_controller(oh->name, va);
> +
> +	return 0;
> +}

And this too should be a static function in some hwmod*.c file.

Regards,

Tony
