From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2 RESEND] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Fri, 06 Sep 2013 10:44:51 +0200
Message-ID: <87txhy1gqk.fsf@dell.be.48ers.dk>
References: <1378415306-28821-1-git-send-email-jacmet@sunsite.dk>
	<1378417322-2277-1-git-send-email-jacmet@sunsite.dk>
	<20130905220759.GA17778@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:39575 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3IFIoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 04:44:55 -0400
In-Reply-To: <20130905220759.GA17778@quad.lixom.net> (Olof Johansson's message
	of "Thu, 5 Sep 2013 15:07:59 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, khilman@linaro.org, tony@atomide.com, mugunthanvnm@ti.com, mpfj-list@newflow.co.uk, koen@dominion.thruhere.net, matt.porter@linaro.org

>>>>> "Olof" == Olof Johansson <olof@lixom.net> writes:

Hi Olof,

Thanks for the review!

 >> +/**
 >> + * am33xx_dt_cpsw_set_mac_from_efuse - Add mac-address property using
 >> + * ethernet hwaddr from efuse
 >> + * @np:		Pointer to the cpsw slave to set mac address of
 >> + * @idx:	Mac address index to use from efuse
 >> + */
 >> +static void am33xx_dt_cpsw_set_mac_from_efuse(struct device_node *np, int idx)
 >> +{
 >> +	struct property *prop;
 >> +	u32 lo, hi;
 >> +	u8 *mac;
 >> +
 >> +	switch (idx) {
 >> +	case 0:
 >> +		lo = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID0_LOW);
 >> +		hi = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID0_HIGH);
 >> +		break;
 >> +
 >> +	case 1:
 >> +		lo = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID1_LOW);
 >> +		hi = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID1_HIGH);
 >> +		break;
 >> +
 >> +	default:
 >> +		pr_err("cpsw.%d: too many slaves found\n", idx);
 >> +		return;
 >> +	}
 >> +
 >> +	prop = kzalloc(sizeof(*prop) + ETH_ALEN, GFP_KERNEL);
 >> +	if (!prop)
 >> +		return;
 >> +
 >> +	prop->value = prop + 1;
 >> +	prop->length = ETH_ALEN;
 >> +	prop->name = kstrdup("mac-address", GFP_KERNEL);

 Olof> Hmm. Do we want this to be mac-address or local-mac-address? If it's
 Olof> mac-address, then this will override anything set by u-boot (by means
 Olof> of priority in of_net). I don't think that's desireable. So it should
 Olof> probably set local-mac-address instead.

It doesn't really matter as this only gets called if the DTB doesn't
contain any valid mac-address / local-mac-address properties (the
if (!of_get_mac_address(slave)) check).



 >> +	if (!prop->name) {
 >> +		kfree(prop);
 >> +		return;
 >> +	}
 >> +
 >> +	mac = prop->value;
 >> +
 >> +	mac[0] = hi;
 >> +	mac[1] = hi >> 8;
 >> +	mac[2] = hi >> 16;
 >> +	mac[3] = hi >> 24;
 >> +	mac[4] = lo;
 >> +	mac[5] = lo >> 8;
 >> +
 >> +	of_update_property(np, prop);

 Olof> mach-mxs does this too, I wonder if it's worth creating a small helper for it.

Yeah, guess where I got the inspiration to do this from? ;)


 Olof> Doesn't have to be done as part of this patch but it's still worth doing.


Ok, I'll send a patch adding of_set_mac_address() and change am335x /
mxs to use it once this is in.


 >> +
 >> +	pr_info("cpsw.%d: No hwaddr in dt. Using %pM from efuse\n", idx, mac);
 >> +}
 >> +
 >> +static int __init am33xx_dt_cpsw_mac_fixup(void)
 >> +{
 >> +	struct device_node *np, *slave;
 >> +	int idx = 0;
 >> +
 >> +	if (!soc_is_am33xx())
 >> +		return -ENODEV;
 >> +
 >> +	for_each_compatible_node(np, NULL, "ti,cpsw")
 >> +		for_each_node_by_name(slave, "slave") {

 Olof> The binding doesn't enforce "slave" node names for the subnodes, so you
 Olof> should probably just iterate over children. Right now they are named
 Olof> slave@0 and slave@1, but lack reg properties (and a notion of what said
 Olof> reg property would symbolize).

True. This just follows what the cpsw driver does. I would prefer to
change the driver, this file, am33xx.dtsi and the bindings documentation
in one go rather than doing something else than the driver here.


 >> +			if (!of_get_mac_address(slave))
 >> +				am33xx_dt_cpsw_set_mac_from_efuse(slave, idx);
 >> +			idx++;

 Olof> You're assuming that you get the children in order here, which is not
 Olof> guaranteed.

Again, this is in line with cpsw.c. Once we add a reg property we can
use that as idx.


 Olof> Maybe best is to adjust the binding, to make "reg" mean something
 Olof> (i.e. the MAC index for this hardware) and use the <reg> property
 Olof> of the childnode to tell which efuse to read.

Indeed.

-- 
Bye, Peter Korsgaard
