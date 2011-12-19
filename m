From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Mon, 19 Dec 2011 18:11:50 +0200
Message-ID: <CAMP44s2H7v6dRPXO6eBBNrYAnym_ZLdmKcAQPmYyCC6Wo5qOmw@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
	<CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
	<CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40946 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1LSQLv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 11:11:51 -0500
In-Reply-To: <CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 16, 2011 at 4:01 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> On Thu, Dec 15, 2011 at 6:39 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Are you sure you are not missing something like:
>>
>> =C2=A0.clk =3D "cam_ick",
>
> I believe in this case cam_ick is used as the main clock as it
> supplies both functional and interface.

Are you sure?

>>> +/* isp mmu slave ports */
>>> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 &omap3xxx_l4_core__isp_mmu,
>>> +};
>>> +
>>> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 "isp_mmu",
>>> + =C2=A0 =C2=A0 =C2=A0 .class =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &omap3xxx_mmu_hwmod_class,
>>> + =C2=A0 =C2=A0 =C2=A0 .mpu_irqs =C2=A0 =C2=A0 =C2=A0 =3D omap3xxx_=
isp_mmu_irqs,
>>> + =C2=A0 =C2=A0 =C2=A0 .main_clk =C2=A0 =C2=A0 =C2=A0 =3D "cam_ick"=
,
>>
>> It's not "cam_fck"?
>
> AFAIK cam_fck doesn't exist in the code, and CAM_L3_ICK is used as
> both ick/fck according to TRM.

Then maybe the code is wrong.

Look at the OMAP34xx documentation, it says that:

CAM_L3_ICLK -> CAM_FCLK
CAM_L4_ICLK -> CAM_ICLK
CAM_MCLK -> CAM_MCLK
CSI2_96M_FCLK -> CSI2_96M_FCLK

CAM_FCLK
=46unctional clock (L3 interconnect clock domain)
=46unctional clock domain.

CAM_ICLK
Interface clock (L4 interconnect clock domain)
Interface clock domain.

Maybe something like this:

--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2225,8 +2225,17 @@ static struct clk cam_mclk =3D {
        .recalc         =3D &followparent_recalc,
 };

+static struct clk cam_fck =3D {
+       .name           =3D "cam_fck",
+       .ops            =3D &clkops_omap2_dflt,
+       .parent         =3D &l3_ick,
+       .enable_reg     =3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN=
),
+       .enable_bit     =3D OMAP3430_EN_CAM_SHIFT,
+       .clkdm_name     =3D "cam_clkdm",
+       .recalc         =3D &followparent_recalc,
+};
+
 static struct clk cam_ick =3D {
-       /* Handles both L3 and L4 clocks */
        .name           =3D "cam_ick",
        .ops            =3D &clkops_omap2_iclk_dflt,
        .parent         =3D &l4_ick,
@@ -3364,6 +3373,7 @@ static struct omap_clk omap3xxx_clks[] =3D {
        CLK("omapdss_dss",      "ick",          &dss_ick_3430es1,
 CK_3430ES1),
        CLK("omapdss_dss",      "ick",          &dss_ick_3430es2,
 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
        CLK(NULL,       "cam_mclk",     &cam_mclk,      CK_34XX | CK_36=
XX),
+       CLK(NULL,       "cam_fck",      &cam_fck,       CK_34XX | CK_36=
XX),
        CLK(NULL,       "cam_ick",      &cam_ick,       CK_34XX | CK_36=
XX),
        CLK(NULL,       "csi2_96m_fck", &csi2_96m_fck,  CK_34XX | CK_36=
XX),
        CLK(NULL,       "usbhost_120m_fck", &usbhost_120m_fck,
CK_3430ES2PLUS | CK_AM35XX | CK_36XX),

Also, I find this chunk peculiar in drivers/media/video/omap3isp/isp.c:

static const char *isp_clocks[] =3D {
	"cam_ick",
	"cam_mclk",
	"dpll4_m5_ck",
	"csi2_96m_fck",
	"l3_ick",
};

Looks like the driver is manually calling clk_get() and clk_put() for
the "i3_ick", where I guess the clock framework is supposed to do
that... It's almost as if somebody forgot a dependency somewhere.

>>> + =C2=A0 =C2=A0 =C2=A0 .dev_attr =C2=A0 =C2=A0 =C2=A0 =3D &isp_mmu_=
dev_attr,
>>> + =C2=A0 =C2=A0 =C2=A0 .slaves =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap=
3xxx_isp_mmu_slaves,
>>> + =C2=A0 =C2=A0 =C2=A0 .slaves_cnt =C2=A0 =C2=A0 =3D ARRAY_SIZE(oma=
p3xxx_isp_mmu_slaves),
>>> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 HWMOD_NO_IDLEST,
>>> +};
>>
>> Most of the stuff I see the hwmods is .main_lock =3D "foo_fck", slav=
e
>> .clk =3D "foo_ick". Maybe that explains the irq issues you get.
>
> I see irq issues with iva hwmod because tidspbridge doesn't use iommu
> API yet, so if you enable both the mmu hwmod and tidspbridge own mmu
> implementation there will be some conflicts.
>
> I didn't see isp issues though, but I didn't went more than
> booting/enabling with isp mmu.

This is what you said:
Removed clk handling during interrupt, given that in order to receive o=
ne,
the device should be powered on in advance.

I'm not sure how this clock stuff works, but I'm guessing the device
is supposed to go to sleep at some points in time, and with your patch
"OMAP3/4: iommu: adapt to runtime pm" it won't, as long as the module
is loaded, unless I'm missing something.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
