From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv2] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
Date: Tue, 08 Oct 2019 17:16:36 +0300
Message-ID: <87h84j7263.fsf@kamboji.qca.qualcomm.com>
References: <20191007172800.64249-1-tony@atomide.com>
        <20191008140556.GZ5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191008140556.GZ5610-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's message of
        "Tue, 8 Oct 2019 07:05:56 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [191007 17:29]:
>> We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), and test
>> for it in wlcore_runtime_resume(). But WL1271_FLAG_IRQ_RUNNING currently
>> gets cleared too early by wlcore_irq_locked() before wlcore_irq() is done
>> calling it. And this will race against wlcore_runtime_resume() testing it.
>> 
>> Let's set and clear IRQ_RUNNING in wlcore_irq() so wlcore_runtime_resume()
>> can rely on it. And let's remove old comments about hardirq, that's no
>> longer the case as we're using request_threaded_irq().
>> 
>> This fixes occasional annoying wlcore firmware reboots stat start with
>> "wlcore: WARNING ELP wakeup timeout!" followed by a multisecond latency
>> when the wlcore firmware gets wrongly rebooted waiting for an ELP wake
>> interrupt that won't be coming.
>> 
>> Note that I also suspect some form of this issue was the root cause why
>> the wlcore GPIO interrupt has been often configured as a level interrupt
>> instead of edge as an attempt to work around the ELP wake timeout errors.
>
> So this fixed a reproducable test case where loading some webpages
> often produced ELP timeout errors. But looks like I'm still seeing ELP
> timeouts elsewhere. So best to wait on this one. Something is still
> wrong with the ELP timeout handling.

Ok, I'll drop this then. Please send v3 once you think the patch is
ready to be applied.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
