From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
Date: Fri, 7 Oct 2011 13:51:45 -0700
Message-ID: <20111007205145.GA2293@atomide.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
 <4E5636CD.4080302@ti.com>
 <CANfBPZ-AAZx9TxO88EgxCtOUsWrsYzbK+M2d6cVSS7Kf-LwS3w@mail.gmail.com>
 <20111006195016.GM6324@atomide.com>
 <alpine.LFD.2.02.1110071612380.6390@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54814 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1JGUvt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 16:51:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110071612380.6390@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Nicolas Pitre <nico@fluxnic.net> [111007 12:41]:
> On Thu, 6 Oct 2011, Tony Lindgren wrote:
>=20
> > * S, Venkatraman <svenkatr@ti.com> [110825 07:23]:
> > > On Thu, Aug 25, 2011 at 5:19 PM, Cousson, Benoit <b-cousson@ti.co=
m> wrote:
> > > > Hi Venkat,
> > > >
> > > > On 8/24/2011 9:46 PM, S, Venkatraman wrote:
> > > >>
> > > >> As part of an effort to get single ARM kernel binary [1],
> > > >> multiple =C2=A0definitions of NR_IRQS under various platforms
> > > >> have to be reconciled and abstracted away from common code.
> > > >>
> > > >> This patch series takes the small step of populating the
> > > >> machine descriptors with the pre-existing nr_irqs field.
> > > >> Eventually, the common irq handler code will only look at this
> > > >> field and not the compile time constant.
> > > >
> > > > Not related to this patch, but still on that topic. The current=
 NR_IRQS
> > > > depends as well on board stuff, like for example : the Phoenix
> > > > IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
> > > > Is there a plan to get rid of this static defines?
> > > >
> > >=20
> > > Currently, the goal is to get rid of the singleton nature
> > > of NR_IRQS. Then it just becomes a property of the
> > > platform, and the arm common code should not see this define.
> > > This cleanup has to be done across multiple SoCs, not just OMAP.
> > >=20
> > > After I get to complete some meaningful cleanup of NR_IRQS,
> > > I can look into the static defines that you mention.
> >=20
> > I suggest we wait on this patch as the NR_IRQS should be the
> > board specific true number of interrupts including chained
> > interrupts from external devices like twl. So just setting
> > it to NR_IRQS does not help much. Also, the board-*.c files
> > will be going aways with device tree at some point.
>=20
> This is prerequisite to some other cleanup orthogonal to DT being wor=
ked=20
> in parallel.  I would prefer if DT wasn't a serialization point for=20
> this.

I see. How about let's populate the real number of interrupts for the
known boards then while at it.

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
