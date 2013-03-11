From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: log VBUS error
Date: Mon, 11 Mar 2013 10:19:54 -0700
Message-ID: <20130311171954.GN26093@atomide.com>
References: <1362876568-7082-1-git-send-email-notasas@gmail.com>
 <20130311162409.GH26093@atomide.com>
 <CANOLnOOp0xHq6KP3yNPYhneuxUtCy4w1tBQjw1kW7UHibV1_0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOOp0xHq6KP3yNPYhneuxUtCy4w1tBQjw1kW7UHibV1_0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130311 10:12]:
> On Mon, Mar 11, 2013 at 6:24 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130309 16:53]:
> >> VBUS_ERROR is a serious error that the driver often doesn't recover from
> >> in my tests, so we should at least inform the user about it.
> >
> > Patch makes sens to me, just a related question..
> >
> > Do you get this when trying to enable the host mode, right? Or have you seen
> > this in other situations too?
> 
> I sometimes see it when booting with cable connected to PC or
> connecting cable to PC after using a host adapter. In those cases OTG
> port dies completely until a powercycle :(

Hmm OK. I suspect there's some kernel bug currently with the OTG id pin
detection where it's initial state during the boot is ignored. But replugging
the cable should fix that, and in your case it sounds like that's not
the case.
 
> > If the error happens when enabling the host mode, my experience is that
> > the VBUS_ERROR is caused by the musb trying to be too smart and doing the
> > timeouts automatically. If the VBUS on the hardware does not raise fast
> > enough to the right range for whatever reason, musb can produce this
> > error.
> 
> Yeah the driver seems to expect that and has a "ignore" variable, I
> use KERN_DEBUG level in case it's set.

Yes in the host case I think we then just retry enabling the session bit
and don't have anything in place to check that the VBUS regulator is ready
or not. Have not looked at that code for a while though.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
