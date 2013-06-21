From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 02/11] CLK: use of_property_read_u32 instead of read_u8
Date: Fri, 21 Jun 2013 09:21:00 -0700
Message-ID: <20130621162100.9136.5273@quantum>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-3-git-send-email-t-kristo@ti.com>
 <CAPtuhThmsucSZ8XxL9kcqdssi2N2JHwRzDnbkbaVy6okW_LSRA@mail.gmail.com>
 <20130621124558.GB16513@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130621124558.GB16513@kahuna>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Quoting Nishanth Menon (2013-06-21 05:45:58)
> On 17:57-20130620, Mike Turquette wrote:
> > On Wed, Jun 19, 2013 at 6:18 AM, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> wrote:
> > > of_property_read_u8 does not work properly because of endianess problem
> > > with its current implementation, and this causes it to always return
> > > 0 with little endian architectures. Instead, use property_read_u32
> > > until this is fixed.
> > 
> > Tero,
> > 
> > Thanks for the fix. Heiko Stubner pointed out to me that in order to
> > read a u8 value the DT node needs to specify "/bits/ 8" before the
> > values. From the of_property_read_u8_array kerneldoc:
> > 
> > "
> > /**
> > ...
> >  * dts entry of array should be like:
> >  *      property = /bits/ 8 <0x50 0x60 0x70>;
> >  *
> >  * The out_value is modified only if a valid u8 value can be decoded.
> >  */
> > "
> > 
> > Still I think it is a bit silly to have to do this in all of the
> > bindings, so I'm going to roll this patch into my next version of the
> > series if only for the sake of readability. Not only that but it is
> > slightly more future proof for the binding to use a u32 value. The
> > fact that the implementation in Linux uses a u8 is of little
> > consequence to the binding.  I'll also add a cast like the following
> > to your patch:
> > 
> > clk = clk_register_gate(NULL, clk_name, parent_name, 0, reg, (u8) bit_idx,
> >                 clk_gate_flags, NULL);
> > 
> Given that dtb size could be directly impacted, could we consider
> something like a preprocessor macro to make it readable, yet not too
> huge dts size?

bit-shift is an optional property and you don't need it at all. It is
mostly there for legacy reasons and also it is useful to the Rockchip
and Hisilicon drivers.

The OMAP DT clock data could simply use a 32-bit mask that covers the
whole register and not provide bit-shift at all, if you're worried about
the extra 24 bits.

Regards,
Mike

> > 
> > >
> > > Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  drivers/clk/clk-divider.c |    4 ++--
> > >  drivers/clk/clk-gate.c    |    4 ++--
> > >  drivers/clk/clk-mux.c     |    4 ++--
> > >  3 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > > index 17ea475..3413602 100644
> > > --- a/drivers/clk/clk-divider.c
> > > +++ b/drivers/clk/clk-divider.c
> > > @@ -361,7 +361,7 @@ void of_divider_clk_setup(struct device_node *node)
> > >         const char *parent_name;
> > >         u8 clk_divider_flags = 0;
> > >         u32 mask = 0;
> > > -       u8 shift = 0;
> > > +       u32 shift = 0;
> > >         struct clk_div_table *table;
> > >
> > >         of_property_read_string(node, "clock-output-names", &clk_name);
> > > @@ -375,7 +375,7 @@ void of_divider_clk_setup(struct device_node *node)
> > >                 return;
> > >         }
> > >
> > > -       if (of_property_read_u8(node, "bit-shift", &shift)) {
> > > +       if (of_property_read_u32(node, "bit-shift", &shift)) {
> > >                 shift = __ffs(mask);
> > >                 pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
> > >                                 __func__, shift, node->name);
> > > diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> > > index 72cf99d..61b4dc1 100644
> > > --- a/drivers/clk/clk-gate.c
> > > +++ b/drivers/clk/clk-gate.c
> > > @@ -162,7 +162,7 @@ void of_gate_clk_setup(struct device_node *node)
> > >         void __iomem *reg;
> > >         const char *parent_name;
> > >         u8 clk_gate_flags = 0;
> > > -       u8 bit_idx = 0;
> > > +       u32 bit_idx = 0;
> > >
> > >         of_property_read_string(node, "clock-output-names", &clk_name);
> > >
> > > @@ -170,7 +170,7 @@ void of_gate_clk_setup(struct device_node *node)
> > >
> > >         reg = of_iomap(node, 0);
> > >
> > > -       if (of_property_read_u8(node, "bit-shift", &bit_idx)) {
> > > +       if (of_property_read_u32(node, "bit-shift", &bit_idx)) {
> > >                 pr_err("%s: missing bit-shift property for %s\n",
> > >                                 __func__, node->name);
> > >                 return;
> > > diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> > > index c9f9f32..e63dd1b 100644
> > > --- a/drivers/clk/clk-mux.c
> > > +++ b/drivers/clk/clk-mux.c
> > > @@ -170,7 +170,7 @@ void of_mux_clk_setup(struct device_node *node)
> > >         int i;
> > >         u8 clk_mux_flags = 0;
> > >         u32 mask = 0;
> > > -       u8 shift = 0;
> > > +       u32 shift = 0;
> > >
> > >         of_property_read_string(node, "clock-output-names", &clk_name);
> > >
> > > @@ -194,7 +194,7 @@ void of_mux_clk_setup(struct device_node *node)
> > >                 return;
> > >         }
> > >
> > > -       if (of_property_read_u8(node, "bit-shift", &shift)) {
> > > +       if (of_property_read_u32(node, "bit-shift", &shift)) {
> > >                 shift = __ffs(mask);
> > >                 pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
> > >                                 __func__, shift, node->name);
> > > --
> > > 1.7.9.5
> > >
> 
> -- 
> Regards,
> Nishanth Menon
