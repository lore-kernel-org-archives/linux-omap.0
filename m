From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] ARM: dts: dra72-evm: NAND and USB support
Date: Mon, 10 Nov 2014 12:26:07 -0800
Message-ID: <20141110202606.GS31454@atomide.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
 <54524CD5.5060103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38287 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKJU0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 15:26:52 -0500
Content-Disposition: inline
In-Reply-To: <54524CD5.5060103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, nsekhar@ti.com, george.cherian@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Roger Quadros <rogerq@ti.com> [141030 07:37]:
> Hi Tony,
> 
> On 10/21/2014 01:41 PM, Roger Quadros wrote:
> > Hi Tony,
> > 
> > These patches add NAND and USB support for DRA72-evm.
> > Patches are for v3.19 and based on v3.18-rc1.
> > 
> > I've tested that NAND and USB host works fine on DRA72-evm.
> > 
> > I couldn't get USB gadget mode to work. It doesn't work on DRA7-evm either.
> > There seems to be some issue at the driver level. The dts entries are correct though.
> 
> Any further comments on this? Can we please queue this for -next? Thanks.

Applying into omap-for-v3.19/dt thanks.

Tony

 
> > cheers,
> > -roger
> > 
> > George Cherian (1):
> >   ARM: dts: dra72-evm: Enable USB support for dra72-evm.
> > 
> > Roger Quadros (3):
> >   ARM: dts: dra72-evm: Add NAND support
> >   ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi
> >   ARM: dts: dra72-evm: Add regulator information to USB2 PHYs
> > 
> >  arch/arm/boot/dts/dra7.dtsi     |  20 ------
> >  arch/arm/boot/dts/dra72-evm.dts | 147 ++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/dra74x.dtsi   |  22 ++++++
> >  3 files changed, 169 insertions(+), 20 deletions(-)
> > 
> 
