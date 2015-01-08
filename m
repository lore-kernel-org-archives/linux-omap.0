From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: cm-t3x: add NAND support
Date: Wed, 7 Jan 2015 16:16:48 -0800
Message-ID: <20150108001648.GQ13010@atomide.com>
References: <54A00BD6.8010507@compulab.co.il>
 <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
 <54A151F2.9010904@ti.com>
 <54A25696.80608@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48305 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbbAHAUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 19:20:34 -0500
Content-Disposition: inline
In-Reply-To: <54A25696.80608@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Roger Quadros <rogerq@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

* Dmitry Lifshitz <lifshitz@compulab.co.il> [141229 23:42]:
> On 12/29/2014 03:06 PM, Roger Quadros wrote:
> >On 28/12/14 16:30, Dmitry Lifshitz wrote:
> >>--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> >>+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> >>@@ -50,7 +50,8 @@
> >>  #include "omap-gpmc-smsc911x.dtsi"
> >>
> >>  &gpmc {
> >>-	ranges = <5 0 0x2c000000 0x01000000>;
> >>+	ranges = <5 0 0x2c000000 0x01000000>, /* CM-T3x30 SMSC9x Eth */
> >>+		 <0 0 0x00000000 0x01000000>; /* CM-T3x NAND */
> >
> >Isn't this ranges property redundant as it will anyways be overridden by the board specific dts?
> >
> 
> The ranges are specified here (and other files below) by design.
> 
> We built a tree like structure to organize DT files -
> d234e4239 "ARM: dts: sbc-t3x: refactor DT support"
> 
> It allows to inherit/override properties common for different boards.
> 
> Our customers do not have to deal with a correct GPMC ranges settings, once
> they base on omap3-cm-t3x.dts core module DT file (in case they do not
> connect additional device to the bus).
> 
> This is the point of Igor's comment to the previous patch version.

Roger, do you still have pending issues with this patch?

Regards,

Tony
