From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Trying to understand how to use new OMAP mux code
Date: Fri, 12 Mar 2010 11:12:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E619F2D2@dbde02.ent.ti.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
	 <20100311224812.GU2900@atomide.com>
 <738b3f7e1003112048n4859b29agefe9658dc5d70572@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54378 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab0CLFmU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 00:42:20 -0500
In-Reply-To: <738b3f7e1003112048n4859b29agefe9658dc5d70572@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

=20
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter Barada
> Sent: Friday, March 12, 2010 10:19 AM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Trying to understand how to use new OMAP mux code
>=20
> On Thu, Mar 11, 2010 at 5:48 PM, Tony Lindgren=20
> <tony@atomide.com> wrote:
> > * Peter Barada <peter.barada@gmail.com> [100311 14:29]:
> >> 1) Suppose I want to talk to a bluetooth chip through=20
> UART2. =A0UART2_TX
> >> =A0gives me a choice of pins to hook up to, either to pin=20
> AA26 in Mode0,
> >> or pin AF5 in Mode1. =A0If I use omape_mux_init_signal("uart2_tx",
> >> OMAP_PIN_OUTPUT), which pin will that map to?
> >
> > You need to check the omap package type you're using to find
> > out the correct ball name. If you get lucky, that's already in
> > mux34xx.c and you don't need search through the TRMs :)
>=20
> The ball name helps me to identify it, but if I understand correctly,
> none of the mux code allows the use of a ball name - I have to use th=
e
> mode0 name of the ball I want to use (and as you say later qualified
> by the signal I want hooked up to that pi), right?
>=20
> >> 2) How can I tell the muxing code that I want a specific pin for m=
y
> >> UART2_TX signal (that's not a GPIO since those can be directly
> >> specified by GPIO number)?
> >
> > Then you want to use the full signal name:
> >
> > omap_mux_init_signal("mode0_name.desired_mode", OMAP_PIN_FLAGS)
> >
> > But as the balls can be separate for each package type, you
> > need to figure that out first.
>=20
> If my board sets up the balls packaging right (for a 3530 CBB
> package), then "omap_mux_init_signal("mcbsp3_clkx.uart2_tx",
> OMAP_PIN_OUTPUT);", will setup pin AF5 as mode2, output - thereby
> muxing GPIO pin 142 to the UART2_TX signal?
>=20
> Next question is for the AM3517 (491 pin), I see the setup for
> board-am3517evm int he 2.6.33-rc3 kernel refers to the CBB package
> which the comments indicate is a 515 pin package - is this the correc=
t
> package to use for the AM3517?  Since I have to traverse from my
> schematic via ball name to signal name, it helps to know I'm looking
> at the right package list.
>=20
> Also, it looks like the references in arch/arm/mach-omap2/mux24xx.c t=
o
> TI forum URLs (e.g.  http://community.ti.com/forums/t/10982.aspx)
> takes you to http://e2e.ti.com/support/default.aspx - do you need a
> "myTI" login to see that forum message?.

No login is required. It is just that the forum backend has changed and
the original link would be leading to a HTTP404 redirecting you to the
main page. If we know the original title, search should help in locatin=
g
the original post.

Best regards,
Sanjeev

>=20
>=20
> > Regards,
> >
> > Tony
> >
>=20
> So if I use: omap
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
