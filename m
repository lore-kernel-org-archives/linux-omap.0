From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for
 3.5-rc
Date: Fri, 8 Jun 2012 19:15:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206081907200.23401@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <1339162255.2091.56.camel@sokoban>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1353440614-1339204508=:23401"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42777 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab2FIBPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 21:15:09 -0400
In-Reply-To: <1339162255.2091.56.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1353440614-1339204508=:23401
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tero,

On Fri, 8 Jun 2012, Tero Kristo wrote:

> Tested this set on top of v3.5-rc1 with omap3 / omap4 suspend + my omap4
> core retention / dev-off patches. There are a couple of minor issues,
> like the bug in patch 5, and the fact that counter_32k hwmod data is
> broken for omap4. This fix is needed on omap4 to fix the counter_32k, if
> this is not done, device off does not work:
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 66da92d..6ad64c6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -397,8 +397,7 @@ static struct omap_hwmod_class_sysconfig
> omap44xx_counter_sysc =3D {
>  =09.rev_offs=09=3D 0x0000,
>  =09.sysc_offs=09=3D 0x0004,
>  =09.sysc_flags=09=3D SYSC_HAS_SIDLEMODE,
> -=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -=09=09=09   SIDLE_SMART_WKUP),
> +=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO),
>  =09.sysc_fields=09=3D &omap_hwmod_sysc_type1,
>  };

Thanks, Beno=C3=AEt mentioned this too.  Just added a patch for this to the=
=20
second version of this fixes series.


- Paul
--155748971-1353440614-1339204508=:23401--
