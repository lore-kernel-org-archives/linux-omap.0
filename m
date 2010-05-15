From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/6] DSPBRIDGE: remember mapping and page info in
	proc_map
Date: Sat, 15 May 2010 11:34:56 +0300
Message-ID: <AANLkTilh4LfJKp7S3Xt29Noghzixtk-z3RuKzGcLC5xL@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <1272746671-13423-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49636 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0EOIe6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 May 2010 04:34:58 -0400
Received: by fxm6 with SMTP id 6so2207893fxm.19
        for <linux-omap@vger.kernel.org>; Sat, 15 May 2010 01:34:56 -0700 (PDT)
In-Reply-To: <1272746671-13423-3-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Every time the MM application calls proc_map to map
> a memory area, remember the details of that mapping,
> together with the related page structures.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> If you want, you can also reach me at < =C2=A0ohadb at ti dot com =C2=
=A0>.

> @@ -948,6 +949,7 @@ static dsp_status bridge_dev_create(OUT struct wm=
d_dev_context **ppDevContext,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D DSP=
_EMEMORY;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto func_end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D cfg_get_host_resources((struct =
cfg_devnode *)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d=
rv_get_first_dev_extension(),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&=
resources);

Completely unrelated change. Moreover, this creates conflicts on
future commits since that code is gone.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
