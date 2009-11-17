From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 2/8] musb: Get power (mA) from board data
Date: Tue, 17 Nov 2009 18:42:20 +0300
Message-ID: <4B02C45C.4060407@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com> <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258470596-24321-3-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> Different board may have different power sourcing capability and
> now with 'struct musb_hdrc_board_data' in place; pass this data
> from board files and also modify musb_core.c to get 'power' data
> from 'plat->board_data'.

    This should be part of the patch 1/8 to keep the code compiling.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 3a61ddb..818ccda 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2033,7 +2033,9 @@ bad_config:
>  		if (is_otg_enabled(musb))
>  			hcd->self.otg_port = 1;
>  		musb->xceiv->host = &hcd->self;
> -		hcd->power_budget = 2 * (plat->power ? : 250);
> +		if (plat->board_data)
> +			hcd->power_budget =
> +				2 * (plat->board_data->power ? : 250);

    Shouldn't it be:

+
+		hcd->power_budget = 2 * (plat->board_data &&
+				         plat->board_data->power ?
+					 plat->board_data->power : 250);

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
