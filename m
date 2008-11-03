From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/3] musb: fixes vbus off issue after disconnect
Date: Mon, 3 Nov 2008 20:33:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5E8A787@dbde02.ent.ti.com>
References: <1225357988-10985-1-git-send-email-ajay.gupta@ti.com>,<20081103125047.GM21760@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081103125047.GM21760-f9ZlEuEWxVfta4EC/59zMBl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Vbus is switched off (after a_wait_bcon) whenever a device
> is disconnected from musb host even when musb is configured
> only as host.Earlier we use to switch on the power using
> [echo "F" >/proc/driver/musb_hdrc] but now this proc entry is
> deleted thus musb doesn't work after device disconnect.
>
> This patch puts is_otg_enabled() check before scheduling
> a switch-off timer in disconnect path.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index dbf8861..6856da3 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -767,7 +767,7 @@ static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
>               case OTG_STATE_A_HOST:
>               case OTG_STATE_A_SUSPEND:
>                       musb_root_disconnect(musb);
> -                     if (musb->a_wait_bcon != 0)
> +                     if (musb->a_wait_bcon != 0 && is_otg_enabled(musb))

> I'd say we need to turn off vbus whenever possible. 
> This looks like the
> problem is somewhere else but here. Maybe we're missing a disconnect
> event. I recall we only ack disconnect upon next reconnection of the
> device due to isses with tusb rev1.0. Maybe  the problem lies there.

I agree but currently in host only mode after disconnect vbus is switched off and
there is no way to switch it on. Now if we connect other device it doesn't work
as musb is dead.

> Turning off vbus is good to save batery, and I'd say we keep it off as
> long as possible. Vbus should probably be handled by userland in otg
> cases, although I couldn't get Dave to agree with it :-p

> I believe that we should have a "session" entry on sysfs and upon cable
> connection, one side switches to a_idle and the other stays in b_idle.
> The device that writes to session (echo 1 > session) will become host
> (either b_host or a_host, meaning that hnp would also trigger based on
> that).

This is the case of OTG build but what if we configure for only host mode ? All 
OTG related stuff shouldn't be there in host only mode right ?

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
