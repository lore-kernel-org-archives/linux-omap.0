From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Patches merged to split OMAP2_IO_ADDRESS
Date: Fri, 9 Oct 2009 10:50:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB13D5F2@dbde02.ent.ti.com>
References: <20091008002506.GF29320@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB13D268@dbde02.ent.ti.com>
 <20091008180801.GI7417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZJIFVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 01:21:39 -0400
In-Reply-To: <20091008180801.GI7417@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, October 08, 2009 11:38 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: Patches merged to split OMAP2_IO_ADDRESS
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [091008 03:59]:
> > Tony,
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Thursday, October 08, 2009 5:55 AM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Paul Walmsley
> > > Subject: Patches merged to split OMAP2_IO_ADDRESS
> > >
> > > Hi all,
> > >
> > > I've pushed Santosh' patches to split OMAP2_IO_ADDRESS into
> > > *_L3_IO_ADDRESS
> > > and *_L4_IO_ADDRESS so we can claim more kernel address space and
> support
> > > over 512MB of memory instead of 256MB.
> > >
> > > Of course, our goal is to convert everything except the .S files to
> > > use ioremap() instead, but that can now be done parallel and in
> smaller
> > > chunks.
> > >
> > > Please everybody, please convert your code to use ioremap(), there are
> > > static mappings already in place so it should work out of the box.
> > >
> > > I also had add two quick patches to keep things compiling,
> > > Paul can you take a look at them? I could not really test them as all
> > > the code is not there yet. Will post them as a reply to this thread.
> > Thanks for the merge!!
> >
> > I have boot tested below platforms with latest LO master.
> >
> > 1. OMAP3430 SDP board - BOOT OK
> > 2. OMAP3 BEAGLE 	- BOOT OK
> > 3. OMAP 4430 SDP - BOOT OK with variation of patch:
> http://patchwork.kernel.org/patch/50531/
> 
> Great. I guess we still have some issues on 24xx with the hwmod,
> but hopefully we'll get that working again soon.
> 
> Can somebody with 512MB memory on a board try the current l-o master
> and make sure things work?
> 
> Please check the dmesg for no overlaps in virtual address space,
> then run some memory test like memtester.

Boot tested on OMAP4430 with 512MB and dmesg don't show any overlaps. Will run some memory test tomorrow.

Regrads
Santosh
