From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 13 Feb 2013 13:43:37 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED1D197@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 <87k3qewcbt.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58401 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757077Ab3BMNnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 08:43:50 -0500
In-Reply-To: <87k3qewcbt.fsf@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Kevin,

On Tue, Feb 12, 2013 at 06:57:50, Kevin Hilman wrote:
[...]
> > +
> > +void (*am33xx_do_wfi_sram)(void);
> 
> static?

Will fix.

[...]

> > +
> > +	/*
> > +	 * By default the following IPs do not have MSTANDBY asserted
> > +	 * which is necessary for PER domain transition. If the drivers
> > +	 * are not compiled into the kernel HWMOD code will not change the
> > +	 * state of the IPs if the IP was not never enabled. To ensure
> > +	 * that there no issues with or without the drivers being compiled
> > +	 * in the kernel, we forcefully put these IPs to idle.
> > +	 */
> > +	omap_hwmod_enable(usb_oh);
> > +	omap_hwmod_enable(tptc0_oh);
> > +	omap_hwmod_enable(tptc1_oh);
> > +	omap_hwmod_enable(tptc2_oh);
> > +	omap_hwmod_enable(cpsw_oh);
> > +
> > +	omap_hwmod_idle(usb_oh);
> > +	omap_hwmod_idle(tptc0_oh);
> > +	omap_hwmod_idle(tptc1_oh);
> > +	omap_hwmod_idle(tptc2_oh);
> > +	omap_hwmod_idle(cpsw_oh);
> 
> I think I asked this in my review of v1, but why does this need to
> happen on every suspend attempt?
> 
> This should happen once on init, which will handle the case where there
> are no drivers, and if there are drivers, then the drivers need to
> handle this properly.  
> 
> I don't like this happening here on every suspend attempt, because it
> will surely hide bugs where drivers are not properly managing their own PM.
> 

By default these IPs don't have MSTANDBY asserted. When a low power transition
happens, the peripheral power domain loses context and hence the forced
MSTANDBY configuration in the IP is lost. To work around this problem we need
to assert MSTANDBY in every suspend-resume iteration.

I agree that this might hide PM bugs in the driver but to solve this problem we
need some mechanism for the PM code to know whether or not a driver is bound
to the corresponding platform devices. Any suggestions on this?

> > +	/* Try to put GFX to sleep */
> > +	pwrdm_set_next_fpwrst(gfx_pwrdm, PWRDM_FUNC_PWRST_OFF);
> > +
> > +	ret = cpu_suspend(0, am33xx_do_sram_idle);
> > +	status = pwrdm_read_fpwrst(gfx_pwrdm);
> > +	if (status != PWRDM_FUNC_PWRST_OFF)
> > +		pr_err("GFX domain did not transition\n");
> > +	else
> > +		pr_info("GFX domain entered low power state\n");
> 
> Do you really want this printed every time?
> 

Hmm... it could perhaps be clubbed with the overall status that's
printed. I kept it here since the GFX power domain is completely
under MPU control and hence this information would be useful in
finding out if there's a problem with the GFX suspend-resume.

> > +	/*
> > +	 * GFX_L4LS clock domain needs to be woken up to
> > +	 * ensure thet L4LS clock domain does not get stuck in transition
> > +	 * If that happens L3 module does not get disabled, thereby leading
> > +	 * to PER power domain transition failing
> > +	 *
> > +	 * The clock framework should take care of ensuring
> > +	 * that the clock domain is in the right state when
> > +	 * GFX driver is active.
> 
> Are you suggesting that the clock framework is not doing this already?
> 

No. This clkdm_*() calls are here to work-around an issue that I observed
when implementing suspend-resume. The force wakeup and sleep of the gfx_l4ls
clock domain across every suspend-resume is something I don't think can
be pushed to the clock framework.

> > +	 */
> > +	clkdm_wakeup(gfx_l4ls_clkdm);
> > +	clkdm_sleep(gfx_l4ls_clkdm);
> > +
> > +	if (ret) {
> > +		pr_err("Kernel suspend failure\n");
> > +	} else {
> > +		status = omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG1);
> 
> We're trying to git rid of direct control module register access, and
> consolidate them into control.c (for an eventual move to a driver.)  I
> see you've mostly done that in other parts of the series, but here's one
> that needs to move.

Yes, I somehow missed this one. Will take care of it in the next version.

