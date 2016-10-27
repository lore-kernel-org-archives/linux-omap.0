From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and
 pinctrl_parse_index_with_args
Date: Thu, 27 Oct 2016 07:11:20 -0700
Message-ID: <20161027141120.jqvul6q7iz5fjsmb@atomide.com>
References: <20161025164538.453-1-tony@atomide.com>
 <20161025164538.453-2-tony@atomide.com>
 <CACRpkdYWB4aa2XvW-yT39cKqy3XChSwCiFRy1mVWhbhse63=3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYWB4aa2XvW-yT39cKqy3XChSwCiFRy1mVWhbhse63=3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161027 00:57]:
> On Tue, Oct 25, 2016 at 6:45 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> I need some DT person to take a look at this binding and ACK it.
> 
> > +For pin controller hardware with a large number of identical registers naming
> > +each bit both can be unmaintainable. Further there can be a large number of similar
> > +pinctrl hardware using the same registers for different purposes depending on the
> > +packaging. For cases like this, the pinctrl driver may use pinctrl-pin-array helper
> > +binding using a hardware based index and a number of configuration values:
> 
> Maybe we can reword it a bit so that it is clear that this is an
> either-or approach
> for the pin controller, either they use the pins/groups/functions scheme
> or they use this scheme.

Sure, this is just an optional helper.

> > +pincontroller {
> > +       ... /* Standard DT properties for the device itself elided */
> > +       #pinctrl-cells = <2>;
> > +
> > +       state_0_node_a {
> > +               pinctrl-pin-array = <
> > +                       0 A_DELAY_PS(0) G_DELAY_PS(120)
> > +                       4 A_DELAY_PS(0) G_DELAY_PS(360)
> > +                       ...
> > +               >;
> > +       };
> > +       ...
> > +};
> 
> Looks all right to me. Sad to add to the binding mess, but on the other
> hand, in the overall picture this nicely consolidates and structure
> pinctrl-single.
> 
> > +The index for pinctrl-pin-array must relate to the hardware for the pinctrl
> > +registers, and must not be a virtual index of pin instances. The reason for
> > +this is to avoid mapping of the index in the dts files and the pin controller
> > +driver as it can change.
> 
> OK
> 
> > And we want to avoid another case of interrupt
> > +numbering with pinctrl numbering.
> 
> Maybe this file is not a good place for making technical arguments,
> more describing what we agreed on, so cut that sentence IMO.

Sure :)

> > +/*
> > + * For pinctrl binding, typically #pinctrl-cells is for the pin controller
> > + * device, so either parent or grandparent. See pinctrl-bindings.txt.
> > + */
> > +static int pinctrl_find_cells_size(const struct device_node *np,
> > +                                  const char *cells_name)
> > +{
> > +       int cells_size, error;
> > +
> > +       error = of_property_read_u32(np->parent, cells_name, &cells_size);
> > +       if (error) {
> > +               error = of_property_read_u32(np->parent->parent,
> > +                                            cells_name, &cells_size);
> > +               if (error)
> > +                       return -ENOENT;
> > +       }
> > +
> > +       return cells_size;
> > +}
> 
> Can't we just hardcode this to "#pinctrl-cells" and skip the cells_name
> parameter? We can parametrize it the day we need it instead.

Sure we can do that.

> The rest of the helpers look nice and clean.

OK cool thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
