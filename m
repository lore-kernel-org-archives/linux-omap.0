From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: simple sd card performance bug fix on OMAP
Date: Thu, 10 Jun 2010 10:31:07 -0500
Message-ID: <005001cb08b1$f349ba40$544ff780@am.dhcp.ti.com>
References: <4C0013DC.6060601@earthlink.net> <5A47E75E594F054BAF48C5E4FC4B92AB032162380F@dbde02.ent.ti.com> <007601cb0277$afa019a0$544ff780@am.dhcp.ti.com> <20100610063621.GP32208@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44674 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab0FJPbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jun 2010 11:31:41 -0400
In-Reply-To: <20100610063621.GP32208@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: "'Gadiyar, Anand'" <gadiyar@ti.com>, "'Stephen Schwarm, CSDP'" <w3eve@earthlink.net>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, June 10, 2010 1:36 AM
> To: Madhusudhan
> Cc: 'Gadiyar, Anand'; 'Stephen Schwarm, CSDP'; linux-omap@vger.kernel.org
> Subject: Re: simple sd card performance bug fix on OMAP
> 
> * Madhusudhan <madhu.cr@ti.com> [100602 20:13]:
> >
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Gadiyar, Anand
> > > Sent: Friday, May 28, 2010 2:55 PM
> > > To: Stephen Schwarm, CSDP; linux-omap@vger.kernel.org
> > > Subject: RE: simple sd card performance bug fix on OMAP
> > >
> > > Stephen Schwarm, CSDP wrote:
> > > >
> > > > I have not had time to make a formal patch for this but I thought it
> was
> > > > significant enough just to send it out.  The problem is on omap
> systems
> > > > that use omap_hsmmc.c to run sd or mmc cards.  If the system you are
> > > > using has an 8 wire interface, it will only use a one wire interface
> to
> > > > 4 wire cards (eg, sd class 4 and sd class 6).
> > > >
> > > > In the file driver/mmc/omap_hsmmc.c in the function
> omap_hsmmc_probe:
> > > > at about line 1739 change:
> > > >
> > > >     if (mmc_slot(host).wires >= 8)
> > > >         mmc->caps |= MMC_CAP_8_BIT_DATA;
> > > >     else if (mmc_slot(host).wires >= 4)
> > > >         mmc->caps |= MMC_CAP_4_BIT_DATA;
> > > >
> > > > to:
> > > >
> > > >     if (mmc_slot(host).wires >= 8)
> > > >         mmc->caps |= MMC_CAP_8_BIT_DATA;
> > > >     if (mmc_slot(host).wires >= 4)
> > > >         mmc->caps |= w;
> > > >
> > > > just delete the word "else".  This sets the MMC_CAP_4_BIT_DATA bit
> on
> > > > interfaces that have 8 wire interfaces.
> > > >
> > > > We have seen a BIG performance improvement on our systems.
> > > >
> > >
> > > Thanks for reporting this.
> > >
> > > A similar patch was posted a while ago and is currently marked as
> > > "awaiting upstream", although it looks like it got lost again.
> > >
> > > <https://patchwork.kernel.org/patch/78713/>
> > >
> > A revised version of the same patch was posted.
> >
> > https://patchwork.kernel.org/patch/93519/
> >
> > Tony, Can you please push this?
> 
> This needs to get merged via linux-mmc list.
> 
Sure. We will repost it.

Regards,
Madhu

> Regards,
> 
> Tony

