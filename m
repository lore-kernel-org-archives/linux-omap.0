From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ASoC: Fix wrong include for McPDM
Date: Thu, 04 Oct 2012 11:03:42 +0300
Message-ID: <506D42DE.7000205@ti.com>
References: <20121003165213.GC4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:38678 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932089Ab2JDIC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 04:02:27 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so181224obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 01:02:25 -0700 (PDT)
In-Reply-To: <20121003165213.GC4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org

Hi Tony,

On 10/03/2012 07:52 PM, Tony Lindgren wrote:
> McPDM needs platt/cpu.h for omap_rev and not omap_hwmod.h.
> Drivers must not include omap_hwmod.h at, it will be
> private to mach-omap2 soon. Fix the problem before other
> drivers will also start including omap_hwmod.h.
>=20
> Note that also plat/cpu.h will be going away, so the
> omap_rev check needs to be replaced with mcpdm-watchdog
> flag from platform_data or DT.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> Can you guys please queue this as fix for -rc1?
>=20
> This removes and unnecessary dependency for making
> omap_hwmod.h local to mach-omap2.
>=20
> Then I'm hoping Peter will remove the plat/cpu.h
> dependency for v3.8 merge window ;)

I can remove it for 3.7 as well since there is no need for the revision=
 check
at all.
Will send the omap-mcpdm update series for 3.7 in couple of minutes (in=
cluding
this patch).

>=20
> --- a/sound/soc/omap/omap-mcpdm.c
> +++ b/sound/soc/omap/omap-mcpdm.c
> @@ -40,7 +40,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> =20
> -#include <plat/omap_hwmod.h>
> +#include <plat/cpu.h>
>  #include "omap-mcpdm.h"
>  #include "omap-pcm.h"
> =20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
