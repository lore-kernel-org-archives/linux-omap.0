From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] regulator: core: if voltage scaling fails, restore
 original
Date: Thu, 13 Dec 2012 05:06:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212130501260.25415@utopia.booyaka.com>
References: <1355312753-16514-1-git-send-email-paolo.pisati@canonical.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-14364122-1355375188=:25415"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355312753-16514-1-git-send-email-paolo.pisati@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Pisati <paolo.pisati@canonical.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-14364122-1355375188=:25415
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Dec 2012, Paolo Pisati wrote:

> but inside regulator_set_voltage(), we save the new regulator voltage bef=
ore
> actually ramping up:
>=20
> core.c::regulator_set_voltage():
> =09...
>     regulator->min_uV =3D min_uV;
>     regulator->max_uV =3D max_uV;
>=20
>     ret =3D regulator_check_consumers(rdev, &min_uV, &max_uV);
>     if (ret < 0)
>         goto out2;
>=20
>     ret =3D _regulator_do_set_voltage(rdev, min_uV, max_uV);  <-- ERROR!!=
!
>     if (ret < 0)
>         goto out2;
> =09...

I'm not too familiar with this code.  But isn't this where the bug is,=20
rather than in that optimization commit you mentioned?  Seems to me,=20
na=EFvely, that in the above code, regulator->min_uV and regulator->max_uV=
=20
should be set only after _regulator_do_set_voltage() succeeds?


- Paul
--843723315-14364122-1355375188=:25415--
