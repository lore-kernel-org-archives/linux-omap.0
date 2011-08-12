From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Fri, 12 Aug 2011 10:21:00 -0700
Message-ID: <CAFm5wm1sAerG9AJB6w5W38DHRpBvLzG9UcnDWyQf8ocSfvENyA@mail.gmail.com>
References: <CAFm5wm1W03BbjNV4uZLGNjFZLKvfiLLQyP3M01r83EQ47724wQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1108121302070.15086-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1108121302070.15086-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, axelhaslam-l0cyMroinI0@public.gmane.org, ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 12, 2011 at 10:04 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org=
> wrote:
>
> On Fri, 12 Aug 2011, Pandita, Vikram wrote:
>
> > On Fri, Aug 12, 2011 at 8:50 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLg@public.gmane.org=
edu> wrote:
> > > On Fri, 12 Aug 2011, Vikram Pandita wrote:
> > >
> > >> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> > >>
> > >> musb pm_runtime_get_sync call happens in intrrupt context on cab=
le attach case
> > >> That can result in re-enabling the interrupts and cause side aff=
ects.
> > >>
> > >> So move the code to a work queue.
> > >
> > > Instead of creating your own, new work queue, just use the pre-ex=
isting
> > > PM work queue. =A0In other words, replace pm_runtime_get_sync() w=
ith
> > > pm_runtime_get().
> >
> > In this case it may not work, because immediately after a
> > pm_runtime_get_sync(),
> > we are going to access MUSB registers and xxx_sync() =A0call ensure=
s we
> > will not abort.
>
> I don't understand. =A0Why not just access those registers from withi=
n
> the runtime_resume callback?

I am not the runtime_pm expert, but as i understand, in this case:

USB cable attach
Get Interrupt from Power IC (twl6030)
Interrupt handler calls notifier_call_chain - cable attach/detach
notification handler in MUSB code
Notification_handler does:
    * enable clocks for musb register access
    ** setup musb registers to start getting control ep0 interrupts
for usb enumeration

* is the part were we need to do the clock enabling synchronously.
The runtime_resume() call-back today for musb does not have to do
anything with USB enumeration.

>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
