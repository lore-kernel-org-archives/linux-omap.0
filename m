From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
Date: Wed, 20 Feb 2013 17:38:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <20130215064429.GA30038@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38001 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758878Ab3BTRiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 12:38:50 -0500
In-Reply-To: <20130215064429.GA30038@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

I think Vaibhav has covered most of the ground here, but just a few 
comments:

On Fri, 15 Feb 2013, Felipe Balbi wrote:

> On Thu, Feb 14, 2013 at 08:47:53PM +0000, Paul Walmsley wrote:
>
> > Drivers shouldn't touch their IP block's SYSCONFIG registers.  They don't 
> 
> why not ? It's part of the driver's address space anyway. It's not part
> of the IP in question (usb, ethernet, etc) but it's part of the TI
> wrapper which usually involves a bridge (ocp2scp, ocp2axi, etc) plus the
> TI-specific integration registers (revision, sysc, syss...).
> 
> So they're not part of the licensed IP, but they're part of the TI
> wrapper around those.

Ideally Linux drivers would be as independent as possible from their SoC- 
or board-specific integration.  This includes bus integration, etc.  That 
way, an IP block like UART, where most or all of the registers are shared 
with the common 8250 code, might be able to use a shared driver.

Also, it should be noted that the TI wrapper isn't necessarily common to 
all TI SoCs :-)  The wrapper bits and functions can change from TI SoC to 
SoC.

> > have anything specifically to do with the underlying device IP block, but 
> 
> of course they do, soft reset touches the underlying IP, so does force
> idle, no idle, etc. 

Force idle, no idle, etc. only affects what's reported to the PRCM via 
the SIdleAck/MStandbyReq lines.  It shouldn't affect anything in the IP 
block itself.

As far as reset goes, the chip-wide reset bits affect the IP block too, 
but we wouldn't put that code into the drivers :-)


- Paul
