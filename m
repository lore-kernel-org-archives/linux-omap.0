From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Mon, 05 Nov 2012 09:40:27 -0800
Message-ID: <87txt4aqyc.fsf@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
	<1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42257 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab2KERk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 12:40:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4078030pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 09:40:28 -0800 (PST)
In-Reply-To: <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
	(Vaibhav Bedia's message of "Fri, 2 Nov 2012 18:02:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

+Santosh (to help with EMIF questions/comments)

On 11/02/2012 12:32 PM, Vaibhav Bedia wrote:
> AM335x supports various low power modes as documented
> in section 8.1.4.3 of the AM335x TRM which is available
> @ http://www.ti.com/litv/pdf/spruh73f
>
> DeepSleep0 mode offers the lowest power mode with limited
> wakeup sources without a system reboot and is mapped as
> the suspend state in the kernel. In this state, MPU and
> PER domains are turned off with the internal RAM held in
> retention to facilitate resume process. As part of the boot
> process, the assembly code is copied over to OCMCRAM using
> the OMAP SRAM code.
>
> AM335x has a Cortex-M3 (WKUP_M3) which assists the MPU
> in DeepSleep0 entry and exit. WKUP_M3 takes care of the
> clockdomain and powerdomain transitions based on the
> intended low power state. MPU needs to load the appropriate
> WKUP_M3 binary onto the WKUP_M3 memory space before it can
> leverage any of the PM features like DeepSleep.
>
> The IPC mechanism between MPU and WKUP_M3 uses a mailbox
> sub-module and 8 IPC registers in the Control module. MPU
> uses the assigned Mailbox for issuing an interrupt to
> WKUP_M3 which then goes and checks the IPC registers for
> the payload. WKUP_M3 has the ability to trigger on interrupt
> to MPU by executing the "sev" instruction.
>
> In the current implementation when the suspend process
> is initiated MPU interrupts the WKUP_M3 to let about the
> intent of entering DeepSleep0 and waits for an ACK. When
> the ACK is received, MPU continues with its suspend process
> to suspend all the drivers and then jumps to assembly in
> OCMC RAM to put the PLLs in bypass, put the external RAM in
> self-refresh mode and then finally execute the WFI instruction.
> The WFI instruction triggers another interrupt to the WKUP_M3
> which then continues wiht the power down sequence wherein the
> clockdomain and powerdomain transition takes place. As part of
> the sleep sequence, WKUP_M3 unmasks the interrupt lines for
> the wakeup sources. When WKUP_M3 executes WFI, the hardware
> disables the main oscillator.
>
> When a wakeup event occurs, WKUP_M3 starts the power-up
> sequence by switching on the power domains and finally
> enabling the clock to MPU. Since the MPU gets powered down
> as part of the sleep sequence, in the resume path ROM code
> starts executing. The ROM code detects a wakeup from sleep
> and then jumps to the resume location in OCMC which was
> populated in one of the IPC registers as part of the suspend
> sequence.
>
> The low level code in OCMC relocks the PLLs, enables access
> to external RAM and then jumps to the cpu_resume code of
> the kernel to finish the resume process.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Very well summarized.  Thanks for the thorough changelog.

First, some general comments.  This is a big patch and probably should
be broken up a bit.  I suspect it could be broken up a bit, maybe into
at least:

- EMIF interface
- SCM interface, new APIs
- assembly/OCM code
- pm33xx.[ch]
- lastly, the late_init stuff that actually initizlizes 

I have a handful of comments below.  I wrote this up on the plane over
the weekend, and I see that Santosh has already made some similar
comments, but I'll send mine anyways.  

[...]

> +static int am33xx_pm_suspend(void)
> +{
> +	int status, ret = 0;
> +
> +	struct omap_hwmod *gpmc_oh, *usb_oh;
> +	struct omap_hwmod *tptc0_oh, *tptc1_oh, *tptc2_oh;
> +
> +	/*
> +	 * By default the following IPs do not have MSTANDBY asserted
> +	 * which is necessary for PER domain transition. If the drivers
> +	 * are not compiled into the kernel HWMOD code will not change the
> +	 * state of the IPs if the IP was not never enabled
> +	 */
> +	usb_oh		= omap_hwmod_lookup("usb_otg_hs");
> +	gpmc_oh		= omap_hwmod_lookup("gpmc");
> +	tptc0_oh	= omap_hwmod_lookup("tptc0");
> +	tptc1_oh	= omap_hwmod_lookup("tptc1");
> +	tptc2_oh	= omap_hwmod_lookup("tptc2");
> +
> +	omap_hwmod_enable(usb_oh);
> +	omap_hwmod_enable(gpmc_oh);
> +	omap_hwmod_enable(tptc0_oh);
> +	omap_hwmod_enable(tptc1_oh);
> +	omap_hwmod_enable(tptc2_oh);
> +
> +	omap_hwmod_idle(usb_oh);
> +	omap_hwmod_idle(gpmc_oh);
> +	omap_hwmod_idle(tptc0_oh);
> +	omap_hwmod_idle(tptc1_oh);
> +	omap_hwmod_idle(tptc2_oh);

Doing this on every suspend looks a bit strange.  Why not just have some
init function handle these devices once at boot.  If this is really
needed on every suspend, it needs some more description, and probably 
some basic stub drivers need to be created.

Also, if there are drivers for these devices, won't this interfere?

> +	/* Put the GFX clockdomains to sleep */
> +	clkdm_sleep(gfx_l3_clkdm);
> +	clkdm_sleep(gfx_l4ls_clkdm);
> +
> +	/* Try to put GFX to sleep */
> +	pwrdm_set_next_pwrst(gfx_pwrdm, PWRDM_POWER_OFF);

ditto.

[...]

> +static int am33xx_pm_begin(suspend_state_t state)
> +{
> +	int ret = 0;
> +
> +	disable_hlt();
> +
> +	/*
> +	 * Physical resume address to be used by ROM code
> +	 */
> +	wkup_m3->resume_addr = (AM33XX_OCMC_END - am33xx_do_wfi_sz +
> +					am33xx_resume_offset + 0x4);

Why does this need to be calculated every suspend/resume?

> +	wkup_m3->sleep_mode = IPC_CMD_DS0;
> +	wkup_m3->ipc_data1  = DS_IPC_DEFAULT;
> +	wkup_m3->ipc_data2  = DS_IPC_DEFAULT;
> +
> +	am33xx_ipc_cmd();

This IPC needs a cleaner interface/API.  Also, since it involves
register writes to the SCM, it should be defined in control.c.  (NOTE:
we're in the process of creating a real driver out of the SCM, so all
SCM register accesses need to be contained in control.c)

For example, you probably want an am33xx_m3_* API in control.c, with
some pre-baked commands for the M3.  

> +	wkup_m3->state = M3_STATE_MSG_FOR_LP;
>
> +	omap_mbox_enable_irq(wkup_m3->mbox, IRQ_RX);
> +
> +	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);
> +	if (ret) {
> +		pr_err("A8<->CM3 MSG for LP failed\n");
> +		am33xx_m3_state_machine_reset();
> +		ret = -1;
> +	}
> +
> +	if (!wait_for_completion_timeout(&wkup_m3_sync,
> +					msecs_to_jiffies(500))) {

hmm, interesting.  I know you're not implementing idle here, but I'm
rather curious how this sync w/M3 is going to work for idle.

> +		pr_err("A8<->CM3 sync failure\n");
> +		am33xx_m3_state_machine_reset();
> +		ret = -1;
> +	} else {
> +		pr_debug("Message sent for entering DeepSleep mode\n");
> +		omap_mbox_disable_irq(wkup_m3->mbox, IRQ_RX);
> +	}
> +
> +	return ret;
> +}
> +

[...]

> +static void am33xx_m3_state_machine_reset(void)
> +{
> +	int ret = 0;
> +
> +	wkup_m3->resume_addr	= 0x0;
> +	wkup_m3->sleep_mode	= IPC_CMD_RESET;
> +	wkup_m3->ipc_data1	= DS_IPC_DEFAULT;
> +	wkup_m3->ipc_data2	= DS_IPC_DEFAULT;
> +
> +	am33xx_ipc_cmd();
> +
> +	wkup_m3->state = M3_STATE_MSG_FOR_RESET;
> +
> +	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);

magic constant needs a #define

> +	if (!ret) {
> +		pr_debug("Message sent for resetting M3 state machine\n");
> +		if (!wait_for_completion_timeout(&wkup_m3_sync,
> +						msecs_to_jiffies(500)))
> +			pr_err("A8<->CM3 sync failure\n");
> +	} else {
> +		pr_err("Could not reset M3 state machine!!!\n");
> +		wkup_m3->state = M3_STATE_UNKNOWN;
> +	}
> +}
> +#endif /* CONFIG_SUSPEND */
> +
> +/*
> + * Dummy notifier for the mailbox
> + */
> +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg)
> +{
> +	return 0;
> +}
> +
> +static struct notifier_block wkup_mbox_notifier = {
> +	.notifier_call = wkup_mbox_msg,
> +};

