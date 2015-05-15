From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
Date: Fri, 15 May 2015 22:12:41 +0200
Message-ID: <3513646.XX80DTTJbc@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <1431719407-18230-1-git-send-email-pali.rohar@gmail.com> <1431719407-18230-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52446 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913AbbEOUNT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2015 16:13:19 -0400
In-Reply-To: <1431719407-18230-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 15 May 2015 21:50:07 Pali Roh=E1r wrote:
>                 }
>         }
> =20
> +       /* include the terminating ATAG_NONE */
> +       atag_size =3D (char *)atag - (char *)atag_list + sizeof(struc=
t tag_header);
> +       setprop(fdt, "/", "atags", atag_list, atag_size);
> +
>         if (memcount) {
>                 setprop(fdt, "/memory", "reg", mem_reg_property,
>                         4 * memcount * memsize);
>=20

The property should probably have a DT binding, and be named "linux,ata=
gs".

It may also help to check if the "linux,atags" property already exists =
and not
create it otherwise. That way we can put it into the n900 dts file and =
have
it updated by the compat code, but not expose the atags on other platfo=
rms
unless they opt in.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
