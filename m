From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Thu, 19 Jul 2012 00:55:05 -0500
Message-ID: <CAOMWX4dWnJSOwLVvrAfMd7a9eKE97ywR0TrS6imHFA67V5QZag@mail.gmail.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-5-git-send-email-t-kristo@ti.com> <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
 <1342602902.4672.91.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59603 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721Ab2GSFz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 01:55:27 -0400
Received: by weyx10 with SMTP id x10so1299168wey.10
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 22:55:25 -0700 (PDT)
In-Reply-To: <1342602902.4672.91.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 18, 2012 at 4:15 AM, Tero Kristo <t-kristo@ti.com> wrote:
>
> On Tue, 2012-07-17 at 02:59 -0500, Menon, Nishanth wrote:
> > Couple of minor comments:
> > On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > [...]
> > >  /**
> > > + * _omap4_update_context_lost - increment hwmod context loss counter
> > > if
> > > + * hwmod context was lost, and clear hardware context loss reg
> > > + * @oh: hwmod to check for context loss
> > > + *
> > > + * If the PRCM indicates that the hwmod @oh lost context, increment
> > > + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> > > + * bits. No return value.
> > > + */
> > > +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> > > +{
> > > +       u32 r;
> > > +
> > > +       if (oh->prcm.omap4.context_offs == USHRT_MAX)
> > > +               return;
> > would'nt it be better to return a dummy incremental counter instead of
> > returning no context loss (count = 0)?
>
> I guess you are right, this way we may have some extra context restores
> for modules which don't have context offs defined, rather than not
> restoring them at all. Only thing I can think might prevent this is if
> there are modules that never lose context but don't have context
> register? How about omap5+?

there has been an interesting debate ongoing with HWAUTO and context
loss count handling -> since we update only on _enable, this might
actually be interesting to consider:
enable
idle
un_idle (lost context)
read counter -> no update

Now to handle modules that never loose context - they have to be in
wakeup domain.. should we consider a flag for those? would'nt matter
o5 or not, context is still the same.. this issue could be resolved if
counter update is done even when a check is done.


> >
> > > +
> > > +       r =
> > > omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
> > > +
> > > oh->clkdm->pwrdm.ptr->prcm_offs,
> > > +                                       oh->prcm.omap4.context_offs);
> > > +
> > > +       if (!r)
> > > +               return;
> > > +
> > > +       oh->prcm.omap4.context_lost_counter++;
> > need to be careful about counter overflow.
>
> Well, this code can't do much for that even if it overflows... the type
> for the context_lost_counter is unsigned though, maybe it should be
> expanded if you are worried...?

it can hit 0 with overflow(no context loss). that will not be good, right?

How about something like:

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eac813a..5fb9572 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1606,6 +1606,18 @@ static void _reconfigure_io_chain(void)
        spin_unlock_irqrestore(&io_chain_lock, flags);
 }

+static inline void _omap4_inc_context_loss(unsigned int *v)
+{
+
+       /*
+        * Context loss count has to be a non-negative value.
+        * Clear the sign bit to get a value range from 1 to
+        * INT_MAX.
+        */
+       *v = (*v + 1) & INT_MAX;
+       *v = *v ? *v : 1;
+}
+
 /**
  * _omap4_update_context_lost - increment hwmod context loss counter if
  * hwmod context was lost, and clear hardware context loss reg
@@ -1629,7 +1641,7 @@ static void _omap4_update_context_lost(struct
omap_hwmod *oh)
        if (!r)
                return;

-       oh->prcm.omap4.context_lost_counter++;
+       _omap4_inc_context_loss(&oh->prcm.omap4.context_lost_counter);

        omap4_prminst_write_inst_reg(r, oh->clkdm->pwrdm.ptr->prcm_partition,
                                     oh->clkdm->pwrdm.ptr->prcm_offs,

Regards,
Nishanth Menon
