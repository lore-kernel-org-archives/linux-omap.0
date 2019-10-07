From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
Date: Mon, 7 Oct 2019 08:47:03 -0700
Message-ID: <20191007154703.GP5610@atomide.com>
References: <20191007153731.58045-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191007153731.58045-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [191007 08:38]:
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -692,6 +687,9 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
>  
>  	mutex_unlock(&wl->mutex);
>  
> +out_handled:
> +	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
> +
>  	return IRQ_HANDLED;
>  }

Sorry looks like I again sent out the patch too fast. The clear_bit()
here should have spin_lock_irqsave() and spin_unlock_irqrestore()
around it like we do elsewhere in the code currently.

Regards,

Tony
