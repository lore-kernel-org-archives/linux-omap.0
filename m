From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv2 RESEND] am33xx: cpsw: default to ethernet hwaddr from
 efuse if not defined in dt
Date: Thu, 5 Sep 2013 15:07:59 -0700
Message-ID: <20130905220759.GA17778@quad.lixom.net>
References: <1378415306-28821-1-git-send-email-jacmet@sunsite.dk>
 <1378417322-2277-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36144 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IEWIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Sep 2013 18:08:37 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so2399329pdi.13
        for <linux-omap@vger.kernel.org>; Thu, 05 Sep 2013 15:08:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1378417322-2277-1-git-send-email-jacmet@sunsite.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, khilman@linaro.org, tony@atomide.com, mugunthanvnm@ti.com, mpfj-list@newflow.co.uk, koen@dominion.thruhere.net, matt.porter@linaro.org

Hi,

On Thu, Sep 05, 2013 at 11:42:02PM +0200, Peter Korsgaard wrote:
> When booting with CONFIG_ARM_APPENDED_DTB (either because of using an old
> U-Boot, not wanting the hassle of 2 files or when using Falcon fast boot
> mode in U-Boot), nothing updates the ethernet hwaddr specified for the
> CPSW slaves, causing the driver to use a random hwaddr, which is some times
> troublesome.
> 
> The am33xx has unique ethernet hwaddrs programmed in the efuse, so it makes
> more sense to default to these rather than random ones. Add a fixup step
> which adds mac-address dt properties using the efuse addresses if the DTB
> didn't contain valid ones.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
> Tested-by: Mark Jackson <mpfj-list@newflow.co.uk>
> Tested-by: Koen Kooi <koen@dominion.thruhere.net>
> Tested-by: Matt Porter <matt.porter@linaro.org>
> ---
> diff --git a/arch/arm/mach-omap2/am33xx-cpsw.c b/arch/arm/mach-omap2/am33xx-cpsw.c
> new file mode 100644
> index 0000000..eec29a4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/am33xx-cpsw.c
> @@ -0,0 +1,94 @@
> +/*
> + * am335x specific cpsw dt fixups
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/etherdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_net.h>
> +
> +#include "soc.h"
> +#include "control.h"
> +
> +/**
> + * am33xx_dt_cpsw_set_mac_from_efuse - Add mac-address property using
> + * ethernet hwaddr from efuse
> + * @np:		Pointer to the cpsw slave to set mac address of
> + * @idx:	Mac address index to use from efuse
> + */
> +static void am33xx_dt_cpsw_set_mac_from_efuse(struct device_node *np, int idx)
> +{
> +	struct property *prop;
> +	u32 lo, hi;
> +	u8 *mac;
> +
> +	switch (idx) {
> +	case 0:
> +		lo = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID0_LOW);
> +		hi = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID0_HIGH);
> +		break;
> +
> +	case 1:
> +		lo = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID1_LOW);
> +		hi = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID1_HIGH);
> +		break;
> +
> +	default:
> +		pr_err("cpsw.%d: too many slaves found\n", idx);
> +		return;
> +	}
> +
> +	prop = kzalloc(sizeof(*prop) + ETH_ALEN, GFP_KERNEL);
> +	if (!prop)
> +		return;
> +
> +	prop->value = prop + 1;
> +	prop->length = ETH_ALEN;
> +	prop->name = kstrdup("mac-address", GFP_KERNEL);

Hmm. Do we want this to be mac-address or local-mac-address? If it's
mac-address, then this will override anything set by u-boot (by means
of priority in of_net). I don't think that's desireable. So it should
probably set local-mac-address instead.

> +	if (!prop->name) {
> +		kfree(prop);
> +		return;
> +	}
> +
> +	mac = prop->value;
> +
> +	mac[0] = hi;
> +	mac[1] = hi >> 8;
> +	mac[2] = hi >> 16;
> +	mac[3] = hi >> 24;
> +	mac[4] = lo;
> +	mac[5] = lo >> 8;
> +
> +	of_update_property(np, prop);

mach-mxs does this too, I wonder if it's worth creating a small helper for it.

Doesn't have to be done as part of this patch but it's still worth doing.

> +
> +	pr_info("cpsw.%d: No hwaddr in dt. Using %pM from efuse\n", idx, mac);
> +}
> +
> +static int __init am33xx_dt_cpsw_mac_fixup(void)
> +{
> +	struct device_node *np, *slave;
> +	int idx = 0;
> +
> +	if (!soc_is_am33xx())
> +		return -ENODEV;
> +
> +	for_each_compatible_node(np, NULL, "ti,cpsw")
> +		for_each_node_by_name(slave, "slave") {

The binding doesn't enforce "slave" node names for the subnodes, so you
should probably just iterate over children. Right now they are named
slave@0 and slave@1, but lack reg properties (and a notion of what said
reg property would symbolize).

> +			if (!of_get_mac_address(slave))
> +				am33xx_dt_cpsw_set_mac_from_efuse(slave, idx);
> +			idx++;

You're assuming that you get the children in order here, which is not
guaranteed.

Maybe best is to adjust the binding, to make "reg" mean something (i.e. the MAC
index for this hardware) and use the <reg> property of the childnode to tell
which efuse to read.


-Olof
