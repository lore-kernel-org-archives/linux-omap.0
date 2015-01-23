From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Sat, 24 Jan 2015 00:48:55 +0100
Message-ID: <20150123234855.GB27111@amd>
References: <201501232239.55801@pali>
 <201501232336.36187@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201501232336.36187@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Fri 2015-01-23 23:36:36, Pali Roh=E1r wrote:
> On Friday 23 January 2015 22:39:55 Pali Roh=E1r wrote:
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

So... something overruns stack, and bigger stack fixes it...?

							Pavel

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
>=20
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
