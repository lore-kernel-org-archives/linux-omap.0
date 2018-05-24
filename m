From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] wlcore: use generic runtime pm calls for wowlan elp configuration
Date: Thu, 24 May 2018 11:05:30 +0300
Message-ID: <87fu2hiilx.fsf@codeaurora.org>
References: <1527146337-17562-1-git-send-email-eyalr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1527146337-17562-1-git-send-email-eyalr-l0cyMroinI0@public.gmane.org> (Eyal Reizer's
        message of "Thu, 24 May 2018 10:18:57 +0300")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> With runtime PM enabled, we can now use generic calls to
> pm_generic_runtime_suspend and pm_generic_runtime_resume for enabling elp
> during suspend when wowlan is enabled and waking the chip from elp
> on resume.
> remove the custom API that was used to ensure that the command
> that is used to allow ELP during suspend is completed before the system
> suspend.
>
> Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> ---
> Dependent on the Runtime PM support for wlcore patch set that was submitted 
> by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Ok, I'll drop this from my queue. Please resubmit once Tony's patches
are ready to apply (or Tony can include this patch in his patchset).

BTW, for me it would be a lot easier if you could mark patches like this
as RFT (Request For Test) or RFC (Request For Comments). That way I can
automatically drop the patch without sending any emails.

-- 
Kalle Valo
