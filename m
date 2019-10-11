From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv3] wlcore: clean-up clearing of WL1271_FLAG_IRQ_RUNNING
Date: Fri, 11 Oct 2019 08:56:19 +0000 (UTC)
Message-ID: <20191011085619.87D4960B19@smtp.codeaurora.org>
References: <20191009165006.41567-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191009165006.41567-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), but clear
> it before interrupt handling is done in wlcore_irq_locked().
> 
> Let's move the clearing to the end of wlcore_irq() where it gets set,
> and remove the old comments about hardirq. That's no longer the case as
> we're using request_threaded_irq().
> 
> Note that the WL1271_FLAG_IRQ_RUNNING should never race between the
> interrupt handler and wlcore_runtime_resume() as because of autosuspend
> timeout we cannot enter idle between wlcore_irq_locked() and the end of
> wlcore_irq().
> 
> Cc: Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> Cc: Guy Mishol <guym-l0cyMroinI0@public.gmane.org>
> Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

4633d30b61ac wlcore: clean-up clearing of WL1271_FLAG_IRQ_RUNNING

-- 
https://patchwork.kernel.org/patch/11181621/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
