From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [PATCH] wlcore: use generic runtime pm calls for wowlan elp configuration
Date: Thu, 24 May 2018 16:36:09 +0300
Message-ID: <87efi1b2gm.fsf@kamboji.qca.qualcomm.com>
References: <1527146337-17562-1-git-send-email-eyalr@ti.com>
        <87fu2hiilx.fsf@codeaurora.org>
        <06f0b1b5243a4ab7befad7b9109bf5a5@ti.com>
        <20180524132132.GZ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180524132132.GZ98604-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's message of
        "Thu, 24 May 2018 06:21:32 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-wireless@vger.kernel.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> * Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180524 08:20]:
>> > 
>> > > With runtime PM enabled, we can now use generic calls to
>> > > pm_generic_runtime_suspend and pm_generic_runtime_resume for
>> > enabling elp
>> > > during suspend when wowlan is enabled and waking the chip from elp
>> > > on resume.
>> > > remove the custom API that was used to ensure that the command
>> > > that is used to allow ELP during suspend is completed before the system
>> > > suspend.
>> > >
>> > > Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
>> > > ---
>> > > Dependent on the Runtime PM support for wlcore patch set that was
>> > submitted
>> > > by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> > 
>> > Ok, I'll drop this from my queue. Please resubmit once Tony's patches
>> > are ready to apply (or Tony can include this patch in his patchset).
>> > 
>> > BTW, for me it would be a lot easier if you could mark patches like this
>> > as RFT (Request For Test) or RFC (Request For Comments). That way I can
>> > automatically drop the patch without sending any emails.
>
> Sorry for the noise, what seemed like a trivial change to use generic
> runtime PM exposed few unexpected issues :) I'll do one more revision
> of all the patches with RFT. Then when we are happy with that series,
> I'll do one more patch to enable runtime PM autosuspend support to
> avoid enabling and disabing the hardware constantly. And then after
> that we should have the patches finally ready for merging.

Sounds good to me, kiitos :)

-- 
Kalle Valo
