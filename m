From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/5] Powerdomains: add OMAP chip type global bitfield; clean up mach-omap2/id.c
Date: Fri, 18 Apr 2008 08:48:53 +0300
Message-ID: <878wzbg1bu.fsf@trdhcp146196.ntc.nokia.com>
References: <20080410153343.801143838@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16701 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbYDRFtV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 01:49:21 -0400
In-Reply-To: <20080410153343.801143838@pwsan.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

>Add a new kind of OMAP identification, omap_chip.  omap_chip is a
>bitfield which contains one bit for each OMAP2/3 CPU type, and, on
>3430 and beyond, ES level. =20
>
>For example, the CHIP_IS_OMAP2420 bit is set in omap_type at boot on
>an OMAP2420.  On OMAP3430ES2, both CHIP_IS_OMAP3430 and
>CHIP_IS_OMAP3430ES2 bits are set.
>
>omap_chip is set in mach-omap2/id.c by _set_omap_chip().  omap_chip is
>declared static to prevent external code from accessing it directly.
>Other code can test against omap_chip via the omap_chip_is() function.

Omap chip is not set correctly in case of omap3 es2.x. You should
change your code something like this:

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 77b4f34..3523f62 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -229,6 +229,7 @@ void __init omap2_check_revision(void)
 	if (hawkeye =3D=3D 0xb7ae) {
 		system_rev =3D 0x34300000 | ((1 + rev) << 12);
 		pr_info("OMAP%04x ES2.%i\n", system_rev >> 16, rev);
+		_set_omap_chip();
 		return;
 	}
--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
