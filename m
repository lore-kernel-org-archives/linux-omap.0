From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and
 pinctrl_parse_index_with_args
Date: Mon, 31 Oct 2016 01:13:36 -0500
Message-ID: <20161031061336.ya6jcjttvbgdqnld@rob-hp-laptop>
References: <20161025164538.453-1-tony@atomide.com>
 <20161025164538.453-2-tony@atomide.com>
 <CACRpkdYWB4aa2XvW-yT39cKqy3XChSwCiFRy1mVWhbhse63=3A@mail.gmail.com>
 <20161027141120.jqvul6q7iz5fjsmb@atomide.com>
 <20161028165338.y5fyavbw5xfxweg3@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161028165338.y5fyavbw5xfxweg3-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 28, 2016 at 09:53:38AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161027 07:59]:
> > * Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161027 00:57]:
> > > On Tue, Oct 25, 2016 at 6:45 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > > > +/*
> > > > + * For pinctrl binding, typically #pinctrl-cells is for the pin controller
> > > > + * device, so either parent or grandparent. See pinctrl-bindings.txt.
> > > > + */
> > > > +static int pinctrl_find_cells_size(const struct device_node *np,
> > > > +                                  const char *cells_name)
> > > > +{
> > > > +       int cells_size, error;
> > > > +
> > > > +       error = of_property_read_u32(np->parent, cells_name, &cells_size);
> > > > +       if (error) {
> > > > +               error = of_property_read_u32(np->parent->parent,
> > > > +                                            cells_name, &cells_size);
> > > > +               if (error)
> > > > +                       return -ENOENT;
> > > > +       }
> > > > +
> > > > +       return cells_size;
> > > > +}
> > > 
> > > Can't we just hardcode this to "#pinctrl-cells" and skip the cells_name
> > > parameter? We can parametrize it the day we need it instead.
> > 
> > Sure we can do that.
> > 
> > > The rest of the helpers look nice and clean.
> > 
> > OK cool thanks,
> 
> Below is an updated version of this patch with documentation updated
> and cells_name removed. I'll repost the whole series once the DT
> binding has been reviewed.
> 
> Regards,
> 
> Tony
> 8< -------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Tue, 25 Oct 2016 08:33:34 -0700
> Subject: [PATCH] pinctrl: Introduce generic #pinctrl-cells and
>  pinctrl_parse_index_with_args
> 
> Introduce #pinctrl-cells helper binding and generic helper functions
> pinctrl_count_index_with_args() and pinctrl_parse_index_with_args().
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../bindings/pinctrl/pinctrl-bindings.txt          |  44 ++++++-

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/pinctrl/devicetree.c                       | 144 +++++++++++++++++++++
>  drivers/pinctrl/devicetree.h                       |  21 +++
>  3 files changed, 208 insertions(+), 1 deletion(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
