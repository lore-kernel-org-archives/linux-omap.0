From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: Re: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Mon, 19 Mar 2012 17:23:57 +0100
Message-ID: <4F675D9D.2040102@uni-dortmund.de>
References: <4F6324D5.9010106@uni-dortmund.de> <20120316193337.GE7276@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010407020702070803060409"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:47823 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031218Ab2CSQYD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 12:24:03 -0400
In-Reply-To: <20120316193337.GE7276@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407020702070803060409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.03.2012 20:33, schrieb Tony Lindgren:
> Hi,
> 
> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120316 05:08]:
>> Hi,
>>
>> I have trouble getting the Ethernet port on a Gumstix Overo with Tobi
>> expansion board to work with current kernel versions. With the latest
>> commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11facec2aa),
>> the output from loading the smsc911x driver is as follows:
>>
>> du14:~# modprobe smsc911x
>> [  254.843811] smsc911x: Driver version 2008-10-21
>> [  254.854553] smsc911x: Driver version 2008-10-21
>> [  254.859588] _regulator_get: smsc911x.1 supply vdd33a not found, using
>> dummy regulator
>> [  254.868377] _regulator_get: smsc911x.1 supply vddvario not found,
>> using dummy regulator
>>
>> "ip link show" does not show any available Ethernet port.
> 
> The first instance one should work the same way as earlier using
> fixed regulator in gpmc-smsc911x.c. Is it not working for you
> somehow? At least it works for me on zoom3.

The Tobi board has only one Ethernet port.

>> I know there has been some trouble with changes around smsc911x
>> regulator support and Gumstix Overo in particular. Am I just missing the
>> right regulator in my kernel config or is this a bug? I can test patches
>> in the latter case.
> 
> The second smsc911x now needs a regulator. For multiple smsc911x instances,
> we should change things around so no regulator is created if one
> is passed.
> 
> Care to test the following patch by passing a fixed regulator
> from board-overo.c?

After applying the patch the Ethernet port works consistently once I had
done a cold boot (reboot from the unpatched kernel did not work).
Thank you!

However, I noticed another problem while testing the patch (not sure if
it occurs with the previous version, I can check if that helps): A NULL
pointer dereference occurs when unloading the module, see attached log.

Regards,
Thomas

