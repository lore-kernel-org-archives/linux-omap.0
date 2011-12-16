From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Thu, 15 Dec 2011 20:01:54 -0600
Message-ID: <CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
	<CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51296 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922Ab1LPCB4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 21:01:56 -0500
In-Reply-To: <CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 6:39 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.c=
om> wrote:
>> +/* l4_core -> isp mmu */
>> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__isp_mmu =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_isp_mmu_hwmod,
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap3xxx_isp_mmu_addrs,
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>
> Are you sure you are not missing something like:
>
> =A0.clk =3D "cam_ick",

I believe in this case cam_ick is used as the main clock as it
supplies both functional and interface.

>
>> +/* isp mmu slave ports */
>> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] =3D {
>> + =A0 =A0 =A0 &omap3xxx_l4_core__isp_mmu,
>> +};
>> +
>> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "isp_mmu",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_mmu_hwmod_clas=
s,
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap3xxx_isp_mmu_irqs,
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "cam_ick",
>
> It's not "cam_fck"?

AFAIK cam_fck doesn't exist in the code, and CAM_L3_ICK is used as
both ick/fck according to TRM.

>
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &isp_mmu_dev_attr,
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3xxx_isp_mmu_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3xxx_isp_mmu_sl=
aves),
>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_NO_IDLEST,
>> +};
>
> Most of the stuff I see the hwmods is .main_lock =3D "foo_fck", slave
> .clk =3D "foo_ick". Maybe that explains the irq issues you get.

I see irq issues with iva hwmod because tidspbridge doesn't use iommu
API yet, so if you enable both the mmu hwmod and tidspbridge own mmu
implementation there will be some conflicts.

I didn't see isp issues though, but I didn't went more than
booting/enabling with isp mmu.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
