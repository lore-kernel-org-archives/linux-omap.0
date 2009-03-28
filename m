From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP2 build errors
Date: Sat, 28 Mar 2009 12:48:23 +0000
Message-ID: <20090328124823.GB4550@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36138 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbZC1Msb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Mar 2009 08:48:31 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

The result of building an OMAP2 configuration for merged mainline, mast=
er
and devel branches is:

  CC      arch/arm/mach-omap2/devices.o
arch/arm/mach-omap2/devices.c:160: error: =E2=96=A0OMAP34XX_MAILBOX_BAS=
E=E2=96=A0 undeclared here (not in a function)

Please resolve ASAP - if I don't have a patch by this evening, I will
commit the work-around below:

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c
index d6b4b2f..d16d880 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -156,6 +156,7 @@ static struct resource omap2_mbox_resources[] =3D {
 };
=20
 static struct resource omap3_mbox_resources[] =3D {
+#ifdef CONFIG_ARCH_OMAP3
 	{
 		.start		=3D OMAP34XX_MAILBOX_BASE,
 		.end		=3D OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -165,6 +166,7 @@ static struct resource omap3_mbox_resources[] =3D {
 		.start		=3D INT_24XX_MAIL_U0_MPU,
 		.flags		=3D IORESOURCE_IRQ,
 	},
+#endif
 };
=20
 static struct platform_device mbox_device =3D {

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
