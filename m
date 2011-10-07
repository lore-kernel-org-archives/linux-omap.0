From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
Date: Fri, 07 Oct 2011 16:15:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110071612380.6390@xanadu.home>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
 <4E5636CD.4080302@ti.com>
 <CANfBPZ-AAZx9TxO88EgxCtOUsWrsYzbK+M2d6cVSS7Kf-LwS3w@mail.gmail.com>
 <20111006195016.GM6324@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_tvwg1WGnUY2zF0FToPV30Q)"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:45138 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab1JGUP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 16:15:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSP00AGSPMHVU10@VL-VM-MR005.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 07 Oct 2011 16:15:53 -0400 (EDT)
In-reply-to: <20111006195016.GM6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_tvwg1WGnUY2zF0FToPV30Q)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Thu, 6 Oct 2011, Tony Lindgren wrote:

> * S, Venkatraman <svenkatr@ti.com> [110825 07:23]:
> > On Thu, Aug 25, 2011 at 5:19 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > > Hi Venkat,
> > >
> > > On 8/24/2011 9:46 PM, S, Venkatraman wrote:
> > >>
> > >> As part of an effort to get single ARM kernel binary [1],
> > >> multiple  definitions of NR_IRQS under various platforms
> > >> have to be reconciled and abstracted away from common code.
> > >>
> > >> This patch series takes the small step of populating the
> > >> machine descriptors with the pre-existing nr_irqs field.
> > >> Eventually, the common irq handler code will only look at this
> > >> field and not the compile time constant.
> > >
> > > Not related to this patch, but still on that topic. The current NR_IRQS
> > > depends as well on board stuff, like for example : the Phoenix
> > > IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
> > > Is there a plan to get rid of this static defines?
> > >
> > 
> > Currently, the goal is to get rid of the singleton nature
> > of NR_IRQS. Then it just becomes a property of the
> > platform, and the arm common code should not see this define.
> > This cleanup has to be done across multiple SoCs, not just OMAP.
> > 
> > After I get to complete some meaningful cleanup of NR_IRQS,
> > I can look into the static defines that you mention.
> 
> I suggest we wait on this patch as the NR_IRQS should be the
> board specific true number of interrupts including chained
> interrupts from external devices like twl. So just setting
> it to NR_IRQS does not help much. Also, the board-*.c files
> will be going aways with device tree at some point.

This is prerequisite to some other cleanup orthogonal to DT being worked 
in parallel.  I would prefer if DT wasn't a serialization point for 
this.


Nicolas

--Boundary_(ID_tvwg1WGnUY2zF0FToPV30Q)--
