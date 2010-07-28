From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/5] staging:ti dspbridge: replace simple_strtoul by
	strict_strtoul
Date: Wed, 28 Jul 2010 21:43:54 +0300
Message-ID: <AANLkTin-2_JC0-18QWAdo9r36Jx0QdnDwnB2+2AdePyc@mail.gmail.com>
References: <1280328052-31292-1-git-send-email-ernesto@ti.com>
	<1280328052-31292-2-git-send-email-ernesto@ti.com>
	<1280328052-31292-3-git-send-email-ernesto@ti.com>
	<1280328052-31292-4-git-send-email-ernesto@ti.com>
	<1280328052-31292-5-git-send-email-ernesto@ti.com>
	<1280328052-31292-6-git-send-email-ernesto@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50734 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0G1Sn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 14:43:56 -0400
In-Reply-To: <1280328052-31292-6-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ernesto Ramos <ernesto@ti.com>
Cc: gregkh@suse.de, omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, nm@ti.com, linux-omap@vger.kernel.org

On Wed, Jul 28, 2010 at 5:40 PM, Ernesto Ramos <ernesto@ti.com> wrote:
> Replace simple_strtoul by strict_strtoul in atoi function.
In general the question what is the purpose here to do the change?

> @@ -1023,7 +1025,9 @@ static s32 atoi(char *psz_buf)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D 16;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 return simple_strtoul(pch, NULL, base);
> + =C2=A0 =C2=A0 =C2=A0 ret_val =3D strict_strtoul(pch, base, &res);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret_val ? : res;
May be better to use explicit values in condition?

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
