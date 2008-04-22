From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 09:57:43 -0700
Message-ID: <200804220957.43599.david-b@pacbell.net>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:28585 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755372AbYDVQ5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2008 12:57:46 -0400
In-Reply-To: <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

On Tuesday 22 April 2008, Koen Kooi wrote:
> --- a/include/asm-arm/arch-omap/board-omap3beagle.h
> +++ b/include/asm-arm/arch-omap/board-omap3beagle.h
> @@ -29,6 +29,8 @@
> =A0 #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
> =A0 #define __ASM_ARCH_OMAP3_BEAGLE_H
>=20
> +extern void __init sdp_mmc_init(void);
> +
> =A0 #ifdef CONFIG_TWL4030_CORE
>=20
> =A0 #define TWL4030_IRQNUM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0INT_34XX_SYS_NIRQ

That's really not the right place to declare shared
routines.  Plus of course, since that routine isn't
specific to SDP boards it shouldn't use that name...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
