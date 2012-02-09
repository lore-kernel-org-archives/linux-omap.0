From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 04/16] ARM: omap: fix prm44xx.c OMAP44XX_IRQ_PRCM build
 error
Date: Thu, 9 Feb 2012 19:58:32 +0100
Message-ID: <4F341758.6080400@ti.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <E1RvAW4-0006Gy-S6@rmk-PC.arm.linux.org.uk> <20120208183951.GD29796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60481 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757966Ab2BIS6n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 13:58:43 -0500
In-Reply-To: <20120208183951.GD29796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>

Hi Tony,

On 2/8/2012 7:39 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux<linux@arm.linux.org.uk>  [120208 08:06]:
>> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undecla=
red here (not in a function)
>=20
> Can you please add something like "This happens when CONFIG_OF is
> not selected".
>=20
>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>=20
> Other than that:
>=20
> Acked-by: Tony Lindgren<tony@atomide.com>

It looks like prm2xxx_3xxx.c does have the exact same issue than prm44x=
x.c.

arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error: =91INT_34XX_PRCM_MPU_I=
RQ=92 undeclared here (not in a function)

Patch will follow.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
