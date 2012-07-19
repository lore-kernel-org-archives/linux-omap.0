From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per
 hwmod/module context lost count
Date: Thu, 19 Jul 2012 14:44:27 +0300
Message-ID: <1342698267.4672.126.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
	 <1339428387-4800-5-git-send-email-t-kristo@ti.com>
	 <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
	 <1342602902.4672.91.camel@sokoban>
	 <CAOMWX4dWnJSOwLVvrAfMd7a9eKE97ywR0TrS6imHFA67V5QZag@mail.gmail.com>
	 <1342691380.4672.123.camel@sokoban>
	 <CAMQu2gy8i1Fx82Omg8OuSk2gb6ySqMspap4_w7zf1V5BUaYKTQ@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53113 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab2GSLog (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 07:44:36 -0400
In-Reply-To: <CAMQu2gy8i1Fx82Omg8OuSk2gb6ySqMspap4_w7zf1V5BUaYKTQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-19 at 16:05 +0530, Shilimkar, Santosh wrote:
> On Thu, Jul 19, 2012 at 3:19 PM, Tero Kristo <t-kristo@ti.com> wrote:
> >
> > On Thu, 2012-07-19 at 00:55 -0500, Menon, Nishanth wrote:
> > > On Wed, Jul 18, 2012 at 4:15 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > > >
> > > > On Tue, 2012-07-17 at 02:59 -0500, Menon, Nishanth wrote:
> > > > > Couple of minor comments:
> > > > > On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com>
> > > > > wrote:
> > > > > [...]
> > > > > >  /**
> > > > > > + * _omap4_update_context_lost - increment hwmod context loss
> > > > > > counter
> > > > > > if
> > > > > > + * hwmod context was lost, and clear hardware context loss reg
> > > > > > + * @oh: hwmod to check for context loss
> > > > > > + *
> > > > > > + * If the PRCM indicates that the hwmod @oh lost context,
> > > > > > increment
> > > > > > + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> > > > > > + * bits. No return value.
> > > > > > + */
> > > > > > +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> > > > > > +{
> > > > > > +       u32 r;
> > > > > > +
> > > > > > +       if (oh->prcm.omap4.context_offs == USHRT_MAX)
> > > > > > +               return;
> > > > > would'nt it be better to return a dummy incremental counter instead
> > > > > of
> > > > > returning no context loss (count = 0)?
> > > >
> > > > I guess you are right, this way we may have some extra context
> > > > restores
> > > > for modules which don't have context offs defined, rather than not
> > > > restoring them at all. Only thing I can think might prevent this is if
> > > > there are modules that never lose context but don't have context
> > > > register? How about omap5+?
> > >
> > > there has been an interesting debate ongoing with HWAUTO and context
> > > loss count handling -> since we update only on _enable, this might
> > > actually be interesting to consider:
> > > enable
> > > idle
> > > un_idle (lost context)
> > > read counter -> no update
> > >
> > > Now to handle modules that never loose context - they have to be in
> > > wakeup domain.. should we consider a flag for those? would'nt matter
> > > o5 or not, context is still the same.. this issue could be resolved if
> > > counter update is done even when a check is done.
> >
> > Yea, that would be an option. I think I'll add a flag for not losing
> > context ever.
> >
> You just access the module power domain from hwmod and then
> you already know whether it is AON or not. The flag idea
> was discussed in context of [1]. See if you can re-use that same idea.

That looks better still, thanks for the tip.

-Tero


