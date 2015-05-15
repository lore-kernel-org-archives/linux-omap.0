From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] arm: devtree: Save atags if are in DT atags field
Date: Fri, 15 May 2015 22:09:28 +0200
Message-ID: <2802980.ITgIdpK9OB@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <1431719407-18230-1-git-send-email-pali.rohar@gmail.com> <1431719407-18230-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431719407-18230-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 15 May 2015 21:50:06 Pali Roh=E1r wrote:
> @@ -256,5 +257,10 @@ const struct machine_desc * __init setup_machine=
_fdt(unsigned int dt_phys)
>                         system_rev =3D 0;
>         }
> =20
> +       /* Save atags */
> +       prop =3D of_get_flat_dt_prop(dt_root, "atags", NULL);
> +       if (prop)
> +               save_atags((void *)prop);
> +
>         return mdesc;
>=20

How about checking whether this is actually running on the one board
that needs it first?

I'd rather not introduce something that may end up being considered
an ABI on other machines.

	Arnd
