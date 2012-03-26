From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Mon, 26 Mar 2012 06:03:21 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BAF9E@DBDE01.ent.ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
 <4F6C445A.3040103@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317A6A83@DBDE01.ent.ti.com>
 <4F6C9929.6030704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab2CZGD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Mar 2012 02:03:28 -0400
In-Reply-To: <4F6C9929.6030704@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Balbi, Felipe" <balbi@ti.com>

Hi Benoit,

On Fri, Mar 23, 2012 at 21:09:21, Cousson, Benoit wrote:
> But EMIF does not have anything to do in MFD either :-)
> 
> What was the feedback for this series?
> 
> We discussed that at Linaro connect, but it looks like MFD is becoming 
> the place for miscellaneous drivers that we do not know where to put.
> 
> Maybe we should introduce a driver/memory/ directory for memory 
> controller. At least for EMIF.
> In the case of GMPC, it is slightly different because it can handle 
> NOR/NAND memory but as well behave like an ISA bus controller for 
> Ethernet ISA chip.
> But since it can control several devices thanks the chipselects lines it 
> has, it behaves like a multi-protocol bus controller.
> But in anycase, it does not look like an MFD for my point of view. For 
> me a MFD is like a small soc, it does contain several completely 
> unrelated block (Power, Audio, GPIO...), but does share some memory 
> space / IRQ lines.
> 
> Is this the only controller doing that kind of stuff in the kernel so far?

An additional intention of sending RFC early was to find out whether selection
of MFD was acceptable. Coding so far has been done so that it can easily move
to MFD or other types.

Frankly I had not done much research on where GPMC driver should belong,
my thought was first convert it into a driver (but vaguely in mind it may have
to go to MFD), later decide on where it should go. Probably task of finding
correct place for GPMC driver should happen in parallel with driver conversion.

For davinci EMIF, afaik, no conclusion has been reached yet.

I will try to find whether there is anything similar already in Kernel,
and find out a suitable place for GPMC driver.

> > If an initial patch just to rearrange the code to have similar section
> > together&  then new changes in a another patch, would that be fine?
> 
> Well, if this is just comestic, I will even do that after the driver 
> conversion. Because if you do that before you will move some piece of 
> code that you might completely delete later. So you should fix the code 
> first and then potentially, move some part if that will improve the 
> readability.

Ok

Regards
Afzal
