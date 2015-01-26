From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Mon, 26 Jan 2015 08:14:55 -0800
Message-ID: <20150126161454.GE28663@atomide.com>
References: <201501232239.55801@pali>
 <201501232336.36187@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:52047 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534AbbAZQSM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 11:18:12 -0500
Content-Disposition: inline
In-Reply-To: <201501232336.36187@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150123 14:39]:
> On Friday 23 January 2015 22:39:55 Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > when I boot zImage with appended DT n900 in qemu
> > fdt_open_into() function called from file
> > arch/arm/boot/compressed/atags_to_fdt.c (in function
> > atags_to_fdt) always returns -FDT_ERR_NOSPACE.
> >=20
> > It means that all ATAGS (including cmdline arguments) passed
> > by bootloader are ignored.
> >=20
> > On real n900 device I see that booted DT version also ignore
> > cmdline arguments from bootloader. I cannot debug decompress
> > code on real device, but I think it is same problem as in
> > qemu.
>=20
> Looks like this quick patch is fixing above problem:
>=20
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compress=
ed/head.S
> index 68be901..4a7d75b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -268,7 +268,7 @@ restart:	adr	r0, LC0
>  		 * area.  No GOT fixup has occurred yet, but none of the
>  		 * code we're about to call uses any global variable.
>  		*/
> -		add	sp, sp, #0x10000
> +		add	sp, sp, #0x20000
>  		stmfd	sp!, {r0-r3, ip, lr}
>  		mov	r0, r8
>  		mov	r1, r6
> @@ -289,7 +289,7 @@ restart:	adr	r0, LC0
>  		bleq	atags_to_fdt
> =20
>  		ldmfd	sp!, {r0-r3, ip, lr}
> -		sub	sp, sp, #0x10000
> +		sub	sp, sp, #0x20000
>  #endif
> =20
>  		mov	r8, r6			@ use the appended device tree

Nico, got any ideas about this one? This seems like a regression
somewhere..

Regards,

Tony
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
