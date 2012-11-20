From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
Date: Tue, 20 Nov 2012 10:23:57 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA7701D@DBDE01.ent.ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-4-git-send-email-anilkumar@ti.com>
 <50AB57B0.7040502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50AB57B0.7040502@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 20, 2012 at 15:43:04, Marc Kleine-Budde wrote:
> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> > Add a new address space/memory resource to d_can device tree node. D_CAN
> > RAM initialization is achieved through RAMINIT register which is part of
> > AM33XX control module address space. D_CAN RAM init or de-init should be
> > done by writing instance corresponding value to control module register.
> > 
> > Till we have a separate control module driver to write to control module,
> > d_can driver will handle the register writes to control module by itself.
> > So a new address space to represent this control module register is added
> > to d_can driver.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> This does not apply to net-next/master:
> 
> Applying: ARM: dts: AM33XX: Add memory resource to d_can node
> error: patch failed: arch/arm/boot/dts/am33xx.dtsi:227
> error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply
> Patch failed at 0003 ARM: dts: AM33XX: Add memory resource to d_can node
> 

Marc,

Sorry about this DT changes are present in linux-omap.

Could you please take the driver changes only and ACK on remaining will
help.

Tony/Benoit,

Could you please take dt patches in this series to linux-omap?

Thanks
AnilKumar
