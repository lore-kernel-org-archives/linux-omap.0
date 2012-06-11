From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned
 to PRCM modules
Date: Mon, 11 Jun 2012 11:26:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com> <1339433225-30042-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1277102898-1339435595=:5849"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52664 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab2FKR0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 13:26:36 -0400
In-Reply-To: <1339433225-30042-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1277102898-1339435595=:5849
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Jun 2012, Benoit Cousson wrote:

> The following commit (794b480a37e3d284d6ee7344d8a737ef60476ed5) was addin=
g
> the PRCM IPs data for PRCM, CM, PRCM_MPU and SCRM.
> The clkdm entry are not the correct ones and does not exist in the system=
=2E
>=20
> Replace them with the proper wkup, l4_ao and l4_cfg.

This does not match either the publicly avaiable documentation and the=20
internal NDA hardware specifications[1].

Nor does it make sense from a logical perspective.  To take an example=20
from your patch:

> @@ -2564,12 +2543,33 @@ static struct omap_hwmod_rst_info omap44xx_prm_re=
sets[] =3D {
>  static struct omap_hwmod omap44xx_prm_hwmod =3D {
>  =09.name=09=09=3D "prm",
>  =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
> -=09.clkdm_name=09=3D "prm_clkdm",
> +=09.clkdm_name=09=3D "l4_wkup_clkdm",
>  =09.mpu_irqs=09=3D omap44xx_prm_irqs,
>  =09.rst_lines=09=3D omap44xx_prm_resets,
>  =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_prm_resets),
>  };

There is no possible way that the PRM can exist in the L4_WKUP=20
clockdomain.  The L4_WKUP clockdomain must be able to go inactive for the=
=20
chip to enter idle, as we just discussed[1].  But the PRM is the=20
entity that supervises chip wakeup from off-mode, so for off-mode=20
to work, there's no way that the PRM can be clock-gated.

Frustrating :-(

> Fix as well the wrong OCP port used by the cm_core_aon. It uses the
> l4_cfg interconnect and not the l4_wkup.
>=20
> Re-order the entries by address value.

If you split this part off into a separate patch, I'll take it.


- Paul

1. Cousson, Beno=EEt.  _Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K=
=20
   sync timer_.  linux-omap@vger.kernel.org mailing list.  Available from=
=20
   http://www.spinics.net/lists/arm-kernel/msg177128.html (among others).

--155748971-1277102898-1339435595=:5849--
