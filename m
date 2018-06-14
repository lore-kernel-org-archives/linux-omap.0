From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: RE: [EXTERNAL] Re: [RFT 3/6] wlcore: Add support for runtime PM
Date: Thu, 14 Jun 2018 11:29:32 +0000
Message-ID: <90db5e5b092a4be6b4390fc5f695b5fe@ti.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-4-tony@atomide.com> <20180531171420.GQ5705@atomide.com>
 <fe42f9d6bb744cd39e38db8f51c0b74e@ti.com> <20180605042000.GA5738@atomide.com>
 <20180605104404.GD5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >This happens on runtime_suspend() where we are already in PLT
> >and then that error gets stored and then next pm_runtime_get()
> >returns -EINVAL. The patch below should fix it. I'll fold it
> i>nto the runtime PM related patch assuming it works for you.
> >
> >Regards,
> >
> >Tony
> >
> >8< -------
> >diff --git a/drivers/net/wireless/ti/wlcore/main.c
> b/drivers/net/wireless/ti/wlcore/main.c
> >--- a/drivers/net/wireless/ti/wlcore/main.c
> >+++ b/drivers/net/wireless/ti/wlcore/main.c
> >@@ -6677,7 +6677,7 @@ static int __maybe_unused
> wlcore_runtime_suspend(struct device *dev)
> >
> > 	/* We do not enter elp sleep in PLT mode */
> > 	if (wl->plt)
> >-		return -EINVAL;
> >+		return 0;
> >
> > 	/* Nothing to do if no ELP mode requested */
> > 	if (wl->sleep_auth !=3D WL1271_PSM_ELP)
>=20
> Even with this change I still see issues with a wl1281 module plugged in.
> It take a few seconds for the crash to happen once you turn plt on.
> Log below.
> Do you see this on your wl12xx based platform?
>=20
> sh-4.4#
> sh-4.4# calibrator wlan0 plt power_mode on
> [  231.105877] wlcore: power up
> [  231.667604] wlcore: firmware booted in PLT mode PLT_ON (PLT
> 7.3.10.2.142)
> sh-4.4#
> sh-4.4#
> sh-4.4# [  236.900817] ------------[ cut here ]------------
> [  236.906012] WARNING: CPU: 0 PID: 520 at
> drivers/net/wireless/ti/wlcore/main.c:806

Hold on, I might have edited the wrong version of the file (main.c).=20
Sorry about that. Working on too many branches/boards... :(
Applied this change again and things look good now with the wl1281 based mo=
dule.

Best Regards,
Eyal
