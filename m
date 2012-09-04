From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: Without MACH_ option Early printk (DEBUG_LL)
Date: Mon, 03 Sep 2012 22:04:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1209032201451.1784@xanadu.home>
References: <5040D03B.2050304@ti.com>
 <20120831171336.GA6978@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A83EA9EC8B@DBDE01.ent.ti.com>
 <alpine.LFD.2.02.1208311422450.1784@xanadu.home>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC099@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:43203 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab2IDCEW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 22:04:22 -0400
Received: from xanadu.home ([24.201.196.149]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M9S00GJSZ39C3C0@VL-VM-MR001.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 03 Sep 2012 22:04:21 -0400 (EDT)
In-reply-to: <C8443D0743D26F4388EA172BF4E2A7A93E9DC099@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 3 Sep 2012, Mohammed, Afzal wrote:

> Hi,
> 
> On Fri, Aug 31, 2012 at 23:53:32, Nicolas Pitre wrote:
> > On Fri, 31 Aug 2012, Hiremath, Vaibhav wrote:
> > > On Fri, Aug 31, 2012 at 22:43:36, Russell King - ARM Linux wrote:
> > > > On Fri, Aug 31, 2012 at 08:24:51PM +0530, Vaibhav Hiremath wrote:
> 
> > > > > AM335X EVM (based on AM33XX device) only supports DT boot mode and
> > > > > doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
> > > > > baseport submission we had aligned that, we won't create separate EVM
> > > > > options, killing the board file all-together.
> > > > > 
> > > > > Having said that, the early printk option (DEBUG_LL) is broken, the
> > > > > auto-generated file "./include/generated/mach-types.h" still refers to
> > > > > CONFIG_MACH_AM335XEVM option,
> > > > machine types are entirely meaningless for DT based systems.
> > > > 
> > > > > Can you comment on this? Based on that I will submit the patch.
> > > > 
> > > > Pointless.  You can't use machine_is_am335xevm() when you're using DT.
> > > > 
> > > 
> > > They how do you recommend to resolve early prink issue (required during 
> > > decompression)?
> > 
> > Right now the best you can do is to have empty stubs that display 
> > nothing.
> 
> Won't having compile time selection of debug uart over machine based
> runtime detection help here ?

It certainly would.  But then your kernel won't run on anything but the 
specific machine for which the compile time UART selection was made.  As 
soon as you have more than one possible UART config for the set of 
machines you want your kernel binary to run on, you'll have to give up 
on the early output during kernel decompression.


Nicolas
