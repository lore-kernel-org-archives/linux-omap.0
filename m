From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Thu, 11 Mar 2010 23:48:45 -0500
Message-ID: <738b3f7e1003112048n4859b29agefe9658dc5d70572@mail.gmail.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
	 <20100311224812.GU2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab0CLEsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 23:48:45 -0500
Received: by pvb32 with SMTP id 32so327514pvb.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 20:48:45 -0800 (PST)
In-Reply-To: <20100311224812.GU2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Mar 11, 2010 at 5:48 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Peter Barada <peter.barada@gmail.com> [100311 14:29]:
>> 1) Suppose I want to talk to a bluetooth chip through UART2. =A0UART=
2_TX
>> =A0gives me a choice of pins to hook up to, either to pin AA26 in Mo=
de0,
>> or pin AF5 in Mode1. =A0If I use omape_mux_init_signal("uart2_tx",
>> OMAP_PIN_OUTPUT), which pin will that map to?
>
> You need to check the omap package type you're using to find
> out the correct ball name. If you get lucky, that's already in
> mux34xx.c and you don't need search through the TRMs :)

The ball name helps me to identify it, but if I understand correctly,
none of the mux code allows the use of a ball name - I have to use the
mode0 name of the ball I want to use (and as you say later qualified
by the signal I want hooked up to that pi), right?

>> 2) How can I tell the muxing code that I want a specific pin for my
>> UART2_TX signal (that's not a GPIO since those can be directly
>> specified by GPIO number)?
>
> Then you want to use the full signal name:
>
> omap_mux_init_signal("mode0_name.desired_mode", OMAP_PIN_FLAGS)
>
> But as the balls can be separate for each package type, you
> need to figure that out first.

If my board sets up the balls packaging right (for a 3530 CBB
package), then "omap_mux_init_signal("mcbsp3_clkx.uart2_tx",
OMAP_PIN_OUTPUT);", will setup pin AF5 as mode2, output - thereby
muxing GPIO pin 142 to the UART2_TX signal?

Next question is for the AM3517 (491 pin), I see the setup for
board-am3517evm int he 2.6.33-rc3 kernel refers to the CBB package
which the comments indicate is a 515 pin package - is this the correct
package to use for the AM3517?  Since I have to traverse from my
schematic via ball name to signal name, it helps to know I'm looking
at the right package list.

Also, it looks like the references in arch/arm/mach-omap2/mux24xx.c to
TI forum URLs (e.g.  http://community.ti.com/forums/t/10982.aspx)
takes you to http://e2e.ti.com/support/default.aspx - do you need a
"myTI" login to see that forum message?.


> Regards,
>
> Tony
>

So if I use: omap
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