Why do you need a dummy notifier?  Looks like maybe plat-omap/mailbox.c
needs a few minor fixes to support not being passed a notifier instead?

> +static irqreturn_t wkup_m3_txev_handler(int irq, void *unused)
> +{
> +	omap_ctrl_writel(0x1, AM33XX_CONTROL_M3_TXEV_EOI);

undocumented magic write (but presumably an IRQ ack?)

Note this also needs to be moved to control.c and given a useful API.

> +	switch (wkup_m3->state) {
> +	case M3_STATE_RESET:
> +		wkup_m3->state = M3_STATE_INITED;
> +		break;
> +	case M3_STATE_MSG_FOR_RESET:
> +		wkup_m3->state = M3_STATE_INITED;
> +		omap_mbox_msg_rx_flush(wkup_m3->mbox);
> +		complete(&wkup_m3_sync);
> +		break;
> +	case M3_STATE_MSG_FOR_LP:
> +		omap_mbox_msg_rx_flush(wkup_m3->mbox);
> +		complete(&wkup_m3_sync);
> +		break;
> +	case M3_STATE_UNKNOWN:
> +		pr_err("IRQ %d with WKUP_M3 in unknown state\n", irq);
> +		omap_mbox_msg_rx_flush(wkup_m3->mbox);
> +		return IRQ_NONE;
> +	}
> +
> +	omap_ctrl_writel(0x0, AM33XX_CONTROL_M3_TXEV_EOI);

undoumented magic write?

> +	return IRQ_HANDLED;
> +}
> +

