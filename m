From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP3 kernels fail to build
Date: Tue, 9 Aug 2011 14:17:07 +0300
Message-ID: <39807124.qlKmXN27Pu@barack>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39872 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab1HILRW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 07:17:22 -0400
In-Reply-To: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Russel,

On Monday 08 August 2011 13:00:56 Russell King - ARM Linux wrote:
> With CONFIG_ARCH_OMAP3=3Dy and CONFIG_ARCH_OMAP4=3Dn, I'm getting thi=
s:
>=20
> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to
> `omap4430_phy_init' arch/arm/mach-omap2/built-in.o:(.data+0xf9a0):
> undefined reference to `omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to
> `omap4430_phy_power' arch/arm/mach-omap2/built-in.o:(.data+0xf9a8):
> undefined reference to `omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to
> `omap4430_phy_suspend'
>
> This is probably from twl-common.c, which doesn't really look very
> common to me (looks like some is specific to OMAP3 and the rest is
> OMAP4 specific.)
>=20
> As this is always built for all OMAP2+, this will also break OMAP2 as
> well.  Why it's even built on OMAP2, I've no idea.

I'm sure if you have it other way around (OMAP4=3Dy, OMAP3=3Dn) will fa=
il as well,=20
but differently...

> I think the OMAP3 specific bits should be separate from the OMAP4
> specific bits, which should be separate from the small amount of
> common stuff.

Is it acceptable if I use
#if defined(CONFIG_ARCH_OMAP3), and
#if defined(CONFIG_ARCH_OMAP4)

to protect the OMAP3 and OMAP4 related code in the twl-common.c?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
