From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 1/8] musb: Add structure to get board specific data
Date: Tue, 17 Nov 2009 18:35:22 +0300
Message-ID: <4B02C2BA.5060902@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com> <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258470596-24321-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> Adding 'musb_hdrc_board_data' which will have all the board specific
> parameters such as; mA power, potpgt, extvbus, gpios etc.

> Currently only 'power' and 'potpgt' is being moved from existing
> 'musb_hdrc_platform_data' to 'musb_hdrc_board_data' but any further
> board specific functions or parameter can be added to this structure
> later.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  include/linux/usb/musb.h |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
> index d437556..6e1426c 100644
> --- a/include/linux/usb/musb.h
> +++ b/include/linux/usb/musb.h
> @@ -27,6 +27,15 @@ struct musb_hdrc_eps_bits {
>  	u8		bits;
>  };
>  
> +/* MUSB board-specific details */
> +struct musb_hdrc_board_data {
> +	/* power (mA/2) sourcing capability */
> +	u8	power;
> +	/* (HOST or OTG) msec/2 after VBUS on till power good */
> +	u8		potpgt;

    Uneven indentation, either too many or too little tabs here.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
