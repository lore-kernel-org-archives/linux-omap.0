From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 6 Nov 2012 10:40:09 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04AE5@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
	<1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
 <87txt4aqyc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40683 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab2KFKkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 05:40:22 -0500
In-Reply-To: <87txt4aqyc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Kevin,

On Mon, Nov 05, 2012 at 23:10:27, Kevin Hilman wrote:
[...]
> 
> First, some general comments.  This is a big patch and probably should
> be broken up a bit.  I suspect it could be broken up a bit, maybe into
> at least:
> 
> - EMIF interface
> - SCM interface, new APIs
> - assembly/OCM code
> - pm33xx.[ch]
> - lastly, the late_init stuff that actually initizlizes 

Ok, I'll try splitting the patches in the next version.

> 
> I have a handful of comments below.  I wrote this up on the plane over
> the weekend, and I see that Santosh has already made some similar
> comments, but I'll send mine anyways.  

[...]

> 
> Doing this on every suspend looks a bit strange.  Why not just have some
> init function handle these devices once at boot.  If this is really
> needed on every suspend, it needs some more description, and probably 
> some basic stub drivers need to be created.

We do require it for every suspend (but more below). I'll add in more
description in the comment that's already there.

> 
> Also, if there are drivers for these devices, won't this interfere?
> 

Hmm, I can think of the following scenarios

1. Runtime PM adapted drivers are compiled in - We'll have to ensure that
in their suspend callbacks they end up doing omap_hwmod_idle() via the
runtime PM APIs. In this case the omap_hwmod_enable() followed by
omap_hwmod_idle() is not necessary in the PM code.

2. The drivers are not compiled in - In this case, the hwmod code puts
the IPs in standby during bootup so the first suspend-resume iteration
will pass. During resuming, the SYSC configuration for forced standby will
be lost, so in the subsequent iterations these IPs won't go standby and the
hwmod code does not touch them since they never got enabled. In this case
we do need the sequence that is there currently.

3. For some reason the respective drivers don't idle the IPs during suspend -
(no_idle_on_suspend flag for the hwmod in DT?). In this scenario I think
we should abort the suspend process since we know that the suspend is not
going to work. 

Is there some other scenario that needs to be covered?


How about adding some flag in hwmod code for handling this? Something
similar to what was done for MMC [1]. I think the problem that we have
is in some ways similar to the one addressed in [1].
 
> > +	/* Put the GFX clockdomains to sleep */
> > +	clkdm_sleep(gfx_l3_clkdm);
> > +	clkdm_sleep(gfx_l4ls_clkdm);
> > +
> > +	/* Try to put GFX to sleep */
> > +	pwrdm_set_next_pwrst(gfx_pwrdm, PWRDM_POWER_OFF);
> 
> ditto.

I'll check if this can be removed.

> 
> [...]
> 
> > +static int am33xx_pm_begin(suspend_state_t state)
> > +{
> > +	int ret = 0;
> > +
> > +	disable_hlt();
> > +
> > +	/*
> > +	 * Physical resume address to be used by ROM code
> > +	 */
> > +	wkup_m3->resume_addr = (AM33XX_OCMC_END - am33xx_do_wfi_sz +
> > +					am33xx_resume_offset + 0x4);
> 
> Why does this need to be calculated every suspend/resume?
> 

Will move this to init phase.

> > +	wkup_m3->sleep_mode = IPC_CMD_DS0;
> > +	wkup_m3->ipc_data1  = DS_IPC_DEFAULT;
> > +	wkup_m3->ipc_data2  = DS_IPC_DEFAULT;
> > +
> > +	am33xx_ipc_cmd();
> 
> This IPC needs a cleaner interface/API.  Also, since it involves
> register writes to the SCM, it should be defined in control.c.  (NOTE:
> we're in the process of creating a real driver out of the SCM, so all
> SCM register accesses need to be contained in control.c)
> 
> For example, you probably want an am33xx_m3_* API in control.c, with
> some pre-baked commands for the M3.  

Ok. I'll work on this for the next version.

> 
> > +	wkup_m3->state = M3_STATE_MSG_FOR_LP;
> >
> > +	omap_mbox_enable_irq(wkup_m3->mbox, IRQ_RX);
> > +
> > +	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);
> > +	if (ret) {
> > +		pr_err("A8<->CM3 MSG for LP failed\n");
> > +		am33xx_m3_state_machine_reset();
> > +		ret = -1;
> > +	}
> > +
> > +	if (!wait_for_completion_timeout(&wkup_m3_sync,
> > +					msecs_to_jiffies(500))) {
> 
> hmm, interesting.  I know you're not implementing idle here, but I'm
> rather curious how this sync w/M3 is going to work for idle.
> 

Like you mentioned in another thread we could probably not have
a sync in the idle path. (More in the other thread).

> > +		pr_err("A8<->CM3 sync failure\n");
> > +		am33xx_m3_state_machine_reset();
> > +		ret = -1;
> > +	} else {
> > +		pr_debug("Message sent for entering DeepSleep mode\n");
> > +		omap_mbox_disable_irq(wkup_m3->mbox, IRQ_RX);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> 
> [...]
> 
> > +static void am33xx_m3_state_machine_reset(void)
> > +{
> > +	int ret = 0;
> > +
> > +	wkup_m3->resume_addr	= 0x0;
> > +	wkup_m3->sleep_mode	= IPC_CMD_RESET;
> > +	wkup_m3->ipc_data1	= DS_IPC_DEFAULT;
> > +	wkup_m3->ipc_data2	= DS_IPC_DEFAULT;
> > +
> > +	am33xx_ipc_cmd();
> > +
> > +	wkup_m3->state = M3_STATE_MSG_FOR_RESET;
> > +
> > +	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);
> 
> magic constant needs a #define

Ok.

> 
> > +	if (!ret) {
> > +		pr_debug("Message sent for resetting M3 state machine\n");
> > +		if (!wait_for_completion_timeout(&wkup_m3_sync,
> > +						msecs_to_jiffies(500)))
> > +			pr_err("A8<->CM3 sync failure\n");
> > +	} else {
> > +		pr_err("Could not reset M3 state machine!!!\n");
> > +		wkup_m3->state = M3_STATE_UNKNOWN;
> > +	}
> > +}
> > +#endif /* CONFIG_SUSPEND */
> > +
> > +/*
> > + * Dummy notifier for the mailbox
> > + */
> > +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg)
> > +{
> > +	return 0;
> > +}
> > +
> > +static struct notifier_block wkup_mbox_notifier = {
> > +	.notifier_call = wkup_mbox_msg,
> > +};
> 
> Why do you need a dummy notifier?  Looks like maybe plat-omap/mailbox.c
> needs a few minor fixes to support not being passed a notifier instead?
> 

