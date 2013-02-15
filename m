From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 07:27:00 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED1F472@DBDE01.ent.ti.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215064429.GA30038@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45602 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935388Ab3BOH1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 02:27:09 -0500
In-Reply-To: <20130215064429.GA30038@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, Feb 15, 2013 at 12:14:29, Balbi, Felipe wrote:
> Hi,
> 
> On Thu, Feb 14, 2013 at 08:47:53PM +0000, Paul Walmsley wrote:
> > Hi,
> > 
> > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > 
> > > I don't think so as hwmod should only touch the sysconfig space
> > > when no driver has claimed it.
> > 
> > hwmod does need to touch the SYSCONFIG register during pm_runtime suspend 
> > and resume operations, and during device enable and disable operations.  
> > Here's the relevant code:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2157
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2195
> > 
> > Drivers shouldn't touch their IP block's SYSCONFIG registers.  They don't 
> 
> why not ? It's part of the driver's address space anyway. It's not part
> of the IP in question (usb, ethernet, etc) but it's part of the TI
> wrapper which usually involves a bridge (ocp2scp, ocp2axi, etc) plus the
> TI-specific integration registers (revision, sysc, syss...).
> 
> So they're not part of the licensed IP, but they're part of the TI
> wrapper around those.
> 

That's all the more reason to not allow the drivers to touch the SYSCONFIG register.
We have IPs like EDMA, PWMSS, McASP etc which are common to Davinci and OMAP.
The integration approach was different in the past and now if we want the same
driver to work on both the platforms we have to keep the code for taking care
of the integration details out of the drivers.

IMO omap_hwmod does an excellent job of taking care of all or rather most of
the IP integration idiosyncrasies. I really don't understand why people make
a big fuss about hwmod. With the right SoC data things just work. Most of the
driver authors don't take the pains to understand how the SoC PM gets impacted
by toggling a few bits in SYSCONFIG and hence it's best to abstract away all
the critical pieces out of drivers.

For specific cases like custom reset handling I think it make much more sense to
extend runtime PM that already build upon the hwmod code for OMAP. The drivers
shouldn't have to worry about the integration details. Trying to shove a common
piece of code into all the drivers is equivalent to taking a huge step backwards
in the ongoing consolidation not just across OMAP and AMxx parts but also across
Davinci and OMAP.
 
Regards,
Vaibhav
