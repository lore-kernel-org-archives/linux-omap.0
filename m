From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per
 hwmod/module context lost count
Date: Thu, 19 Jul 2012 12:49:40 +0300
Message-ID: <1342691380.4672.123.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
	 <1339428387-4800-5-git-send-email-t-kristo@ti.com>
	 <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
	 <1342602902.4672.91.camel@sokoban>
	 <CAOMWX4dWnJSOwLVvrAfMd7a9eKE97ywR0TrS6imHFA67V5QZag@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40197 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2GSJtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 05:49:50 -0400
In-Reply-To: <CAOMWX4dWnJSOwLVvrAfMd7a9eKE97ywR0TrS6imHFA67V5QZag@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-19 at 00:55 -0500, Menon, Nishanth wrote:
> On Wed, Jul 18, 2012 at 4:15 AM, Tero Kristo <t-kristo@ti.com> wrote:
> >
> > On Tue, 2012-07-17 at 02:59 -0500, Menon, Nishanth wrote:
> > > Couple of minor comments:
> > > On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > > [...]
> > > >  /**
> > > > + * _omap4_update_context_lost - increment hwmod context loss counter
> > > > if
> > > > + * hwmod context was lost, and clear hardware context loss reg
> > > > + * @oh: hwmod to check for context loss
> > > > + *
> > > > + * If the PRCM indicates that the hwmod @oh lost context, increment
> > > > + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> > > > + * bits. No return value.
> > > > + */
> > > > +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> > > > +{
> > > > +       u32 r;
> > > > +
> > > > +       if (oh->prcm.omap4.context_offs == USHRT_MAX)
> > > > +               return;
> > > would'nt it be better to return a dummy incremental counter instead of
> > > returning no context loss (count = 0)?
> >
> > I guess you are right, this way we may have some extra context restores
> > for modules which don't have context offs defined, rather than not
> > restoring them at all. Only thing I can think might prevent this is if
> > there are modules that never lose context but don't have context
> > register? How about omap5+?
> 
> there has been an interesting debate ongoing with HWAUTO and context
> loss count handling -> since we update only on _enable, this might
> actually be interesting to consider:
> enable
> idle
> un_idle (lost context)
> read counter -> no update
> 
> Now to handle modules that never loose context - they have to be in
> wakeup domain.. should we consider a flag for those? would'nt matter
> o5 or not, context is still the same.. this issue could be resolved if
> counter update is done even when a check is done.

Yea, that would be an option. I think I'll add a flag for not losing
context ever.

> 
> 
> > >
> > > > +
> > > > +       r =
> > > > omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
> > > > +
> > > > oh->clkdm->pwrdm.ptr->prcm_offs,
> > > > +                                       oh->prcm.omap4.context_offs);
> > > > +
> > > > +       if (!r)
> > > > +               return;
> > > > +
> > > > +       oh->prcm.omap4.context_lost_counter++;
> > > need to be careful about counter overflow.
> >
> > Well, this code can't do much for that even if it overflows... the type
> > for the context_lost_counter is unsigned though, maybe it should be
> > expanded if you are worried...?
> 
> it can hit 0 with overflow(no context loss). that will not be good, right?

Zero doesn't mean no context loss. If counter was previous MAX_INT, if
it goes to zero it is still a context loss, as the counter value
differs. Drivers do check against diff in the context loss counter, and
if there is one, they do restore which is the right way to handle it. No
need to unnecessarily make this more complicated than it is.

-Tero


