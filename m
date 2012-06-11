From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 10:20:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206111011230.5849@utopia.booyaka.com>
References: <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi> <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
 <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com> <4FD1FA8C.1080600@ti.com> <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com> <20120611061546.GQ12766@atomide.com> <alpine.DEB.2.00.1206110154170.16974@utopia.booyaka.com>
 <4FD5B951.7010607@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46607 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab2FKQUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 12:20:03 -0400
In-Reply-To: <4FD5B951.7010607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Mon, 11 Jun 2012, Cousson, Benoit wrote:

> On 6/11/2012 10:04 AM, Paul Walmsley wrote:
> 
> > But if the IP blocks are reset later, and the bootloader or previous OS
> > gets some register settings wrong, there's a greater risk of system
> > instability or unpredictable behavior during the boot process.
> 
> Mmm, I'm not convince by that. If we delay the PM init at the very last 
> time, at least after the modules are properly reset and init, I do not 
> think we will have more issues than today.

My intent was not to convince, but to explain.

Certainly back in the OMAP3 days there were bootloaders that got SDRAM and 
GPMC timings wrong.  No way did I want to be chasing down kernel "bugs" 
based on those.

Anyway, once people finish fixing the drivers, then we should be able to 
switch to late hwmod reset.


- Paul
