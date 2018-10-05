From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] wlcore: Add support for optional wakeirq
Date: Fri,  5 Oct 2018 08:33:58 +0000 (UTC)
Message-ID: <20181005083358.C9DA6601A0@smtp.codeaurora.org>
References: <20181001214110.86774-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20181001214110.86774-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> Now with wlcore using PM runtime, we can also add support for Linux
> generic wakeirq handling for it if configured in the dts file.
> 
> The wakeirq can be configured as the second interrupt in the dts file
> with interrupts-extended property where it is the padconf irq of the OOB
> GPIO pin used for wlcore interrupt.
> 
> Note that eventually we should also allow configuring wlcore to use the
> SDIO dat1 IRQ for wake-up, and in that case the the wakeirq should be
> configured to be the padconf interrupt of the dat1 pin and not the
> padconf interrupt of the OOB GPIO pin.
> 
> Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

3c83dd577c7f wlcore: Add support for optional wakeirq

-- 
https://patchwork.kernel.org/patch/10622795/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
