From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] modpost: Fix section warnings for ARM for many compilers
Date: Mon, 13 Feb 2012 23:26:52 +0100
Message-ID: <20120213222652.GL14173@pengutronix.de>
References: <20120213212401.GH1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120213212401.GH1426@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Anders Kaseorg <andersk@ksplice.com>, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> It turns out that many compilers don't show section warnings on ARM
> currently because handling for ARM_CALL relocs are missing from
> modpost.c.
>=20
> Based on commit c2e26114 ([ARM] 3205/1: Handle new EABI relocations w=
hen
> loading kernel modules) it seems that R_ARM_PC24, R_ARM_CALL and
> R_ARM_JUMP24 can be handled the same way.
>=20
> As modpost.c includes elf.h, we need to also consider that at least
> Debian libc6-dev is missing defines for both R_ARM_CALL and R_ARM_JUM=
P24
> in /usr/include/elf.h.
Huh, even unstable's /usr/include/elf.h doesn't have these symbols.

> So for now let's just use the numbers in modpost.c.
>=20
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Anders Kaseorg <andersk@ksplice.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> Anybody got better ideas for dealing with the missing elf.h
> defines?
Maybe:

#ifndef R_ARM_CALL
#warning "you're elf.h include is outdated"
#define R_ARM_CALL 28
#endif

Best regards
Uwe

> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1505,6 +1505,8 @@ static int addend_arm_rel(struct elf_info *elf,=
 Elf_Shdr *sechdr, Elf_Rela *r)
>  		              (elf->symtab_start + ELF_R_SYM(r->r_info));
>  		break;
>  	case R_ARM_PC24:
> +	case 28:		/* R_ARM_CALL */
> +	case 29:		/* R_ARM_JUMP24 */
>  		/* From ARM ABI: ((S + A) | T) - P */
>  		r->r_addend =3D (int)(long)(elf->hdr +
>  		              sechdr->sh_offset +

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
