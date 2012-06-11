From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 02:04:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206110154170.16974@utopia.booyaka.com>
References: <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi> <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
 <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com> <4FD1FA8C.1080600@ti.com> <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com> <20120611061546.GQ12766@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35163 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab2FKIEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 04:04:24 -0400
In-Reply-To: <20120611061546.GQ12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Sun, 10 Jun 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120608 06:33]:
>  
> > I don't really have a huge problem with switching to a late reset, 
> > but there are disadvantages to it.
> 
> I think the early reset actually has more disadvantages to it compared
> to driver reset. We don't see any errors when things go wrong, and we
> may even kill the only debug console in the reset process.
> 
> We are already doing what Benoit describes with clocks where we only
> reset the unclaimed ones at late_initcall level, and that has proven
> to work well.

The difference though between the clock and the IP block init is that 
leaving the clocks on until later has no effect on system stability.  The 
chip simply consumes more energy.

But if the IP blocks are reset later, and the bootloader or previous OS 
gets some register settings wrong, there's a greater risk of system 
instability or unpredictable behavior during the boot process.

I agree that it is probably easier to debug a late reset approach.


- Paul
