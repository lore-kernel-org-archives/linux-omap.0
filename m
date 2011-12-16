From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Thu, 15 Dec 2011 22:30:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1112152228030.22491-100000@netrider.rowland.org>
References: <CAMP44s3eeTOBRiFwEL3FypDY_+-MReqYJJVO1URNrnFVFXzvDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMP44s3eeTOBRiFwEL3FypDY_+-MReqYJJVO1URNrnFVFXzvDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Dec 2011, Felipe Contreras wrote:

> >> --- a/drivers/usb/musb/omap2430.c
> >> +++ b/drivers/usb/musb/omap2430.c
> >> @@ -385,6 +385,7 @@ static void omap2430_musb_disable(struct musb =
*musb)
> >>
> >> =C2=A0static int omap2430_musb_exit(struct musb *musb)
> >> =C2=A0{
> >> + =C2=A0 =C2=A0 pm_runtime_put(musb->controller);
> >> =C2=A0 =C2=A0 =C2=A0 del_timer_sync(&musb_idle_timer);
> >>
> >> =C2=A0 =C2=A0 =C2=A0 omap2430_low_level_exit(musb);
> >
> > Should these calls be pm_runtime_put_sync() instead of
> > pm_runtime_put()?
>=20
> I don't see why... The thing failed, it's not going to be used any
> more so better let PM deactivate the device.

It's not a big deal.  The difference is that pm_runtime_put_sync()
avoids an extra context switch when suspending the device.  A minor
optimization, that's all.

Alan Stern
