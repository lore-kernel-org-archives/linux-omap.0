From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 27 Mar 2017 12:15:34 -0500
Message-ID: <20170327171534.GA4403@uda0271908>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908>
 <20170327143049.GG10760@atomide.com>
 <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
 <20170327165946.GL10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327165946.GL10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 27, 2017 at 09:59:47AM -0700, Tony Lindgren wrote:
> * Moreno Bartalucci <moreno.bartalucci@tecnorama.it> [170327 09:23]:
> > If I understood your patch, however, if the device (anyone, not just my one) takes longer to switch, VBUS is deasserted anyway.
> 
> Yeah some of them can take at least 10 seconds even to enumerate.
> So probably we need to have to have some longer timeout set for
> OTG_STATE_A_WAIT_BCON, like 20 or 30 seconds.
> 
> > Although this patch is working for me, personally I would prefer a solution which would not deassert VBUS. At least on a host only port. Honestly I don’t know how a dual role port should work.
> 
> It's been really long time since I read the OTG spec. There
> may be some diagram showing the required timeouts in the spec
> if there is one for VBUS.
> 
> Maybe we need some property to specify vbus-always-on-in-host-mode?

The MUSB otg state machine has been changed in many place since the last
time I looked at it, and I am not sure how exactly it works now.

If the $subject patch can correctly keep the VBUS on for host-only mode,
we can somehow use dr_modei value to distinguish the mode. We don't have
to create a new vbus-always-on-in-host-mode flag. VBUS has to be always
on in host-only mode anyway, until some error condition happens.

Regards,
-Bin.
