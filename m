From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states
 list
Date: Mon, 10 Nov 2008 07:45:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com> <20081106033327.GQ21736@atomide.com> <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com> <87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1261970785-1226328302=:23090"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53357 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbYKJOpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 09:45:05 -0500
In-Reply-To: <87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor \\(Nokia-D/Helsinki\\)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1261970785-1226328302=:23090
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jouni,

On Fri, 7 Nov 2008, H=F6gander Jouni wrote:

> What do you Paul think about patch below:

I'm okay with it, but one potential problem: won't this prevent the chip=20
from entering retention, since SGX will be set to ON?

Anyway, if you agree this is a problem, what do you think about adding a=20
powerdomain flag that indicates that the powerdomain next power state=20
should be set to OFF on initialization, and then testing that in=20
set_pwrdm_state() ?

- Paul


> From: Jouni Hogander <jouni.hogander@nokia.com>
> Date: Fri, 7 Nov 2008 16:50:51 +0200
> Subject: [PATCH] OMAP3: PM: Check that wanted state is supported by pwrdm=
 in pwrdms_setup
>=20
> Check that wanted sleep state is supported by powerdomain. If it is
> not supported, then use next highest supported state.
>=20
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index da098d2..d9959a8 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -515,6 +515,7 @@ static void __init prcm_setup_regs(void)
>  static int __init pwrdms_setup(struct powerdomain *pwrdm)
>  {
>  =09struct power_state *pwrst;
> +=09u32 next_state =3D PWRDM_POWER_RET;
> =20
>  =09if (!pwrdm->pwrsts)
>  =09=09return 0;
> @@ -523,12 +524,20 @@ static int __init pwrdms_setup(struct powerdomain *=
pwrdm)
>  =09if (!pwrst)
>  =09=09return -ENOMEM;
>  =09pwrst->pwrdm =3D pwrdm;
> -=09pwrst->next_state =3D PWRDM_POWER_RET;
>  =09list_add(&pwrst->node, &pwrst_list);
> =20
>  =09if (pwrdm_has_hdwr_sar(pwrdm))
>  =09=09pwrdm_enable_hdwr_sar(pwrdm);
> =20
> +=09while (!(pwrdm->pwrsts & (1 << next_state))) {
> +=09=09if (next_state > PWRDM_POWER_ON) {
> +=09=09=09next_state =3D pwrdm_read_next_pwrst(pwrst->pwrdm);
> +=09=09=09break;
> +=09=09}
> +=09=09next_state++;
> +=09}
> +=09pwrst->next_state =3D next_state;
> +
>  =09return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  }
> =20
> --=20
> 1.6.0.1
>=20
>=20


- Paul
--155748971-1261970785-1226328302=:23090--
