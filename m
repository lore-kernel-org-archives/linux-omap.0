From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 6/6] usb: musb: dsps: Enable sw babble control for
 newer silicon
Date: Thu, 22 May 2014 15:58:50 +0400
Message-ID: <537DE67A.10203@cogentembedded.com>
References: <1400740181-31213-1-git-send-email-george.cherian@ti.com> <1400740181-31213-7-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400740181-31213-7-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 22-05-2014 10:29, George Cherian wrote:

> Find whether we are running on newer silicon. The babble control
> register reads 0x4 by default in newer silicon as opposed to 0
> in old versions of AM335x. Based on this enable the sw babble
> control logic.

> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/musb/musb_dsps.c | 38 ++++++++++++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 6 deletions(-)

> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 868caf8..2ced061 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
[...]
> @@ -469,6 +470,19 @@ static int dsps_musb_init(struct musb *musb)
>   	val &= ~(1 << wrp->otg_disable);
>   	dsps_writel(musb->ctrl_base, wrp->phy_utmi, val);
>
> +	/*
> +	 *  Check whether the dsps version has babble control enabled.

    One space too many before this sentence.

> +	 * In latest silicon revision the babble control logic is enabled.
> +	 * If MUSB_BABBLE_CTL returns 0x4 then we have the babble control
> +	 * logic enabled.
> +	 */
> +	val = dsps_readb(musb->mregs, MUSB_BABBLE_CTL);
> +	if (val == MUSB_BABBLE_RCV_DISABLE) {
> +		glue->sw_babble_enabled = true;
> +		val |= MUSB_BABBLE_SW_SESSION_CTRL;
> +		dsps_writeb(musb->mregs, MUSB_BABBLE_CTL, val);
> +	}
> +

    Hm, from the register offset that you declared in the previous patch, I 
got an impression that this is a new standard MUSB register? Shouldn't this 
check be done in the generic MUSB code then?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
