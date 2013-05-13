From: Kevin Hilman <khilman@linaro.org>
Subject: Re: omap pm : _enable_preprogram should not be __init ?
Date: Mon, 13 May 2013 10:51:09 -0700
Message-ID: <87zjvy4vle.fsf@linaro.org>
References: <CAGGh5h02PQccdY=J-X_M+kb6TXSX+igrF_hyWytm4+cY8zo3Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:62188 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab3EMRvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 May 2013 13:51:13 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4697382pbc.16
        for <linux-omap@vger.kernel.org>; Mon, 13 May 2013 10:51:12 -0700 (PDT)
In-Reply-To: <CAGGh5h02PQccdY=J-X_M+kb6TXSX+igrF_hyWytm4+cY8zo3Wg@mail.gmail.com>
	(jean-philippe francois's message of "Fri, 3 May 2013 16:39:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, s-guiriec@ti.com, paul@pwsan.com

Salut Jean-philippe,

jean-philippe francois <jp.francois@cynove.com> writes:

> Hi list,
>
> Launching program using I2C after init leads to an oops with 3.9 on a
> custom dm3730 based board.
>
> Looking at the disassembly of the _enable function in omap_hwmod.o, I
> noticed the call to _enable_preprogram was a direct branch to an
> adress in the .text section in the middle of another function. Lookin=
g
> for _enable_preprogram, it was at the right offset, but in the
> .init.text section, so I guess this is why it works fine during the
> boot, and oops once init is started
>
> I recompiled the kernel with the attached patch and the oops is gone.
> Is that the right ting to do ?

Yes, that looks like the right thing to do.=20

Could you please send a proper patch with changelog and signoff?

Thanks,

Kevin

> Jean-Philippe Fran=C3=A7ois
>
>
> Index: b/arch/arm/mach-omap2/omap_hwmod.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2066,7 +2066,7 @@
>   * do so is present in the hwmod data, then call it and pass along t=
he
>   * return value; otherwise, return 0.
>   */
> -static int __init _enable_preprogram(struct omap_hwmod *oh)
> +static int _enable_preprogram(struct omap_hwmod *oh)
>  {
>  	if (!oh->class->enable_preprogram)
>  		return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