> 
> > +		status &= IPC_RESP_MASK;
> > +		status >>= __ffs(IPC_RESP_MASK);
> > +
> > +		switch (status) {
> > +		case 0:
> > +			pr_info("Successfully put all powerdomains to target state\n");
> > +			/*
> > +			 * XXX: Leads to loss of logic state in PER power domain
> > +			 * Use SOC specific ops for this?
> > +			 */
> 
> huh?
> 

Ah... this is more of a TODO. There's no previous state entered information
in the PRCM registers. So to ensure that the drivers get the right information
when they check with the PM layer about the loss of context and hence the need
to restore the registers, I need to update the logic and membank state counters
for the PER power domain manually. I was thinking of leveraging the SoC specific
power domain ops for doing this.

[...]

> > +
> > +	/* Give some time to M3 to respond. 500msec is a random value here */
> 
> random?  really?

Sort of. I don't have any numbers from the h/w guys on the worst
case delay in getting an interrupt from M3 to MPU. At the same time
I want to handle the scenario where something goes wrong on the M3
side and it doesn't respond.

[...]

> > +
> > +/*
> > + * Dummy notifier for the mailbox
> > + * XXX: Get rid of this requirement once the MBX driver has been finalized
> 
> IIRC, I suggested a trivial fix to the mailbox driver that would remove
> the need for this, which could be done today.
> 

Yes. I plan to do that once the mailbox code movement to drivers/ along with
other changes to make it generic enough are finalized. It was adding in one
more dependency and hence I kept this as a TODO in this version.

[...]

> > +static int wkup_m3_init(void)
> > +{
> > +	int irq, ret = 0;
> > +	struct resource *mem;
> > +	struct platform_device *pdev = to_platform_device(wkup_m3->dev);
> > +
> > +	omap_device_enable_hwmods(to_omap_device(pdev));
> 
> Why not omap_device_enable(pdev) ?
> 

The objective is to leverage the hwmod code to get the WKUP-M3
functional and not have OMAP runtime PM code coming in the way. 
Using omap_device_enable() triggers the following dev_warn()
from omap_device_enable().

[    2.033718] platform 44d00000.wkup_m3: omap_device_late_idle: enabled but no driver.  Idling
[    2.042676] ------------[ cut here ]------------
[    2.047572] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2187 _idle+0x164/0x1c0()
[    2.055459] omap_hwmod: wkup_m3: idle state can only be entered from enabled state
[    2.063435] Modules linked in:
[    2.066712] [<c001afe4>] (unwind_backtrace+0x0/0xf0) from [<c004380c>] (warn_slowpath_common+0x4c/0x64)
[    2.076626] [<c004380c>] (warn_slowpath_common+0x4c/0x64) from [<c00438b8>] (warn_slowpath_fmt+0x30/0x40)
[    2.086720] [<c00438b8>] (warn_slowpath_fmt+0x30/0x40) from [<c002aad0>] (_idle+0x164/0x1c0)
[    2.095624] [<c002aad0>] (_idle+0x164/0x1c0) from [<c002af98>] (omap_hwmod_idle+0x24/0x40)
[    2.104348] [<c002af98>] (omap_hwmod_idle+0x24/0x40) from [<c002bd60>] (omap_device_idle_hwmods+0x24/0x3c)
[    2.114536] [<c002bd60>] (omap_device_idle_hwmods+0x24/0x3c) from [<c002bf4c>] (_omap_device_deactivate+0x98/0x134)
[    2.125546] [<c002bf4c>] (_omap_device_deactivate+0x98/0x134) from [<c002c87c>] (omap_device_idle+0x28/0x54)
[    2.135921] [<c002c87c>] (omap_device_idle+0x28/0x54) from [<c06ec00c>] (omap_device_late_idle+0x44/0x54)
[    2.146025] [<c06ec00c>] (omap_device_late_idle+0x44/0x54) from [<c031f850>] (bus_for_each_dev+0x50/0x7c)
[    2.156120] [<c031f850>] (bus_for_each_dev+0x50/0x7c) from [<c06ebe10>] (omap_device_late_init+0x18/0x28)
[    2.166216] [<c06ebe10>] (omap_device_late_init+0x18/0x28) from [<c00086e4>] (do_one_initcall+0x34/0x180)
[    2.176314] [<c00086e4>] (do_one_initcall+0x34/0x180) from [<c06df8f8>] (kernel_init_freeable+0xfc/0x1cc)
[    2.186408] [<c06df8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d4b20>] (kernel_init+0x8/0xe4)
[    2.195962] [<c04d4b20>] (kernel_init+0x8/0xe4) from [<c0013410>] (ret_from_fork+0x14/0x24)
[    2.204905] ---[ end trace 8f61b319779f6e57 ]---

Regards,
Vaibhav
