From: Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Tue, 28 Mar 2017 08:10:00 +0200
Message-ID: <11BBAEC7-0B26-40FE-963E-811F7853F2FE@tecnorama.it>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908> <20170327143049.GG10760@atomide.com>
 <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
 <20170327165946.GL10760@atomide.com> <20170327171534.GA4403@uda0271908>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170327171534.GA4403@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lars Melin <larsm17-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessio Igor Bogani <abogani-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Il giorno 27 mar 2017, alle ore 19:15, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> ha scritto:
> 
> […]
> 
> The MUSB otg state machine has been changed in many place since the last
> time I looked at it, and I am not sure how exactly it works now.
> 
> If the $subject patch can correctly keep the VBUS on for host-only mode,
> we can somehow use dr_modei value to distinguish the mode. We don't have
> to create a new vbus-always-on-in-host-mode flag. VBUS has to be always
> on in host-only mode anyway, until some error condition happens.
> 

During my research, I used this patch to try to print the status of the usb port:

--- a/drivers/usb/musb/musb_dsps.c	2017-03-13 09:34:31.000000000 +0100
+++ b/drivers/usb/musb/musb_dsps.c	2017-03-13 09:36:02.000000000 +0100
@@ -245,6 +245,8 @@ static void otg_timer(unsigned long _mus
 	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
 				usb_otg_state_string(musb->xceiv->otg->state));

+	dev_emerg(musb->controller, "musb->xceiv->otg->state=%s, musb->port_mode=%d\n", usb_otg_state_string(musb->xceiv->otg->state),(int)musb->port_mode);
+
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->otg->state) {
 	case OTG_STATE_A_WAIT_BCON:

Unless I did something wrong, maybe it’s worth to notice that before the patch that apparently introduced this bug (2f3fd2c5bde1f94513c3dc311ae64494085ec371) I got nothing printed anywhere.
With that patch applied, instead, I got the line printed in dmesg.
I might be wrong but my assumption is that without that patch otg_timer was never called.
If this is true, it would explain why writing 0 on DEVCTL didn’t bother anything: it never happened.

Regards,

Moreno

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
