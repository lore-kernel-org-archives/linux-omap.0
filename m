From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 11/11] ARM: OMAP2+: omap_hwmod: Don't call _init_mpu_rt_base
 if no sysc
Date: Wed, 10 Apr 2013 20:46:59 -0500
Message-ID: <51661613.4070405@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com> <1363699857-5505-12-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37139 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3DKBrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 21:47:08 -0400
In-Reply-To: <1363699857-5505-12-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>


On 03/19/2013 08:30 AM, Santosh Shilimkar wrote:
> OMAP hwmod layer does the reset of the IPs in early code so that
> we have SOC in sane state. To do the soft-reset, it needs to ioremap()
> the ip address space to be able to write to sysconfig registers.
> 
> But there are few hwmod which doesn't have sysconfig registers and hence
> no need to ioremap() them in early init code.
> 
> So this patch makes prevet calling the _init_mpu_rt_base() conditional
> based on sysc availability.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 4501038..1a1f0a4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2449,7 +2449,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
>  	if (oh->_state != _HWMOD_STATE_REGISTERED)
>  		return 0;
>  
> -	_init_mpu_rt_base(oh, NULL);
> +	if (oh->class->sysc)
> +		_init_mpu_rt_base(oh, NULL);
>  
>  	r = _init_clocks(oh, NULL);
>  	if (IS_ERR_VALUE(r)) {

I have not looked into why, but this commit is triggering the following
panic on am335x-evm. I don't see this on the omap platforms only am335x. 

Adding Vaibhav ...

Jon

[    2.059957] Unhandled fault: external abort on non-linefetch (0x1028) at 0xf9e35034
[    2.068067] Internal error: : 1028 [#1] SMP ARM
[    2.072856] Modules linked in:
[    2.076102] CPU: 0    Not tainted  (3.9.0-rc3-00051-g4a98c2d #774)
[    2.082651] PC is at omap_wdt_disable.isra.5+0xc/0x60
[    2.087988] LR is at omap_wdt_probe+0x170/0x200
[    2.092774] pc : [<c04447b8>]    lr : [<c0444b00>]    psr: 60000113
[    2.092774] sp : de05de68  ip : 00000001  fp : 00000000
[    2.104888] r10: dd2243c0  r9 : 00000000  r8 : c1312c38
[    2.110404] r7 : dd2403d0  r6 : de0ae3c0  r5 : de0e7c10  r4 : dd181210
[    2.117293] r3 : f9e35034  r2 : 00000000  r1 : 04a00000  r0 : f9e35000
[    2.124185] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.131901] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    2.137967] Process swapper/0 (pid: 1, stack limit = 0xde05c240)
[    2.144308] Stack: (0xde05de68 to 0xde05e000)
[    2.148915] de60:   
[    2.151231] de80: c0db1f98 c07afe40 c07893f8 c0364284 c036426c c0362ef4 de0e7c10 c0db1f98
[    2.159870] dea0: de0e7c44 00000000 00000000 c036309c c0db1f98 c0363008 00000000 c03615e4
[    2.168509] dec0: de01e2a8 de0cdb10 c0db1f98 c0da0b38 dd240440 c036256c c069606c 00000000
[    2.177148] dee0: de051d40 c0db1f98 de05c000 c0dbdd00 00000000 00000000 c07afe40 c07893f8
[    2.185786] df00: 00000000 c0363568 c03642ac c0793ec4 de05c000 c0dbdd00 00000000 000000a3
[    2.194424] df20: c07893f8 c00086a4 c07306d8 c0731108 c1722d6b c07893f8 00000001 c1722d77
[    2.203061] df40: c06f1144 00000000 00000006 00000006 00000001 c0793ec4 00000006 c0793ea4
[    2.211699] df60: c0dbdd00 000000a3 c07afe40 c075f1c4 00000000 c075f8f8 00000006 00000006
[    2.220338] df80: c075f1c4 00000000 00000000 c0547dec 00000000 00000000 00000000 00000000
[    2.228975] dfa0: 00000000 c0547df4 00000000 c0013e50 00000000 00000000 00000000 00000000
[    2.237615] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.246252] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 fbffffeb ff3fbefe
[    2.254904] [<c04447b8>] (omap_wdt_disable.isra.5+0xc/0x60) from [<c0444b00>] (omap_wdt_probe+0x170/0x200)
[    2.265118] [<c0444b00>] (omap_wdt_probe+0x170/0x200) from [<c0364284>] (platform_drv_probe+0x18/0x1c)
[    2.274955] [<c0364284>] (platform_drv_probe+0x18/0x1c) from [<c0362ef4>] (driver_probe_device+0x108/0x21c)
[    2.285248] [<c0362ef4>] (driver_probe_device+0x108/0x21c) from [<c036309c>] (__driver_attach+0x94/0x98)
[    2.295263] [<c036309c>] (__driver_attach+0x94/0x98) from [<c03615e4>] (bus_for_each_dev+0x54/0x88)
[    2.304822] [<c03615e4>] (bus_for_each_dev+0x54/0x88) from [<c036256c>] (bus_add_driver+0xdc/0x29c)
[    2.314381] [<c036256c>] (bus_add_driver+0xdc/0x29c) from [<c0363568>] (driver_register+0x78/0x190)
[    2.323941] [<c0363568>] (driver_register+0x78/0x190) from [<c00086a4>] (do_one_initcall+0x34/0x178)
[    2.333605] [<c00086a4>] (do_one_initcall+0x34/0x178) from [<c075f8f8>] (kernel_init_freeable+0xfc/0x1c4)
[    2.343728] [<c075f8f8>] (kernel_init_freeable+0xfc/0x1c4) from [<c0547df4>] (kernel_init+0x8/0xe4)
[    2.353300] [<c0547df4>] (kernel_init+0x8/0xe4) from [<c0013e50>] (ret_from_fork+0x14/0x24)
[    2.362124] Code: e8bd80f8 e59f3050 e5803048 e2803034 (e5902034) 
[    2.368631] ---[ end trace 63f90a88f45b89ae ]---
[    2.373734] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
 