[...]

> +static int wkup_m3_init(void)
> +{
> +	int irq, ret = 0;
> +	struct resource *mem;
> +	struct platform_device *pdev = to_platform_device(wkup_m3->dev);
> +
> +	omap_device_enable_hwmods(to_omap_device(pdev));
> +
> +	/* Reserve the MBOX for sending messages to M3 */
> +	wkup_m3->mbox = omap_mbox_get("wkup_m3", &wkup_mbox_notifier);
> +	if (IS_ERR(wkup_m3->mbox)) {
> +		pr_err("Could not reserve mailbox for A8->M3 IPC\n");
> +		ret = -ENODEV;
> +		goto exit;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		dev_err(wkup_m3->dev, "no memory resource\n");

if !mem, this continues and still tries to ioremap NULL.

> +	wkup_m3->code = devm_request_and_ioremap(wkup_m3->dev, mem);
> +	ret = devm_request_irq(wkup_m3->dev, irq, wkup_m3_txev_handler,
> +		  IRQF_DISABLED, "wkup_m3_txev", NULL);
> +	if (ret) {
> +		dev_err(wkup_m3->dev, "request_irq failed\n");
> +		goto err;
> +	}
> +
> +	pr_info("Trying to load am335x-pm-firmware.bin");
> +
> +	/* We don't want to delay boot */
> +	request_firmware_nowait(THIS_MODULE, 0, "am335x-pm-firmware.bin",
> +				wkup_m3->dev, GFP_KERNEL, wkup_m3,
> +				am33xx_pm_firmware_cb);
> +	return 0;
> +
> +err:
> +	omap_mbox_put(wkup_m3->mbox, &wkup_mbox_notifier);
> +exit:
> +	return ret;
> +}
> +

[...]

> +extern void __iomem *am33xx_get_emif_base(void);
> +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg);
> +#endif
> +
> +#define	IPC_CMD_DS0			0x3
> +#define IPC_CMD_RESET                   0xe
> +#define DS_IPC_DEFAULT			0xffffffff
> +
> +#define IPC_RESP_SHIFT			16
> +#define IPC_RESP_MASK			(0xffff << 16)
> +
> +#define M3_STATE_UNKNOWN		0
> +#define M3_STATE_RESET			1
> +#define M3_STATE_INITED			2
> +#define M3_STATE_MSG_FOR_LP		3
> +#define M3_STATE_MSG_FOR_RESET		4
> +
> +#define AM33XX_OCMC_END			0x40310000
> +#define AM33XX_EMIF_BASE		0x4C000000
> +
> +/*
> + * This a subset of registers defined in drivers/memory/emif.h
> + * Move that to include/linux/?
> + */

