From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2 02/11] CLK: use of_property_read_u32 instead of read_u8
Date: Fri, 21 Jun 2013 07:45:58 -0500
Message-ID: <20130621124558.GB16513@kahuna>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-3-git-send-email-t-kristo@ti.com>
 <CAPtuhThmsucSZ8XxL9kcqdssi2N2JHwRzDnbkbaVy6okW_LSRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60322 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933901Ab3FUMq1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jun 2013 08:46:27 -0400
Content-Disposition: inline
In-Reply-To: <CAPtuhThmsucSZ8XxL9kcqdssi2N2JHwRzDnbkbaVy6okW_LSRA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, tony@atomide.com, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree-discuss@lists.ozlabs.org

On 17:57-20130620, Mike Turquette wrote:
> On Wed, Jun 19, 2013 at 6:18 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > of_property_read_u8 does not work properly because of endianess problem
> > with its current implementation, and this causes it to always return
> > 0 with little endian architectures. Instead, use property_read_u32
> > until this is fixed.
> 
> Tero,
> 
> Thanks for the fix. Heiko Stubner pointed out to me that in order to
> read a u8 value the DT node needs to specify "/bits/ 8" before the
> values. From the of_property_read_u8_array kerneldoc:
> 
> "
> /**
> ...
>  * dts entry of array should be like:
>  *      property = /bits/ 8 <0x50 0x60 0x70>;
>  *
>  * The out_value is modified only if a valid u8 value can be decoded.
>  */
> "
> 
> Still I think it is a bit silly to have to do this in all of the
> bindings, so I'm going to roll this patch into my next version of the
> series if only for the sake of readability. Not only that but it is
> slightly more future proof for the binding to use a u32 value. The
> fact that the implementation in Linux uses a u8 is of little
> consequence to the binding.  I'll also add a cast like the following
> to your patch:
> 
> clk = clk_register_gate(NULL, clk_name, parent_name, 0, reg, (u8) bit_idx,
>                 clk_gate_flags, NULL);
> 
Given that dtb size could be directly impacted, could we consider
something like a preprocessor macro to make it readable, yet not too
huge dts size?
> 
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  drivers/clk/clk-divider.c |    4 ++--
> >  drivers/clk/clk-gate.c    |    4 ++--
> >  drivers/clk/clk-mux.c     |    4 ++--
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 17ea475..3413602 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -361,7 +361,7 @@ void of_divider_clk_setup(struct device_node *node)
> >         const char *parent_name;
> >         u8 clk_divider_flags = 0;
> >         u32 mask = 0;
> > -       u8 shift = 0;
> > +       u32 shift = 0;
> >         struct clk_div_table *table;
> >
> >         of_property_read_string(node, "clock-output-names", &clk_name);
> > @@ -375,7 +375,7 @@ void of_divider_clk_setup(struct device_node *node)
> >                 return;
> >         }
> >
> > -       if (of_property_read_u8(node, "bit-shift", &shift)) {
> > +       if (of_property_read_u32(node, "bit-shift", &shift)) {
> >                 shift = __ffs(mask);
> >                 pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
> >                                 __func__, shift, node->name);
> > diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> > index 72cf99d..61b4dc1 100644
> > --- a/drivers/clk/clk-gate.c
> > +++ b/drivers/clk/clk-gate.c
> > @@ -162,7 +162,7 @@ void of_gate_clk_setup(struct device_node *node)
> >         void __iomem *reg;
> >         const char *parent_name;
> >         u8 clk_gate_flags = 0;
> > -       u8 bit_idx = 0;
> > +       u32 bit_idx = 0;
> >
> >         of_property_read_string(node, "clock-output-names", &clk_name);
> >
> > @@ -170,7 +170,7 @@ void of_gate_clk_setup(struct device_node *node)
> >
> >         reg = of_iomap(node, 0);
> >
> > -       if (of_property_read_u8(node, "bit-shift", &bit_idx)) {
> > +       if (of_property_read_u32(node, "bit-shift", &bit_idx)) {
> >                 pr_err("%s: missing bit-shift property for %s\n",
> >                                 __func__, node->name);
> >                 return;
> > diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> > index c9f9f32..e63dd1b 100644
> > --- a/drivers/clk/clk-mux.c
> > +++ b/drivers/clk/clk-mux.c
> > @@ -170,7 +170,7 @@ void of_mux_clk_setup(struct device_node *node)
> >         int i;
> >         u8 clk_mux_flags = 0;
> >         u32 mask = 0;
> > -       u8 shift = 0;
> > +       u32 shift = 0;
> >
> >         of_property_read_string(node, "clock-output-names", &clk_name);
> >
> > @@ -194,7 +194,7 @@ void of_mux_clk_setup(struct device_node *node)
> >                 return;
> >         }
> >
> > -       if (of_property_read_u8(node, "bit-shift", &shift)) {
> > +       if (of_property_read_u32(node, "bit-shift", &shift)) {
> >                 shift = __ffs(mask);
> >                 pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
> >                                 __func__, shift, node->name);
> > --
> > 1.7.9.5
> >

-- 
Regards,
Nishanth Menon
