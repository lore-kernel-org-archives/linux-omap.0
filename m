From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
Date: Wed, 21 Nov 2012 05:45:45 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA778F3@DBDE01.ent.ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-4-git-send-email-anilkumar@ti.com>
 <50AB57B0.7040502@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA7701D@DBDE01.ent.ti.com>
 <50AB5AD8.7060407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51935 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab2KUFp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 00:45:59 -0500
In-Reply-To: <50AB5AD8.7060407@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Nov 20, 2012 at 15:56:32, Marc Kleine-Budde wrote:
> On 11/20/2012 11:23 AM, AnilKumar, Chimata wrote:
> > On Tue, Nov 20, 2012 at 15:43:04, Marc Kleine-Budde wrote:
> >> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> >>> Add a new address space/memory resource to d_can device tree node. D_CAN
> >>> RAM initialization is achieved through RAMINIT register which is part of
> >>> AM33XX control module address space. D_CAN RAM init or de-init should be
> >>> done by writing instance corresponding value to control module register.
> >>>
> >>> Till we have a separate control module driver to write to control module,
> >>> d_can driver will handle the register writes to control module by itself.
> >>> So a new address space to represent this control module register is added
> >>> to d_can driver.
> >>>
> >>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >>
> >> This does not apply to net-next/master:
> >>
> >> Applying: ARM: dts: AM33XX: Add memory resource to d_can node
> >> error: patch failed: arch/arm/boot/dts/am33xx.dtsi:227
> >> error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply
> >> Patch failed at 0003 ARM: dts: AM33XX: Add memory resource to d_can node
> >>
> > 
> > Marc,
> > 
> > Sorry about this DT changes are present in linux-omap.
> > 
> > Could you please take the driver changes only and ACK on remaining will
> > help.
> 
> Will do - I'm currently looking at the driver.
> 

Hi Marc,

Please ACK this patch as well.

Thanks
AnilKumar