I'd probably suggest just moving the register definitions you
need into <plat/emif_plat.h> so they can be shared with the driver.

Also, the EMIF stuff would benefit greatly from using symbolic defines
for the values being written.  Probably having those in
<plat/emif_plat.h> would also help out here.

Or, maybe the EMIF driver can provide some self-contained stubs that can
be copied to OCP RAM for the functionality needed here?

Santosh, what do you think of that?

Another user of the EMIF virtual addr is emif_self_refresh_dis, but I
don't see that code actually used anywhere.

Looking closer, now I see the ddr_self_refresh macro is using
emif_virt_addr (that macro should be fixed to take the base address, for
readability.)

On a related note, just a quick glance at all the code running out of
OCM RAM makes me wonder if any that could be done before jumping to OCM
RAM.  Ideally, we only want the absolute minimum running out of OCM RAM.

[...]

> diff --git a/arch/arm/mach-omap2/sleep33xx.S b\arch/arm/mach-omap2/sleep33xx.S
> new file mode 100644
> index 0000000..f7b34e5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sleep33xx.S
> @@ -0,0 +1,571 @@
> +/*
> + * Low level suspend code for AM33XX SoCs
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
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
> +#include <linux/linkage.h>
> +#include <asm/memory.h>
> +#include <asm/assembler.h>
> +
> +#include "cm33xx.h"
> +#include "pm33xx.h"
> +#include "prm33xx.h"
> +#include "control.h"
> +
> +/* replicated define because linux/bitops.h cannot be included in assembly */
> +#define BIT(nr)		(1 << (nr))

never used, just remove it.  Using shifts as below is fine (but using
symbolic constants would be even better.)

In fact, there are lots of magic constants in this code that I'd like
to see #defined.

[...]

> +	wfi
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop

Why all the nops?  Some comments would be helpful there.

[...]

> +/* Values recommended by the HW team */

A little documentation of these values would be helpful here.

> +susp_io_pull_data:.
> +	.word	0x3FF00003
> +susp_io_pull_cmd1:
> +	.word   0xFFE0018B
> +susp_io_pull_cmd2:
> +	.word   0xFFA0098B
> +resume_io_pull_data:
> +	.word	0x18B
> +resume_io_pull_cmd:
> +	.word	0x18B
> +susp_vtp_ctrl_val:
> +	.word	0x10117

Kevin

