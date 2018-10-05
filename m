From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] wlcore: Fix BUG with clear completion on timeout
Date: Fri,  5 Oct 2018 08:33:24 +0000 (UTC)
Message-ID: <20181005083324.D2D5160818@smtp.codeaurora.org>
References: <20181001213805.86511-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20181001213805.86511-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> We do not currently clear wl->elp_compl on ELP timeout and we have bogus
> lingering pointer that wlcore_irq then will try to access after recovery
> is done:
> 
> BUG: spinlock bad magic on CPU#1, irq/255-wl12xx/580
> ...
> (spin_dump) from [<c01b9344>] (do_raw_spin_lock+0xc8/0x124)
> (do_raw_spin_lock) from [<c09b3970>] (_raw_spin_lock_irqsave+0x68/0x74)
> (_raw_spin_lock_irqsave) from [<c01a02f0>] (complete+0x24/0x58)
> (complete) from [<bf572610>] (wlcore_irq+0x48/0x17c [wlcore])
> (wlcore_irq [wlcore]) from [<c01c5efc>] (irq_thread_fn+0x2c/0x64)
> (irq_thread_fn) from [<c01c623c>] (irq_thread+0x148/0x290)
> (irq_thread) from [<c016b4b0>] (kthread+0x160/0x17c)
> (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> ...
> 
> After that the system will hang. Let's fix this by adding a flag for
> recovery and moving the recovery work call to to the error handling
> section.
> 
> And we want to set WL1271_FLAG_INTENDED_FW_RECOVERY and actually clear
> it too in wl1271_recovery_work() and just downgrade the error to a
> warning to prevent overly verbose output.
> 
> Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

4e651bad8489 wlcore: Fix BUG with clear completion on timeout

-- 
https://patchwork.kernel.org/patch/10622767/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
