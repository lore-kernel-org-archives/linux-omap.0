From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Sun, 4 Nov 2012 15:26:25 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD4D@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
 <50954CEF.5080209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755565Ab2KDP0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 10:26:31 -0500
In-Reply-To: <50954CEF.5080209@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sat, Nov 03, 2012 at 22:27:19, Shilimkar, Santosh wrote:
[...]

> >
> Nice descriptive change log Vaibhav.

Thanks :)

> 
[...]

> > +#include "soc.h"
> > +
> In case not checked yet, see if you need
> all above headers.
> 

Will double-check, I know it's a long list of includes.

> > +void (*am33xx_do_wfi_sram)(void);
> > +
> > +static void __iomem *am33xx_emif_base;
> > +static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm;
> > +static struct clockdomain *gfx_l3_clkdm, *gfx_l4ls_clkdm;
> > +static struct wkup_m3_context *wkup_m3;
> > +
> > +static DECLARE_COMPLETION(wkup_m3_sync);
> > +
> > +#ifdef CONFIG_SUSPEND
> > +static int am33xx_do_sram_idle(long unsigned int unused)
> > +{
> > +	am33xx_do_wfi_sram();
> > +	return 0;
> > +}
> > +
> > +static int am33xx_pm_suspend(void)
> > +{
> > +	int status, ret = 0;
> > +
> > +	struct omap_hwmod *gpmc_oh, *usb_oh;
> > +	struct omap_hwmod *tptc0_oh, *tptc1_oh, *tptc2_oh;
> > +
> > +	/*
> > +	 * By default the following IPs do not have MSTANDBY asserted
> > +	 * which is necessary for PER domain transition. If the drivers
> > +	 * are not compiled into the kernel HWMOD code will not change the
> > +	 * state of the IPs if the IP was not never enabled
> > +	 */
> > +	usb_oh		= omap_hwmod_lookup("usb_otg_hs");
> > +	gpmc_oh		= omap_hwmod_lookup("gpmc");
> > +	tptc0_oh	= omap_hwmod_lookup("tptc0");
> > +	tptc1_oh	= omap_hwmod_lookup("tptc1");
> > +	tptc2_oh	= omap_hwmod_lookup("tptc2");
> > +
> This look you don't need every suspend.
>

Sorry I don't follow you here.
 
> > +	omap_hwmod_enable(usb_oh);
> > +	omap_hwmod_enable(gpmc_oh);
> > +	omap_hwmod_enable(tptc0_oh);
> > +	omap_hwmod_enable(tptc1_oh);
> > +	omap_hwmod_enable(tptc2_oh);
> > +
> > +	omap_hwmod_idle(usb_oh);
> > +	omap_hwmod_idle(gpmc_oh);
> > +	omap_hwmod_idle(tptc0_oh);
> > +	omap_hwmod_idle(tptc1_oh);
> > +	omap_hwmod_idle(tptc2_oh);
> > +
> Calling omap_hwmod_idle() directly tells me something is not
> right. Can these module not idle themself with respective device
> drivers ?
> 

With device drivers, yes. The problem comes if the drivers are not
compiled in. MSTANDBY needs to be forced for each suspend cycle.
During resume, these IPs come out of standby and sysconfig changes.

If it makes sense I could add a new HWMOD flag and some sort of
suspend-resume routine, perhaps syscore_ops, in there to do
this?

> > +	/* Put the GFX clockdomains to sleep */
> > +	clkdm_sleep(gfx_l3_clkdm);
> > +	clkdm_sleep(gfx_l4ls_clkdm);
> Can GFX driver suspend code not take care of above ?

Will check if the GFX driver does this. I needed this to ensure
that even without the GFX driver the PER domain transition doesn't
get blocked.

> Also are these clock domains are not supporting HW supervised
> mode ?

All clock domains in AM33xx are SW-supervised.
> 
> > +	/* Try to put GFX to sleep */
> > +	pwrdm_set_next_pwrst(gfx_pwrdm, PWRDM_POWER_OFF);
> > +
> Above as well can be taken care by constraint QOS API by
> GFX driver.
> 

Will check if I can get rid of this.

> > +	ret = cpu_suspend(0, am33xx_do_sram_idle);
> > +
> > +	status = pwrdm_read_pwrst(gfx_pwrdm);
> > +	if (status != PWRDM_POWER_OFF)
> > +		pr_err("GFX domain did not transition\n");
> > +	else
> > +		pr_info("GFX domain entered low power state\n");
> > +
> > +	/* Needed to ensure L4LS clockdomain transitions properly */
> > +	clkdm_wakeup(gfx_l3_clkdm);
> > +	clkdm_wakeup(gfx_l4ls_clkdm);
> > +
> > +	if (ret) {
> > +		pr_err("Kernel suspend failure\n");
> > +	} else {
> > +		status = omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG1);
> > +		status &= IPC_RESP_MASK;
> > +		status >>= __ffs(IPC_RESP_MASK);
> > +
> > +		switch (status) {
> > +		case 0:
> > +			pr_info("Successfully transitioned to low power state\n");
> > +			if (wkup_m3->sleep_mode == IPC_CMD_DS0)
> > +				/* XXX: Use SOC specific ops for this? */
> > +				per_pwrdm->ret_logic_off_counter++;
> > +			break;
> > +		case 1:
> > +			pr_err("Could not enter low power state\n");
> > +			ret = -1;
> > +			break;
> > +		default:
> > +			pr_err("Something is terribly wrong :(\nStatus = %d\n",
> > +				status);
> Sounds terrible :-)
> 

Well this is not the expected state. But I guess better to leave in a
message instead of ignoring the unexpected :)

[...]

> > +	if (!wait_for_completion_timeout(&wkup_m3_sync,
> > +					msecs_to_jiffies(500))) {
> 
> 500 is from spec or arbitrary timeout ?
> 

We just need enough delay to let the M3 respond. I didn't have the
hw delays so put in a timeout which is not too big.

[...]

> > +
> > +	ret = am33xx_map_emif();
> > +
> No EMIF driver to handle EMIF MAP, registers etc ?
> 

We just need to ioremap it here. EMIF registers are updated
from assembly only.

[...]

> > +#define EMIF_DDR_PHY_CTRL_1_SHDW			0x00e8
> > +
> Above should be part of the EMIF driver, no ?
> 

The driver would end up being a dummy driver which just does
an ioremap so I added the register offsets here.

[...]

> > +
> Sleep code looks pretty big so I will have a closer look at it bit
> later. At least from the code it seems, the EMIF registers and hence
> memory controller needs to be maneged by SW which is really bad.
> 

It will get a slightly bigger once DDR3 specific handling gets added ;)
I agree the s/w managed memory controller is not good. It even places
limitations on Core DVFS.

Regards,
Vaibhav
