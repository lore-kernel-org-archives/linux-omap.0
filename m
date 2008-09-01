From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 00/34] omap drivers going upstream
Date: Mon, 1 Sep 2008 11:04:21 +0300
Message-ID: <20080901080419.GW9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <20080831223721.GO9887@frodo> <fb249edb0808311822wa97279ale0e11bfcafc609dc@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40804 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYIAIGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 04:06:42 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0808311822wa97279ale0e11bfcafc609dc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Ville Tervo <ville.tervo@nokia.com>

On Mon, Sep 01, 2008 at 03:22:23AM +0200, andrzej zaborowski wrote:
> 2008/9/1 Felipe Balbi <me@felipebalbi.com>:
> > On Sat, Aug 30, 2008 at 08:16:00PM +0300, Felipe Balbi wrote:
> >> From: Felipe Balbi <felipe.balbi@nokia.com>
> >>
> >> The following drivers are going upstream for integration.
> >> They have been sitting on linux-omap for quite a while just
> >> increasing the diff against mainline and probability of
> >> merge conflicts.
> >
> > Just one comment to this. I had to left bluetooth driver out of the
> > series because it's using omap2_block/allow_sleep in the driver code.
> > That should be fixed and the set_clock function should come via
> > platform_data to the driver.
> >
> >  53 static void hci_h4p_set_clk(struct hci_h4p_info *info, int *clock, int enable)
> >  54 {
> >  55         unsigned long flags;
> >  56
> >  57         spin_lock_irqsave(&info->clocks_lock, flags);
> >  58         if (enable && !*clock) {
> >  59                 NBT_DBG_POWER("Enabling %p\n", clock);
> >  60                 clk_enable(info->uart_fclk);
> >  61 #ifdef CONFIG_ARCH_OMAP2
> >  62                 if (cpu_is_omap24xx()) {
> >  63                         clk_enable(info->uart_iclk);
> >  64                         omap2_block_sleep();
> >  65                 }
> >  66 #endif
> >  67         }
> >  68         if (!enable && *clock) {
> >  69                 NBT_DBG_POWER("Disabling %p\n", clock);
> >  70                 clk_disable(info->uart_fclk);
> >  71 #ifdef CONFIG_ARCH_OMAP2
> >  72                 if (cpu_is_omap24xx()) {
> >  73                         clk_disable(info->uart_iclk);
> >  74                         omap2_allow_sleep();
> >  75                 }
> >  76 #endif
> >  77         }
> >  78
> >  79         *clock = enable;
> >  80         spin_unlock_irqrestore(&info->clocks_lock, flags);
> >  81 }
> >
> > That driver is full of arch specific code and should be cleaned up ASAP.
> >
> > A few things I could get by briefly looking at the driver (actualy only
> > drivers/bluetooth/hci_h4p/core.c):
> 
> There's also a curious issue in hci_h4p_interrupt I hit recently but
> after looking at the rest of the driver thought it was beating a dead
> horse..., but just in case it isn't:
> the driver assumes the OMAP UART, but then it uses UART_IIR_ID which
> is only valid for standard UARTs, causing OMAP-specific Rx errors to
> be ignored silently.  Turns out that on my N810 there are actually Rx
> errors reported during firmware upload, but I didn't find a better way
> to handle them than to ignore them:
> 
> --- a/drivers/bluetooth/hci_h4p/core.c
> +++ b/drivers/bluetooth/hci_h4p/core.c
> @@ -482,7 +491,14 @@ static irqreturn_t hci_h4p_interrupt(int irq, void *data)
> 
>         NBT_DBG("In interrupt handler iir 0x%.2x\n", iir);
> 
> -       iir &= UART_IIR_ID;
> +       iir &= 0x1e; /* OMAP UART has wider INT than UART_IIR_ID */
> +
> +       /*
> +        * Often Rx errors are reported but reading the receive buffer
> +        * gives the correct data, so treat it as an Rx interrupt.
> +        */
> +       if (iir == 0xc)
> +               iir = 0x4;
> 
>         if (iir == UART_IIR_MSI) {
>                 msr = hci_h4p_inb(info, UART_MSR);
> 
> The tsc210x drivers should be upstreamable with the exception of ALSA
> code which needs to be converted to ASoC.  Maruk Vasut found a leak in
> one error path, but I can't charge the device that has the tsc2102
> that I used for testing.
> 
> I have some improvements to drivers/net/irda/omap-ir.c (clean-up and
> removing OMAP16xx specific bits to support OMAP1) but again, have no
> charger for the device.

Let's put Ville on the loop as he might be interested in it. Ville, any
comments ?

-- 
balbi
