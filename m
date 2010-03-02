From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] serial: Add OMAP high-speed UART driver.
Date: Tue, 2 Mar 2010 20:43:24 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C44C2348__12857.555007986$1267542848$gmane$org@dbde02.ent.ti.com>
References: <41322.192.168.10.89.1267454612.squirrel@dbdmail.itg.ti.com>
	 <20100301184600.GC3389@atomide.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED95FC1@dbde02.ent.ti.com>
	 <20100302060821.GI3389@atomide.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED9600D@dbde02.ent.ti.com>
	 <20100302065224.GL3389@atomide.com>
 <618f0c911003020546mb7c8412o2bac4e86a081332b@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED96358@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C44C22F6@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED963B1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0CBPNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 10:13:31 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026ED963B1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Greg KH <greg@kroah.com>

> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Tuesday, March 02, 2010 8:34 PM
> To: Shilimkar, Santosh; S, Venkatraman; Tony Lindgren; Raja, Govindraj; Greg KH; linux-
> serial@vger.kernel.org; linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; Kevin Hilman; Olof
> Johansson
> Subject: RE: [PATCH] serial: Add OMAP high-speed UART driver.
> 
> 
> Santosh,
> 
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Tuesday, March 02, 2010 7:34 PM
> > To: G, Manjunath Kondaiah; S, Venkatraman; Tony Lindgren;
> > Raja, Govindraj; Greg KH; linux-serial@vger.kernel.org;
> > linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Kevin Hilman; Olof Johansson
> > Subject: RE: [PATCH] serial: Add OMAP high-speed UART driver.
> >
> > <snip snip>
> > > > > --
> > > > CDAC is a shadow register used for monitoring the DMA channel.
> > > >  I think it would be a lot
> > > > simpler if omap_start_dma() always resets CDAC to 0, and the
> > > > UART driver
> > > > just not set it explicitly.
> > >
> > > This seems to be better option than exposing CDAC read/write API
> > > to other drivers since user need to write '0' before
> > starting any DMA
> > > transfer which can be be done in omap_start_dma().
> > >
> > > I am wondering how other drivers are using DMA transfer
> > API's without
> > > resetting CDAC to zero.
> > >
> > It's needed only if some one is interested in that count.
> > UART seems to
> > using this counter where as other driver don't.
> >
> > Why do you think drivers need to know about counter value ?
> 
> Reading of non zero value(after reset to zero and enabling dma channel)
> from CDAC register indicates that, DMA transfer has started and user can
> rely on DMA4_CCENi and DMA4_CCFNi element and frame counters.
> 
> If the CDAC value is zero even after starting DMA channel, indicates
> error.
Not necessary. The DMA can still wait for the hw sync signal and the CDAC
can remain 0 if the hw sync in not received. This will be any way returned 
by DMA error ( SYNC lost)

This register was mainly suppose to be used for debug purposes.
Regards,
Santosh
