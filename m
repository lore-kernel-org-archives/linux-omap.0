From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH resend 2/3] musb: add musb support for AM35x
Date: Sat, 03 Jul 2010 17:04:36 +0400
Message-ID: <4C2F3564.8030103@ru.mvista.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com> <1278053879-6850-2-git-send-email-ajay.gupta@ti.com> <4C2DD9B6.4000401@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044EAAD82A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EAAD82A-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Gupta, Ajay Kumar wrote:

>>> +{
>>> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
>>> +	u32 devconf2;
>>> +
>>> +	/*
>>> +	 * Start the on-chip PHY and its PLL.
>>> +	 */
>>> +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
>>> +
>>> +	devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN |
>>> +			CONF2_PHY_GPIOMODE);

>>     BWT, what's thet GPIOMODE bit for?

> If GPIO Mode is set to '1' then UART3 Tx/Rx would come on DP and
> DM pins of USBPHY.

    Hm, why GPIOMODE then I wonder... :-)

>>> +	devconf2 |= CONF2_PHY_PLLON | CONF2_DATPOL;

>>     So, AM35x always uses the reversed data polarity?

> It's getting set to '1' so its always normal polarity.

    Ah, I got it reversed: 1 means normal polarity indeed...

>>> +static void otg_timer(unsigned long _musb)
>>> +{
>>> +	struct musb		*musb = (void *)_musb;
>>> +	void __iomem		*mregs = musb->mregs;
>>> +	u8			devctl;
>>> +	unsigned long		flags;
>>> +
>>> +	/*
>>> +	 * We poll because AM35x's won't expose several OTG-critical
>>> +	 * status change events (from the transceiver) otherwise.
>>> +	 */
>>> +	devctl = musb_readb(mregs, MUSB_DEVCTL);
>>> +	DBG(7, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
>>> +
>>> +	spin_lock_irqsave(&musb->lock, flags);
>>> +	switch (musb->xceiv->state) {

>> [...]

>>> +	case OTG_STATE_A_WAIT_VFALL:

>>     So, are you sure there's no need to call mod_timer() here for RTL 1.8?

> What issue did you see on earlier RTLs ?

    I didn't test DaVinci much; I didn't even test DA8xx much in OTG mode. :-/
And in the DA8xx host mode VBUS error would never occur anyway (as the VBUS 
comparator is overridden on the EVM board).

> As such I didn't see issue
> In my normal testing.

    OK.

>>> +		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
>>> +		musb_writel(musb->ctrl_base, CORE_INTR_SRC_SET_REG,
>>> +			    MUSB_INTR_VBUSERROR << USB_INTR_USB_SHIFT);
>>> +		break;
>>> +	case OTG_STATE_B_IDLE:
>>> +		if (!is_peripheral_enabled(musb))
>>> +			break;

>>     Hm, davinci.c sets DevCtl.Session here and I'm also doing it in
>> da8xx.c --
>> can you comment why you don't do that too?

> I remember this was causing some issue in OTG testing.

    Do you remember which issue?
    Although I suspect that this code might be related to the comment below: 
"DEVCTL.BDEVICE is invalid without DEVCTL.SESSION set".

>>> +		devctl = musb_readb(mregs, MUSB_DEVCTL);
>>> +		if (devctl & MUSB_DEVCTL_BDEVICE)
>>> +			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
>>> +		else
>>> +			musb->xceiv->state = OTG_STATE_A_IDLE;
>>> +		break;

>> [...]

>>> +	musb->a_wait_bcon = A_WAIT_BCON_TIMEOUT;

>>     This field is set by musb_core.c, so I dropped this line from
>> da8xx.c...

    This has also been dropped from omap2430.c by this commit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f7f9d63eac12b345d6243d1d608b7944a05be921

> Need to test again but I was facing a issue where OTG build image
> Was either working in host only mode or device only. Role were
> Not changing based on ID pin status.

    Hm, is this related?

>>> +int musb_platform_exit(struct musb *musb)
>>> +{
>>> +	struct clk *otg_fck = clk_get(musb->controller, "fck");
>>> +
>>> +	if (is_host_enabled(musb))
>>> +		del_timer_sync(&otg_workaround);
>>> +
>>> +	/* Delay to avoid problems with module reload... */

>>     Are you sure this is needed? For DA8xx, I'm not sure: at least in host
>> mode it just causes pointless delay for me (VBUS comparator is overridden
>> in host mode); I was unable to test the OTG mode properly -- for some reason
>> USB device didn't get recongnized and VBUS has probably stayed low.

    Didn't have time to properly look into the OTG mode yet...

> I need to check on this, I guess it's not required though I have tested
> OTG also on AM3517EVM.

>>> +		for (delay = 30; delay > 0; delay--) {
>>> +			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>>> +			if (!(devctl & MUSB_DEVCTL_VBUS))
>>> +				goto done;
>>> +			if ((devctl & MUSB_DEVCTL_VBUS) != warn) {
>>> +				warn = devctl & MUSB_DEVCTL_VBUS;
>>> +				DBG(1, "VBUS %d\n",
>>> +					warn >> MUSB_DEVCTL_VBUS_SHIFT);
>>> +			}
>>> +			msleep(1000);
>>> +		}
>>> +
>>> +		/* In OTG mode, another host might be connected... */
>>> +		DBG(1, "VBUS off timeout (devctl %02x)\n", devctl);
>>> +	}
>>> +	if (otg_fck) {

>>     musb_platfrom_init() suggests that otg_fck can't be NULL. Also,
>> clk_get
>> returns error code, not NULL, so should use IS_ERR() here.

> Correct, would clean it.

    Also, you call clk_get() on this clock twice, in musb_platfrom_init() and 
here, but clk_put() only once.

> Thanks,
> Ajay

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
