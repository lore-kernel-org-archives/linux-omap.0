From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Tue, 4 Apr 2017 07:03:41 -0700
Message-ID: <20170404140341.GO10760@atomide.com>
References: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
 <20170404122736.GA13673@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170404122736.GA13673@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170404 05:30]:
> On Tue, Apr 04, 2017 at 10:09:50AM +0300, Peter Ujfalusi wrote:
> > Tony,
> > 
> > since 4.9 (4.8 was fine) I can not boot omap4-panda-es if the musb
> > is compiled in. The kernel will stuck printing:
> > 
> > ** 206 printk messages dropped ** [    8.926727] musb_bus_suspend
> > 2584: trying to suspend as a_idle while active

OK so compiled in. Do you have something connected also when
booting?

> Does it sound a similar issue to
> http://marc.info/?l=linux-usb&m=149036531809506&w=2

Yup.

> > The bisect (log is [1]) points to:
> > d8e5f0eca1e8 usb: musb: Fix hardirq-safe hardirq-unsafe lock order error
> > 
> > and reverting the d8e5f0eca1e8 makes the board to boot up fine
> > (Linux 4.11-rc5 and next-20170331).

OK thanks for bisecting it.

> > any idea on how to fix this w/o reverting the commit?

I'll take a look.

Regards,

Tony

> > [1] https://pastebin.com/Z2HJY229
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
