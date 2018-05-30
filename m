From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFT 6/6] wlcore: Use generic runtime pm calls   for wowlan elp
 configuration
Date: Wed, 30 May 2018 06:34:56 +0000
Message-ID: <63ad2f07fac941b88408352f6ddbce50@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> > >
> > > With runtime PM enabled, we can now use generic calls to
> > > pm_generic_runtime_suspend and pm_generic_runtime_resume for
> enabling elp
> > > during suspend when wowlan is enabled and waking the chip from elp
> > > on resume.
> >
> > Sry, but not sure you can :(
> >
> > These functions are not used by drivers directly because system suspend
> > are not synchronized with PM runtime, so if you call
> pm_generic_runtime_suspend()
> > and, at the same time, there is pm_runtime_get_() in progress --> race =
...
> >
> > The pm_runtime_force_() APIs have to be used, or
> > PM runtime drivers functions can be called directly, but only if it pos=
sible to
> be
> > sure no other PM runtime calls active which is usually true at
> suspend_noirq stage.
>=20
> Oh right, those are subsystem calls. Seems like
> pm_runtime_force_suspend/resume() should work here,
> Eyal?
>=20

Oh, nice, wasn't aware of the pm_runtime_force_() calls.
For some reason they are not documented in:
https://www.kernel.org/doc/Documentation/power/runtime_pm.txt
Perhaps they should be?

Anyway I have tried them instead of pm_generic_runtime_() and they seem
To work fine on my platform.
Will test some more and submit a v2.

Best Regards,
Eyal
