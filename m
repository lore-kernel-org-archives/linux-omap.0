From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Wed, 06 May 2015 11:31:15 +0200
Message-ID: <3577431.y872Foi4kj@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <1430902142-17035-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430902142-17035-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 May 2015 10:49:01 Pali Roh=E1r wrote:
> With this patch "revision" DT string entry is used to set global syst=
em_rev
> variable. DT "revision" is expected to be string with one hexadecimal=
 number.
> So "Revision" line in /proc/cpuinfo will be same as "revision" DT val=
ue.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

+devicetree mailing list

The property needs to be specified in a binding somewhere.

> @@ -246,5 +247,14 @@ const struct machine_desc * __init setup_machine=
_fdt(unsigned int dt_phys)
>  	/* Change machine number to match the mdesc we're using */
>  	__machine_arch_type =3D mdesc->nr;
> =20
> +	/* Set system revision from DT */
> +	prop =3D of_get_flat_dt_prop(dt_root, "revision", &size);
> +	if (prop && size > 0) {
> +		char revision[11];
> +		strlcpy(revision, prop, min(size, (int)sizeof(revision)));
> +		if (kstrtouint(revision, 16, &system_rev) !=3D 0)
> +			system_rev =3D 0;
> +	}
> +
>  	return mdesc;
>  }
>=20

What is the reason for doing it this early? I think it would be nicer t=
o do
it after unflattening the DT.

Also, it seems strange to have a string property and then use kstrtouin=
t
to convert it into a number. I think it should either be specified in a=
 DT
binding to be a string and then have the kernel not assume that it is a=
 number,
or we should define it to be binary.

	Arnd
