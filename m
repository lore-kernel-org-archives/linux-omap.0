From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Should I worry about "omap-mcbsp.2: alias fck already exists"
 or is it expected?
Date: Mon, 12 Dec 2011 11:34:13 +0100
Message-ID: <4EE5D8A5.1010308@ti.com>
References: <20111212103553.044b17bb@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50704 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1LLKeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 05:34:22 -0500
In-Reply-To: <20111212103553.044b17bb@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>

+ Paul and Peter

Hi Neil,

On 12/12/2011 12:35 AM, NeilBrown wrote:
>
> In 3.2-rc5 (and some earlier kernels) I'm getting the boot-time warning:
>
> [    0.186828]  omap-mcbsp.2: alias fck already exists
>
> and
>
> [    0.188476]  omap-mcbsp.3: alias fck already exists
>
> This happens because omap_alloc_device() contains:
>
>
> 	for (i = 0; i<  oh_cnt; i++) {
> 		hwmods[i]->od = od;
> 		_add_hwmod_clocks_clkdev(od, hwmods[i]);
> 	}
>
> so if oh_cnt is ever>  1 (which is is for mcbsp.2 and .3 in
> omap_hwmod_3xxx_data.c as they both declare a '.devattr'), then
> _add_hwmod_clocks_clkdev will be called twice with the one 'od', and both
> calls will try to add an alias 'fsck' to that same device, and the second
> will always give a warning.
>
> Is this actually a bug,

It is indeed a bug. The point is that in theory most hwmod should have 
an unique device to represent them. But in the case of the Mcbsp2 and 3, 
due to the tightly coupled sidetone, and because each one has a 
dedicated OCP port, it was decided to have 2 hwmods but only one 
omap_device.

I'm wondering now if another device should not be considered, but I'll 
let Peter decide for the McBSP driver organization.

> or should we silence the warning on second and
> subsequent calls to omap_alloc_device()?

We can have only one "fck" alias per device, so preventing to register 
any subsequent fck seems the good approach to me.
The warning was added to detect a potential static version of the clkdev 
and thus eliminate it, so we should keep it.

> Like this?
>
> Thanks,
> NeilBrown
>
> omap: don't try to register the main clock twice.

ARM: OMAP2+: Don't try to register the main clock twice

> If omap_device_alloc is given 2 or more "struct omap_hwmod" it will try to
> register the 'main_clk' of each of them with the same alias - "fck" - against
> the same device.  This fails.
> So to avoid a warning, don't even try.
>
> Signed-off-by: NeilBrown<neilb@suse.de>

Acked-by: Benoit Cousson <b-cousson@ti.com>

> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index e8d9869..11012bd 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -294,6 +294,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
>    * and main clock
>    * @od: struct omap_device *od
>    * @oh: struct omap_hwmod *oh
> + * @sub: this is a subordinate device, so don't try to register fck
>    *
>    * For the main clock and every optional clock present per hwmod per
>    * omap_device, this function adds an entry in the clkdev table of the
> @@ -309,11 +310,12 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
>    * No return value.
>    */
>   static void _add_hwmod_clocks_clkdev(struct omap_device *od,
> -				     struct omap_hwmod *oh)
> +				     struct omap_hwmod *oh, int sub)
>   {
>   	int i;
>
> -	_add_clkdev(od, "fck", oh->main_clk);
> +	if (!sub)
> +		_add_clkdev(od, "fck", oh->main_clk);
>
>   	for (i = 0; i<  oh->opt_clks_cnt; i++)
>   		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
> @@ -576,7 +578,7 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
>
>   	for (i = 0; i<  oh_cnt; i++) {
>   		hwmods[i]->od = od;
> -		_add_hwmod_clocks_clkdev(od, hwmods[i]);
> +		_add_hwmod_clocks_clkdev(od, hwmods[i], i);
>   	}
>
>   	return od;

Thanks for the fix.

Regards,
Benoit
