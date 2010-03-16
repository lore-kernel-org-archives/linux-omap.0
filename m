From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH 1/2] USB: musb: add two states to handle vbus error
Date: Tue, 16 Mar 2010 18:49:33 +0800
Message-ID: <4B9F623D.6060406@windriver.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44039 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933529Ab0CPKr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Mar 2010 06:47:56 -0400
In-Reply-To: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Hui <Hui.Wang@windriver.com>
Cc: tony@atomide.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On omap platforms, when configuring the kernel, if we choose the musb 
work as host or OTG mode and we plug
a mini-A cable into the socket, after the kernel boot up in host mode or 
insmod gadget driver in OTG mode,
the state of musb's xceiv is A_IDLE or B_IDLE correspondingly because id 
change can't trigger ISR. Under this
condition, if we hotplug a usb device(without self-powered) at the other 
side of the cable, the musb will suffer a vbus error,
This patch can handle this vbus error.

Wang Hui wrote:
> When the MUSB is configured as host mode or OTG mode, the xceiv->state
> will be set to OTG_STATE_A_IDLE or OTG_STATE_B_IDLE unconditionally
> during init process. These init states can change to other
> states When the MUSB module detects id pin change, devices connect or
> disconnect.
> But on some platforms(omap2, omap3), the id pin change
> can't raise IRQ request to the MUSB module, so on these platforms,
> the init xceiv->state will be A_IDLE or B_IDLE. Under this condition,
> when we want the MUSB to act as a host and hotplug a usb device in
> mini-B side of the cable, the MUSB will have a possibility to suffer
> power underrun under A_IDLE or B_IDLE state, So here adding these
> two states under which we can handle VBUSERROR IRQ.
>
> Signed-off-by: Wang Hui <Hui.Wang@windriver.com>
> ---
>  drivers/usb/musb/musb_core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index b4bbf8f..655413c 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -516,6 +516,8 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  			 * another reset is due (at least for high speed,
>  			 * to redo the chirp etc), it might work OK...
>  			 */
> +		case OTG_STATE_A_IDLE:
> +		case OTG_STATE_B_IDLE:
>  		case OTG_STATE_A_WAIT_BCON:
>  		case OTG_STATE_A_WAIT_VRISE:
>  			if (musb->vbuserr_retry) {
>   

