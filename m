From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: omap2+: save and restore OTG_INTERFSEL
Date: Wed, 07 Sep 2011 14:52:02 +0400
Message-ID: <4E674CD2.6050800@ru.mvista.com>
References: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com> <1315356573-1057-3-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315356573-1057-3-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 07-09-2011 4:49, Vikram Pandita wrote:

> From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>

> we need to save and restore OTG_INTERFSEL register
> else we will be unable to function on resume after
> OFF mode.

> Change-Id: I6c29c69596d5f47e00cf74ab0e32bb44ef71dda9

    Remove this, please.

> Reported-by: Devaraj Rangasamy<dev-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/musb/musb_core.h |    1 +
>   drivers/usb/musb/omap2430.c  |    6 ++++++
>   2 files changed, 7 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index b3c065a..3259a6b 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -311,6 +311,7 @@ struct musb_context_registers {
>   	u8 index, testmode;
>
>   	u8 devctl, busctl, misc;
> +	u32 otg_interfsel;

    Shouldn't this be encosed in #ifdef?

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
