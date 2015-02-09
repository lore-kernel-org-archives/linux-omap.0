From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: dra7xx: hwmod: drop .modulemode from pcie1/2 hwmods
Date: Mon, 9 Feb 2015 18:54:37 +0530
Message-ID: <54D8B515.201@ti.com>
References: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org> <54D874E9.1040302@ti.com> <54D88BB3.4060104@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbbBINZI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Feb 2015 08:25:08 -0500
In-Reply-To: <54D88BB3.4060104@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Hi,

On Monday 09 February 2015 03:58 PM, Grygorii.Strashko@linaro.org wrote=
:
> Hi Kishon,
> On 02/09/2015 04:50 PM, Kishon Vijay Abraham I wrote:
>> On Tuesday 03 February 2015 09:21 PM, grygorii.strashko@linaro.org w=
rote:
>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>
>>> Now DRA7xx pcie1/2 hwmods define PRCM configuration as following:
>>>    .clkctrl_offs =3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
>>>    .rstctrl_offs =3D DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
>>>    .modulemode   =3D MODULEMODE_SWCTRL,
>>> which is completely wrong because DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET
>>> is clockdomain ctrl register and NOT module ctrl register.
>>> And they have diffrent allowed values for bits[0,1]:
>>> CLKTRCTRL=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89MODULEMODE=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89
>>> 0x0:=E2=80=89NO_SLEEP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=890=
x0:=E2=80=89Module=E2=80=89is=E2=80=89disabled=E2=80=89by=E2=80=89SW.=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89
>>> 0x1:=E2=80=89SW_SLEEP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=890=
x1:=E2=80=89Module=E2=80=89is=E2=80=89managed=E2=80=89automatically=E2=80=
=89by=E2=80=89HW=E2=80=89=E2=80=89
>>> 0x2:=E2=80=89SW_WKUP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=890x2:=E2=80=89Module=E2=80=89is=E2=80=89explicitly=E2=80=89enabled=
=2E=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89
>>> 0x3:=E2=80=89HW_AUTO=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=890x3:=E2=80=89Reserved=E2=80=89=E2=80=89
>>>
>>> As result, following message can be seen during suspend:
>>>    "omap_hwmod: pcie1: _wait_target_disable failed"
>>>
>>> Fix it by removing .modulemode from pcie1/2 hwmods and, in that
>>> way, prevent clockdomain ctrl register writing from HWMOD core.
>>
>> Looks correct except for one change.
>>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>> ---
>>>
>>> More over, it looks like pcie1/2 hwmods are fake and have to be dro=
pped at all.
>>> The real HWMODs are PCIESS1/2.
>>
>> Not sure I get this. You mean "dra7xx_pcie1_hwmod" should be replace=
d with
>> "dra7xx_pciess1_hwmod"? Or you mean an entire new hwmod is missing?
>>
>> Please note we still have to enable the clock domain and main clock.=
 We've also
>> purposefully omitted sysconfig from hwmod data since pcie reset
>> (RM_PCIESS_RSTCTRL) should be done before accessing the syconfig reg=
ister and
>> the infrastructure for that is currently not present.
>=20
> What I'm trying to say is that now PM control data mixed between "pci=
eX" and "pcieX-phy" hwmods.
> After this patch "pcieX" hwmods will actually do nothing (I assume th=
at "pciex-phy" will be=20
> enabled before "pcieX"), and probably can be removed if "pcie_clkdm" =
could be attached to "pcieX-phy" hwmod
> instead.
>=20
> More over, now, "pcie_clkdm" is connected to "pcieX" hwmod while MODU=
LEMODE register is controlled
> by "pciex-phy" hwmod, so when pciess is going to be enabled the "l3in=
it_clkdm" will be waken-up by
> hwmode core and not "pcie_clkdm" - as I can remember this is not good=
 (we should alway wake-up clockdomain
>  and keep it in SWSUP mode while changing MODULEMODE and SYSC registe=
rs).
>=20
> static struct omap_hwmod dra7xx_pcie1_hwmod =3D {
> 	.name		=3D "pcie1",
> 	.class		=3D &dra7xx_pcie_hwmod_class,
> 	.clkdm_name	=3D "pcie_clkdm",
> 	.main_clk	=3D "l4_root_clk_div",
>=20
> static struct omap_hwmod dra7xx_pcie1_phy_hwmod =3D {
> 	.name		=3D "pcie1-phy",
> 	.class		=3D &dra7xx_pcie_phy_hwmod_class,
> 	.clkdm_name	=3D "l3init_clkdm",
> 	.main_clk	=3D "l4_root_clk_div",
>=20
> So, in my opinion, some rework may be needed here.=20
> Am I right?

you are right. We should have a single hwmod like dra7xx_pciess1_hwmod =
whose
clkdm should be "pcie_clkdm" and whose clkctrl_offs should be
DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET (for controlling MODULEMODE). P=
CIE PHY
shouldn't have a hwmod entry at all.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
