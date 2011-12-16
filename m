From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Fri, 16 Dec 2011 02:39:16 +0200
Message-ID: <CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51184 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759805Ab1LPAjR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 19:39:17 -0500
In-Reply-To: <1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> +/* l4_core -> isp mmu */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__isp_mmu =3D {
> + =C2=A0 =C2=A0 =C2=A0 .master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &omap3=
xxx_l4_core_hwmod,
> + =C2=A0 =C2=A0 =C2=A0 .slave =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
omap3xxx_isp_mmu_hwmod,
> + =C2=A0 =C2=A0 =C2=A0 .addr =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D o=
map3xxx_isp_mmu_addrs,
> + =C2=A0 =C2=A0 =C2=A0 .user =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D O=
CP_USER_MPU | OCP_USER_SDMA,
> +};

Are you sure you are not missing something like:

  .clk =3D "cam_ick",

> +/* isp mmu slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &omap3xxx_l4_core__isp_mmu,
> +};
> +
> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
isp_mmu",
> + =C2=A0 =C2=A0 =C2=A0 .class =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
omap3xxx_mmu_hwmod_class,
> + =C2=A0 =C2=A0 =C2=A0 .mpu_irqs =C2=A0 =C2=A0 =C2=A0 =3D omap3xxx_is=
p_mmu_irqs,
> + =C2=A0 =C2=A0 =C2=A0 .main_clk =C2=A0 =C2=A0 =C2=A0 =3D "cam_ick",

It's not "cam_fck"?

> + =C2=A0 =C2=A0 =C2=A0 .dev_attr =C2=A0 =C2=A0 =C2=A0 =3D &isp_mmu_de=
v_attr,
> + =C2=A0 =C2=A0 =C2=A0 .slaves =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap3x=
xx_isp_mmu_slaves,
> + =C2=A0 =C2=A0 =C2=A0 .slaves_cnt =C2=A0 =C2=A0 =3D ARRAY_SIZE(omap3=
xxx_isp_mmu_slaves),
> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D H=
WMOD_NO_IDLEST,
> +};

Most of the stuff I see the hwmods is .main_lock =3D "foo_fck", slave
=2Eclk =3D "foo_ick". Maybe that explains the irq issues you get.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
