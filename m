From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 0/3] can: Add D_CAN raminit support to am335x-evm
Date: Wed, 9 Jan 2013 12:20:00 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAE677A@DBDE01.ent.ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <50ED5FA5.9020305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60077 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757506Ab3AIMUW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 07:20:22 -0500
In-Reply-To: <50ED5FA5.9020305@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Jan 09, 2013 at 17:46:37, Cousson, Benoit wrote:
> Hi Anil,
> 
> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> > This patch series adds d_can raminit support to c_can/d_can driver,
> > which is required to init/de-init D_CAN message RAM (holds message
> > objects). Added corresponding DT changes to get resource of RAMINIT
> > register and device instance.
> > 
> > These patches were tested on AM335x-EVM along with pinctrl data addition
> > patch, which is not added to am335x-evm.dts (only supports CPLD profile#0)
> > because d_can1 is supported under CPLD profile#1.
> > 
> > AnilKumar Ch (3):
> >   can: c_can: Add d_can raminit support
> >   ARM: dts: AM33XX: Add d_can instances to aliases
> >   ARM: dts: AM33XX: Add memory resource to d_can node
> 
> I've just applied both DTS patches with Acked-by from Marc in my
> for_3.9/dts branch.
> 
Hi Benoit,

Thanks much

Thanks
AnilKumar
