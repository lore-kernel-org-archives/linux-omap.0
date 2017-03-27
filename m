From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 27 Mar 2017 09:59:47 -0700
Message-ID: <20170327165946.GL10760@atomide.com>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908>
 <20170327143049.GG10760@atomide.com>
 <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63FD9E13-2B70-485C-80A7-206BEC16905A-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Lars Melin <larsm17-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessio Igor Bogani <abogani-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org> [170327 09:23]:
> If I understood your patch, however, if the device (anyone, not just my one) takes longer to switch, VBUS is deasserted anyway.

Yeah some of them can take at least 10 seconds even to enumerate.
So probably we need to have to have some longer timeout set for
OTG_STATE_A_WAIT_BCON, like 20 or 30 seconds.

> Although this patch is working for me, personally I would prefer a solution which would not deassert VBUS. At least on a host only port. Honestly I don’t know how a dual role port should work.

It's been really long time since I read the OTG spec. There
may be some diagram showing the required timeouts in the spec
if there is one for VBUS.

Maybe we need some property to specify vbus-always-on-in-host-mode?

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
