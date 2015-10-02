From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: dflt: fix enable_reg validity check
Date: Fri, 2 Oct 2015 09:36:00 +0300
Message-ID: <560E25D0.5080902@ti.com>
References: <1443566267-50225-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1443566267-50225-1-git-send-email-s-anna@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/30/2015 01:37 AM, Suman Anna wrote:
> The default clock enabling functions for TI clocks -
> omap2_dflt_clk_enable() and omap2_dflt_clk_disable() perform a
> NULL check for the enable_reg field of the clk_hw_omap structure.
> This enable_reg field however is merely a combination of the index
> of the master IP module, and the offset from the master IP module's
> base address. A value of 0 is perfectly valid, and the current error
> checking will fail in these cases. The issue was found when trying
> to enable the iva2_ck clock on OMAP3 platforms.
>
> So, switch the check to use IS_ERR. This correction is similar to the
> logic used in commit c807dbedb5e5 ("clk: ti: fix ti_clk_get_reg_addr
> error handling").
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> Hi Tero,
>
> Patch done against 4.3-rc3. There are couple of similar checks in
> drivers/clk/ti/clockdomain.c, but those seem to be ok. This is
> a non-urgent fix, as there are currently no active users of
> iva2_ck in the kernel (the MMU node is disabled in DT atm).
>
> Boot tested on OMAP3 Beagle-XM, AM437x GP EVM, AM335x BeagleBone
> Black, OMAP4 Panda, OMAP5 uEVM and DRA7 Beagle-X15 boards.
>
> regards
> Suman
>
> Following is the error log from a unit test of the IVA MMU on OMAP3 using
> some additional patch to enable the DTS node,
>
> [   86.626342] omap_iommu_test_init: iommu_test_init entered
> [   86.632080] omap_iommu_test iommu_test: Enabling IOMMU...
> [   86.647460] omap_iommu_test iommu_test: testing IOMMU 5d000000.mmu
> [   86.654815] omap2_dflt_clk_enable: iva2_ck missing enable_reg
> [   86.680938] ------------[ cut here ]------------
> [   86.685821] WARNING: CPU: 0 PID: 910 at drivers/clk/clk.c:675 clk_disable+0x28/0x34()
> [   86.694091] Modules linked in: iommu_dt_test(O+)
> [   86.698974] CPU: 0 PID: 910 Comm: insmod Tainted: G           O    4.3.0-rc3-00008-g61458979cbbe #40
> [   86.708618] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [   86.715240] [<c0017b44>] (unwind_backtrace) from [<c0013eac>] (show_stack+0x10/0x14)
> [   86.723419] [<c0013eac>] (show_stack) from [<c0342a04>] (dump_stack+0x84/0x9c)
> [   86.731048] [<c0342a04>] (dump_stack) from [<c003e924>] (warn_slowpath_common+0x78/0xb4)
> [   86.739593] [<c003e924>] (warn_slowpath_common) from [<c003e9fc>] (warn_slowpath_null+0x1c/0x24)
> [   86.748870] [<c003e9fc>] (warn_slowpath_null) from [<c04fe4c8>] (clk_disable+0x28/0x34)
> [   86.757324] [<c04fe4c8>] (clk_disable) from [<c0027da0>] (_disable_clocks+0x18/0x68)
> [   86.765502] [<c0027da0>] (_disable_clocks) from [<c0029cd0>] (omap_hwmod_deassert_hardreset+0xc8/0x180)
> [   86.775421] [<c0029cd0>] (omap_hwmod_deassert_hardreset) from [<c002a7cc>] (omap_device_deassert_hardreset+0x34/
> 0x54)
> [   86.786621] [<c002a7cc>] (omap_device_deassert_hardreset) from [<c03d91f4>] (omap_iommu_attach_dev+0xbc/0x1fc)
> [   86.797180] [<c03d91f4>] (omap_iommu_attach_dev) from [<c03d5f9c>] (__iommu_attach_device+0x1c/0x80)
> [   86.806854] [<c03d5f9c>] (__iommu_attach_device) from [<bf000150>] (omap_iommu_test_probe+0xd0/0x21c [iommu_dt_t
> est])
> [   86.818054] [<bf000150>] (omap_iommu_test_probe [iommu_dt_test]) from [<c03e03ec>] (platform_drv_probe+0x44/0xa4
> )
> [   86.828857] [<c03e03ec>] (platform_drv_probe) from [<c03de9b0>] (driver_probe_device+0x1f4/0x2f0)
> [   86.838195] [<c03de9b0>] (driver_probe_device) from [<c03deb40>] (__driver_attach+0x94/0x98)
> [   86.847045] [<c03deb40>] (__driver_attach) from [<c03dce34>] (bus_for_each_dev+0x6c/0xa0)
> [   86.855651] [<c03dce34>] (bus_for_each_dev) from [<c03de0d4>] (bus_add_driver+0x18c/0x214)
> [   86.864349] [<c03de0d4>] (bus_add_driver) from [<c03df494>] (driver_register+0x78/0xf8)
> [   86.872772] [<c03df494>] (driver_register) from [<c0009804>] (do_one_initcall+0x80/0x1dc)
> [   86.881378] [<c0009804>] (do_one_initcall) from [<c0118b60>] (do_init_module+0x5c/0x1d0)
> [   86.889892] [<c0118b60>] (do_init_module) from [<c00cabf4>] (load_module+0x1818/0x1f70)
> [   86.898315] [<c00cabf4>] (load_module) from [<c00cb428>] (SyS_init_module+0xdc/0x14c)
> [   86.906555] [<c00cb428>] (SyS_init_module) from [<c000f6e0>] (ret_fast_syscall+0x0/0x1c)
> [   86.915039] ---[ end trace 49b229a4289ab8b2 ]---
> [   86.919891] omap_hwmod: mmu_iva: failed to hardreset
> [   86.925384] omap-iommu 5d000000.mmu: deassert_reset failed: -16
> [   86.931640] omap_iommu_test iommu_test: can't get omap iommu: -16
> [   86.938140] omap_iommu_test iommu_test: can't attach iommu device: -16
> [   86.945068] omap_iommu_test_init failed, ret = -16
>
>   drivers/clk/ti/clkt_dflt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued for 4.3-rc-fixes thanks, as I have other patches to push for that.

-Tero

>
> diff --git a/drivers/clk/ti/clkt_dflt.c b/drivers/clk/ti/clkt_dflt.c
> index 90d7d8a21c49..1ddc288fce4e 100644
> --- a/drivers/clk/ti/clkt_dflt.c
> +++ b/drivers/clk/ti/clkt_dflt.c
> @@ -222,7 +222,7 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
>   		}
>   	}
>
> -	if (unlikely(!clk->enable_reg)) {
> +	if (unlikely(IS_ERR(clk->enable_reg))) {
>   		pr_err("%s: %s missing enable_reg\n", __func__,
>   		       clk_hw_get_name(hw));
>   		ret = -EINVAL;
> @@ -264,7 +264,7 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
>   	u32 v;
>
>   	clk = to_clk_hw_omap(hw);
> -	if (!clk->enable_reg) {
> +	if (IS_ERR(clk->enable_reg)) {
>   		/*
>   		 * 'independent' here refers to a clock which is not
>   		 * controlled by its parent.
>

