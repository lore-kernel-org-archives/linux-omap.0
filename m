From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Mon, 12 May 2014 13:15:17 -0700
Message-ID: <20140512201517.GC5668@atomide.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
 <20140512195050.GB5668@atomide.com>
 <CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [140512 13:00]:
> >>
> >> +     i2c2_pins: pinmux_i2c2_pins {
> >> +             pinctrl-single,pins = <
> >> +                     0x178 (PIN_INPUT_PULLUP | MUX_MODE3)    /* uart1_ctsn.i2c2_sda */
> >> +                     0x17c (PIN_INPUT_PULLUP | MUX_MODE3)    /* uart1_rtsn.i2c2_scl */
> >> +             >;
> >> +     };
> >> +
> >>       uart0_pins: pinmux_uart0_pins {
> >>               pinctrl-single,pins = <
> >>                       0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
> >>
> >> @@ -222,6 +229,15 @@
> >>
> >>  };
> >>
> >> +
> >> +&i2c2 {
> >> +     pinctrl-names = "default";
> >> +     pinctrl-0 = <&i2c2_pins>;
> >> +
> >> +     status = "okay";
> >> +     clock-frequency = <100000>;
> >> +};
> >> +
> >
> > If these pins are not used for i2c2 on some capes, this device
> > should be set to status = "disabled" state by default. Then
> > u-boot could re-enable it on the boards that have i2c2 in use.
> 
> To-date, this is the i2c bus that all capes have placed an at24 eeprom
> for cape identification.

And how many capes actually implement the eeprom cape identification
out of the available capes? :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
