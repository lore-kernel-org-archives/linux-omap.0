From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: Add aliases for all serial ports
Date: Mon, 10 Nov 2014 15:49:38 -0800
Message-ID: <20141110234937.GG31454@atomide.com>
References: <1413908295-699-1-git-send-email-nm@ti.com>
 <3461773.MMIsJQMVIu@wuerfel>
 <5446BCEB.3020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5446BCEB.3020708-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Franklin Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [141021 13:08]:
> On 10/21/2014 02:57 PM, Arnd Bergmann wrote:
> > On Tuesday 21 October 2014 11:18:15 Nishanth Menon wrote:
> >> Add serial port aliases for consoles > 6.
> >>
> >> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  arch/arm/boot/dts/dra7.dtsi |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> >> index 9cc9843..208dd83 100644
> >> --- a/arch/arm/boot/dts/dra7.dtsi
> >> +++ b/arch/arm/boot/dts/dra7.dtsi
> >> @@ -34,6 +34,10 @@
> >>                 serial3 = &uart4;
> >>                 serial4 = &uart5;
> >>                 serial5 = &uart6;
> >> +               serial6 = &uart7;
> >> +               serial7 = &uart8;
> >> +               serial8 = &uart9;
> >> +               serial9 = &uart10;
> >>
> > 
> > I think this was wrong to start with: The aliases should be in the per-board
> > .dts file and only list the ones that are actually connected to the outside.
> > 
> > Otherwise the numbering won't match what's written on the board.
> 
> At least in the case of DRA7 boards, they are not written specifically
> since they come out over onboard FTDI usb2serial.
> 
> This will at least ensure that /dev/ttyO9 will always point to uart10
> no matter the board, instead of having ttyO0 always pointing to
> console serial port no matter the board (and having to guess which
> figure out it actually was aliased to).

It seems that having the UART numbering make sense is a good reason
to apply this one. So applying into omap-for-v3.19/dt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
