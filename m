From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 1/6] omap: add iva2 hwmod support to omap3
Date: Mon, 5 Jul 2010 00:57:48 +0300
Message-ID: <AANLkTimgR6oURGzIrRMTkTc_EvOChfvW1urD5yQ2IT8i@mail.gmail.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
	<1278022994-28476-2-git-send-email-ohad@wizery.com> <4C2D7C9B.8080003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58345 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab0GDV6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 17:58:09 -0400
Received: by wyf23 with SMTP id 23so2080311wyf.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 14:58:08 -0700 (PDT)
In-Reply-To: <4C2D7C9B.8080003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Fri, Jul 2, 2010 at 8:43 AM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> On 7/2/2010 12:23 AM, Ohad Ben-Cohen wrote:
>> From: Ohad Ben-Cohen<ohadb@ti.com>
>>
>> Add preliminary iva2 hwmod support to omap3.
>> We do not include iva2_clk; that will be part of a separate
>> hwmod, which will be controlled by iommu.
>
> I think Kevin already sent a hwmod for IVA2... one week ago:


Thanks. I somehow missed the bulk of those patches.
I will of course rebase omap3 remoteproc on top of that now.



> [PATCH 13/13] OMAP3: hwmod data: add data for OMAP3 IVA2
>
>> Signed-off-by: Ohad Ben-Cohen<ohadb@ti.com>
>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_34xx.h =A0 =A0 =A0 =A0| =A0 23 +++=
++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
>> =A02 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-o=
map2/omap_hwmod_34xx.h
>> index b6076b9..d363a95 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
>> +++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
>> @@ -22,6 +22,7 @@
>> =A0#include "prm-regbits-34xx.h"
>>
>> =A0static struct omap_hwmod omap34xx_mpu_hwmod;
>> +static struct omap_hwmod omap34xx_iva2_hwmod;
>> =A0static struct omap_hwmod omap34xx_l3_hwmod;
>> =A0static struct omap_hwmod omap34xx_l4_core_hwmod;
>> =A0static struct omap_hwmod omap34xx_l4_per_hwmod;
>> @@ -47,9 +48,17 @@ static struct omap_hwmod_ocp_if omap34xx_mpu__l3 =
=3D {
>> =A0 =A0 =A0 =A0.user =A0 =3D OCP_USER_MPU,
>> =A0};
>>
>> +/* IVA2 -> =A0L3 interface */
>> +static struct omap_hwmod_ocp_if omap34xx_iva2__l3 =3D {
>> + =A0 =A0 =A0 .master =3D&omap34xx_iva2_hwmod,
>> + =A0 =A0 =A0 .slave =A0=3D&omap34xx_l3_hwmod,
>> + =A0 =A0 =A0 .user =A0 =3D OCP_USER_IVA2,
>> +};
>> +
>> =A0/* Slave interfaces on the L3 interconnect */
>> =A0static struct omap_hwmod_ocp_if *omap34xx_l3_slaves[] =3D {
>> =A0 =A0 =A0 =A0&omap34xx_mpu__l3,
>> + =A0 =A0 =A0 &omap34xx_iva2__l3,
>> =A0};
>>
>> =A0/* Master interfaces on the L3 interconnect */
>> @@ -150,12 +159,26 @@ static struct omap_hwmod omap34xx_mpu_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
3430),
>> =A0};
>>
>> +/* Master interfaces on the IVA2 device */
>> +static struct omap_hwmod_ocp_if *omap34xx_iva2_masters[] =3D {
>> + =A0 =A0 =A0 &omap34xx_iva2__l3,
>> +};
>> +
>> +/* IVA2 */
>> +static struct omap_hwmod omap34xx_iva2_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "iva2_hwmod",
>
> Should be "iva" only.
>
>> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_iva2_masters,
>> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_iva2_maste=
rs),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
>> +};
>> +
>> =A0static __initdata struct omap_hwmod *omap34xx_hwmods[] =3D {
>> =A0 =A0 =A0 =A0&omap34xx_l3_hwmod,
>> =A0 =A0 =A0 =A0&omap34xx_l4_core_hwmod,
>> =A0 =A0 =A0 =A0&omap34xx_l4_per_hwmod,
>> =A0 =A0 =A0 =A0&omap34xx_l4_wkup_hwmod,
>> =A0 =A0 =A0 =A0&omap34xx_mpu_hwmod,
>> + =A0 =A0 =A0 &omap34xx_iva2_hwmod,
>> =A0 =A0 =A0 =A0NULL,
>> =A0};
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm=
/plat-omap/include/plat/omap_hwmod.h
>> index 3393325..5e64992 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -160,6 +160,7 @@ struct omap_hwmod_addr_space {
>> =A0 */
>> =A0#define OCP_USER_MPU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<< =A00=
)
>> =A0#define OCP_USER_SDMA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<< =A01)
>> +#define OCP_USER_IVA2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<< =A02)
>
> Are you going to use that information somewhere?
> In that case, you should populate the address space view from the DSP=
=2E
>
> Benoit
>
>>
>> =A0/* omap_hwmod_ocp_if.flags bits */
>> =A0#define OCPIF_HAS_IDLEST =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<< =A00)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
