From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 27 Mar 2017 10:55:37 -0700
Message-ID: <20170327175536.GP10760@atomide.com>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908>
 <20170327143049.GG10760@atomide.com>
 <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
 <20170327165946.GL10760@atomide.com>
 <20170327171534.GA4403@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170327171534.GA4403@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>, Lars Melin <larsm17-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessio Igor Bogani <abogani-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170327 10:17]:
> On Mon, Mar 27, 2017 at 09:59:47AM -0700, Tony Lindgren wrote:
> > * Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org> [170327 09:23]:
> > > If I understood your patch, however, if the device (anyone, not just my one) takes longer to switch, VBUS is deasserted anyway.
> > 
> > Yeah some of them can take at least 10 seconds even to enumerate.
> > So probably we need to have to have some longer timeout set for
> > OTG_STATE_A_WAIT_BCON, like 20 or 30 seconds.
> > 
> > > Although this patch is working for me, personally I would prefer a solution which would not deassert VBUS. At least on a host only port. Honestly I don’t know how a dual role port should work.
> > 
> > It's been really long time since I read the OTG spec. There
> > may be some diagram showing the required timeouts in the spec
> > if there is one for VBUS.
> > 
> > Maybe we need some property to specify vbus-always-on-in-host-mode?
> 
> The MUSB otg state machine has been changed in many place since the last
> time I looked at it, and I am not sure how exactly it works now.

Yup.. I looked up the timers in the OTG spec and they are described
in chapter "8.5.5.2" as a_wait_bcon_tmo or a_wait_bcon_tmr. But
I could not find any values for them.

Anyways, clearly we want things working with real devices :)

> If the $subject patch can correctly keep the VBUS on for host-only mode,
> we can somehow use dr_modei value to distinguish the mode. We don't have
> to create a new vbus-always-on-in-host-mode flag. VBUS has to be always
> on in host-only mode anyway, until some error condition happens.

Yeh and it seems PM still works with the $subject patch also for
host mode. So maybe that's enough to fix the issue.

Also I don't have any idea why for ages we have been writing
0 to devctl there.. Maybe we've had a bug there that only now
shows up when we idle things.

Anyways, for the $subject patch related to MUSB runtime PM:

Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
