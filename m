From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] wlcore: Fix BUG with clear completion on timeout
Date: Fri, 30 Nov 2018 10:32:52 -0800
Message-ID: <20181130183252.GH53235@atomide.com>
References: <20181001213805.86511-1-tony@atomide.com>
 <20181005083324.D2D5160818@smtp.codeaurora.org>
 <CAHCN7xKiCrrG=YLMX4gTtgfEQ3zG3P++OpG5aaQ3uoFO9A5RSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xKiCrrG=YLMX4gTtgfEQ3zG3P++OpG5aaQ3uoFO9A5RSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, guym-l0cyMroinI0@public.gmane.org, luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, maitalm-l0cyMroinI0@public.gmane.org, maxim.altshul-l0cyMroinI0@public.gmane.org, shaharp-l0cyMroinI0@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [181130 13:16]:
> On Fri, Oct 5, 2018 at 3:33 AM Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >
> > Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > > We do not currently clear wl->elp_compl on ELP timeout and we have bogus
> > > lingering pointer that wlcore_irq then will try to access after recovery
> > > is done:
> > >
> > > BUG: spinlock bad magic on CPU#1, irq/255-wl12xx/580
> > > ...
> > > (spin_dump) from [<c01b9344>] (do_raw_spin_lock+0xc8/0x124)
> > > (do_raw_spin_lock) from [<c09b3970>] (_raw_spin_lock_irqsave+0x68/0x74)
> > > (_raw_spin_lock_irqsave) from [<c01a02f0>] (complete+0x24/0x58)
> > > (complete) from [<bf572610>] (wlcore_irq+0x48/0x17c [wlcore])
> > > (wlcore_irq [wlcore]) from [<c01c5efc>] (irq_thread_fn+0x2c/0x64)
> > > (irq_thread_fn) from [<c01c623c>] (irq_thread+0x148/0x290)
> > > (irq_thread) from [<c016b4b0>] (kthread+0x160/0x17c)
> > > (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > > ...
> > >
> > > After that the system will hang. Let's fix this by adding a flag for
> > > recovery and moving the recovery work call to to the error handling
> > > section.
> > >
> > > And we want to set WL1271_FLAG_INTENDED_FW_RECOVERY and actually clear
> > > it too in wl1271_recovery_work() and just downgrade the error to a
> > > warning to prevent overly verbose output.
> > >
> 
> Do we know how far back this bug goes and which versions need this
> patch applied to it?  I have seen something similar on 4.19, but I
> haven't tried this patch to fix it.  It wasn't clear to me if this is
> linux-next or 4.19 or something different.

I'm not sure if this is needed for v4.19 as the wakeirq patch
is not there. Maybe give it a try and see if it helps with
the issue you're seeing, then request inclusion for stable if
it helps?

BTW any wlcore issues with earlier kernels should be separately
debugged and tested. Fixes done after changing wlcore to use
PM runtime and wakeirq may be incomple for earlier kernels,
that's the two commits and below and any changes related to them.

And in general there seems to be two categories of common issues
with wlcore that I've seen: GPIO interrupt not behaving with the
SoC or old firmware being used for wlcore.

Regards,

Tony

8< -----------------
3c83dd577c7f ("wlcore: Add support for optional wakeirq")
fa2648a34e73 ("wlcore: Add support for runtime PM")