> You can copy the fixed regulator from gpmc-smsc911x.c, or ideally pass
> the real smsc911x controlling regulator for overo.
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 16 Mar 2012 12:26:25 -0700
> Subject: [PATCH] ARM: OMAP2+: Allow passing smsc911x regulator from boards
> 
> Otherwise we won't be able to properly support multiple
> instances of smsc911x.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
> @@ -97,17 +97,26 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>  {
>  	struct platform_device *pdev;
>  	unsigned long cs_mem_base;
> +	struct platform_device *regulator = NULL;
>  	int ret;
>  
>  	gpmc_cfg = board_data;
>  
> -	if (!gpmc_cfg->id) {
> -		ret = platform_device_register(&gpmc_smsc911x_regulator);
> -		if (ret < 0) {
> -			pr_err("Unable to register smsc911x regulators: %d\n",
> -			       ret);
> -			return;
> -		}
> +	if (gpmc_cfg->regulator)
> +		regulator = gpmc_cfg->regulator;
> +	else if (!gpmc_cfg->id)
> +		regulator = &gpmc_smsc911x_regulator;
> +
> +	if (!regulator) {
> +		pr_err("Missing smsc911x regulator in board_data\n");
> +		return;
> +	}
> +
> +	ret = platform_device_register(regulator);
> +	if (ret < 0) {
> +		pr_err("Unable to register smsc911x regulators: %d\n",
> +		       ret);
> +		return;
>  	}
>  
>  	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
> --- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
> @@ -19,6 +19,7 @@ struct omap_smsc911x_platform_data {
>  	int	gpio_irq;
>  	int	gpio_reset;
>  	u32	flags;
> +	struct platform_device *regulator;
>  };
>  
>  #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)

--------------010407020702070803060409
Content-Type: text/x-log;
 name="smsc911x-unload-error.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="smsc911x-unload-error.log"

du14:~# modprobe -r smsc911x
[  213.617767] Unable to handle kernel NULL pointer dereference at virtual address 0000073c
[  213.627044] pgd = d56b8000
[  213.630554] [0000073c] *pgd=00000000
[  213.634948] Internal error: Oops: 5 [#1]
[  213.639068] Modules linked in: ipt_MASQUERADE xt_tcpudp iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables x_tables ath9k_htc ath9k_common ath9k_hw carl9170 ath snd_soc_twl4030 smsc ohci_hcd ehci_hcd snd_soc_core regmap_spi regmap_i2c snd_pcm snd_timer smsc911x(-) libertas_sdio snd soundcore snd_page_alloc libertas twl4030_usb
[  213.671844] CPU: 0    Tainted: G        W     (3.3.0-rc7-11899-gb8fe178-dirty #103)
[  213.679901] PC is at regulator_bulk_disable+0x18/0x90
[  213.685211] LR is at smsc911x_drv_remove+0xd4/0xf4 [smsc911x]
[  213.691253] pc : [<c02395fc>]    lr : [<bf0599cc>]    psr: 80000013
[  213.691253] sp : d56b7ed8  ip : 00000002  fp : bea9fdb4
[  213.703277] r10: 00000738  r9 : d56b6000  r8 : 00000002
[  213.708770] r7 : d6c85408  r6 : 00000738  r5 : d6c85400  r4 : 00000000
[  213.715606] r3 : d6534500  r2 : 00000000  r1 : 00000738  r0 : 00000002
[  213.722442] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  213.729919] Control: 10c5387d  Table: 956b8019  DAC: 00000015
[  213.735961] Process modprobe (pid: 2395, stack limit = 0xd56b62f0)
[  213.742431] Stack: (0xd56b7ed8 to 0xd56b8000)
[  213.747009] 7ec0:                                                       d6534500 d6779000
[  213.755584] 7ee0: d6c85400 00000000 d6c85408 c000d484 00000000 bf0599cc bf0598f8 d6c85408
[  213.764160] 7f00: bf05b6dc d6c8543c 00000081 c02618d0 c02618bc c026041c d6c85408 bf05b6dc
[  213.772735] 7f20: d6c8543c c02609f0 bf05b6dc 00000000 c0664b08 c02602f8 bf05b718 00000000
[  213.781311] 7f40: b6f3b1b0 c0064db0 d6c48588 63736d73 78313139 c00a3b00 d6534500 00000001
[  213.789916] 7f60: 00000000 d6534500 00000001 c000d3d4 00000081 60000010 b6f3b208 bea9fdc0
[  213.798492] 7f80: bea9fdb4 0005e8c8 b6f3b180 b6f3b180 b6f3b1b0 00000000 b6f3b180 b6f3b180
[  213.807067] 7fa0: b6f3b1b0 c000d2c0 b6f3b180 b6f3b180 b6f3b1b0 00000000 b6f3a000 00000000
[  213.815643] 7fc0: b6f3b180 b6f3b180 b6f3b1b0 00000081 00000000 b6f3b208 bea9fdc0 bea9fdb4
[  213.824218] 7fe0: 00000000 bea9e990 b6f23988 b6e51b5c 60000010 b6f3b1b0 00000000 00000000
[  213.832824] [<c02395fc>] (regulator_bulk_disable+0x18/0x90) from [<bf0599cc>] (smsc911x_drv_remove+0xd4/0xf4 [smsc911x])
[  213.844268] [<bf0599cc>] (smsc911x_drv_remove+0xd4/0xf4 [smsc911x]) from [<c02618d0>] (platform_drv_remove+0x14/0x18)
[  213.855407] [<c02618d0>] (platform_drv_remove+0x14/0x18) from [<c026041c>] (__device_release_driver+0x7c/0xbc)
[  213.865905] [<c026041c>] (__device_release_driver+0x7c/0xbc) from [<c02609f0>] (driver_detach+0x8c/0xb4)
[  213.875885] [<c02609f0>] (driver_detach+0x8c/0xb4) from [<c02602f8>] (bus_remove_driver+0x8c/0xb4)
[  213.885284] [<c02602f8>] (bus_remove_driver+0x8c/0xb4) from [<c0064db0>] (sys_delete_module+0x1ec/0x280)
[  213.895233] [<c0064db0>] (sys_delete_module+0x1ec/0x280) from [<c000d2c0>] (ret_fast_syscall+0x0/0x3c)
[  213.904998] Code: e1a06001 e1a0a001 e3a04000 ea000006 (e59a0004) 
[  213.913635] ---[ end trace 3dd21d0e580906b5 ]---
Speicherzugriffsfehler
du14:~# 

--------------010407020702070803060409--