Ok. Will add checks in the mailbox code instead. (I wasn't too sure
about the mailbox users so I tried to take the path of least resistance :) 

> > +static irqreturn_t wkup_m3_txev_handler(int irq, void *unused)
> > +{
> > +	omap_ctrl_writel(0x1, AM33XX_CONTROL_M3_TXEV_EOI);
> 
> undocumented magic write (but presumably an IRQ ack?)
> 

Yes, it's for clearing the interrupt. Will add a comment 
put a #def for this and other places that you mentioned.

> Note this also needs to be moved to control.c and given a useful API.
> 
> > +	switch (wkup_m3->state) {
> > +	case M3_STATE_RESET:
> > +		wkup_m3->state = M3_STATE_INITED;
> > +		break;
> > +	case M3_STATE_MSG_FOR_RESET:
> > +		wkup_m3->state = M3_STATE_INITED;
> > +		omap_mbox_msg_rx_flush(wkup_m3->mbox);
> > +		complete(&wkup_m3_sync);
> > +		break;
> > +	case M3_STATE_MSG_FOR_LP:
> > +		omap_mbox_msg_rx_flush(wkup_m3->mbox);
> > +		complete(&wkup_m3_sync);
> > +		break;
> > +	case M3_STATE_UNKNOWN:
> > +		pr_err("IRQ %d with WKUP_M3 in unknown state\n", irq);
> > +		omap_mbox_msg_rx_flush(wkup_m3->mbox);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	omap_ctrl_writel(0x0, AM33XX_CONTROL_M3_TXEV_EOI);
> 
> undoumented magic write?
> 

Will fix. This is for re-arming the interrupt line.

[...]

> > +
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!mem)
> > +		dev_err(wkup_m3->dev, "no memory resource\n");
> 
> if !mem, this continues and still tries to ioremap NULL.
> 

Will fix the error path.

[...]

> > +
> > +/*
> > + * This a subset of registers defined in drivers/memory/emif.h
> > + * Move that to include/linux/?
> > + */
> 
> I'd probably suggest just moving the register definitions you
> need into <plat/emif_plat.h> so they can be shared with the driver.
> 
> Also, the EMIF stuff would benefit greatly from using symbolic defines
> for the values being written.  Probably having those in
> <plat/emif_plat.h> would also help out here.
> 
> Or, maybe the EMIF driver can provide some self-contained stubs that can
> be copied to OCP RAM for the functionality needed here?
> 
> Santosh, what do you think of that?
> 

[...]

> Another user of the EMIF virtual addr is emif_self_refresh_dis, but I
> don't see that code actually used anywhere.

Will check and remove it.

> 
> Looking closer, now I see the ddr_self_refresh macro is using
> emif_virt_addr (that macro should be fixed to take the base address, for
> readability.)
> 

Ok.

> On a related note, just a quick glance at all the code running out of
> OCM RAM makes me wonder if any that could be done before jumping to OCM
> RAM.  Ideally, we only want the absolute minimum running out of OCM RAM.
> 

Some of the EMIF register saves could perhaps be moved in C but I kept it
in assembly to be consistent with the resume sequence for the case where
WFI ends up as NOP and the normal resume path.

[...]

> > +
> > +/* replicated define because linux/bitops.h cannot be included in assembly */
> > +#define BIT(nr)		(1 << (nr))
> 
> never used, just remove it.  Using shifts as below is fine (but using
> symbolic constants would be even better.)

I recall using it one place. Looks like I got rid of it after all.

> 
> In fact, there are lots of magic constants in this code that I'd like
> to see #defined.
> 

Ok.

> [...]
> 
> > +	wfi
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> 
> Why all the nops?  Some comments would be helpful there.
> 

That was for the A8 pipeline. Will add a comment.

> [...]
> 
> > +/* Values recommended by the HW team */
> 
> A little documentation of these values would be helpful here.
> 

Ok.

Thanks,
Vaibhav

[1] http://www.spinics.net/lists/linux-omap/msg80918.html

