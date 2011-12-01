From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 04/11] OMAP4: hwmod: Include CSI2A and CSIPHY1 memory sections
Date: Thu, 1 Dec 2011 07:17:25 -0600
Message-ID: <CAKnK67TrzD1hoKOOaodRK=-Ct5bNYAtXab3hY4UdxJTNdD0Tuw@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
 <1322698500-29924-5-git-send-email-saaguirre@ti.com> <79CD15C6BA57404B839C016229A409A8046FCD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:55854 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753749Ab1LANRs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 08:17:48 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8046FCD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>

Hi Vaibhav,

Thanks for the comments.

On Thu, Dec 1, 2011 at 12:34 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
>
>> -----Original Message-----
>> From: linux-media-owner@vger.kernel.org [mailto:linux-media-
>> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
>> Sent: Thursday, December 01, 2011 5:45 AM
>> To: linux-media@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org; laurent.pinchart@ideasonboard.com;
>> sakari.ailus@iki.fi; Aguirre, Sergio
>> Subject: [PATCH v2 04/11] OMAP4: hwmod: Include CSI2A and CSIPHY1 me=
mory
>> sections
>>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 16 +++++++++++++=
---
>> =A01 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-
>> omap2/omap_hwmod_44xx_data.c
>> index 7695e5d..1b59e2f 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -2623,8 +2623,18 @@ static struct omap_hwmod_ocp_if
>> *omap44xx_iss_masters[] =3D {
>>
>> =A0static struct omap_hwmod_addr_space omap44xx_iss_addrs[] =3D {
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x52000000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x520000ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D OMAP44XX_ISS_TOP=
_BASE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D OMAP44XX_ISS_T=
OP_END,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D OMAP44XX_ISS_CSI=
2_A_REGS1_BASE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D OMAP44XX_ISS_C=
SI2_A_REGS1_END,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D OMAP44XX_ISS_CAM=
ERARX_CORE1_BASE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D OMAP44XX_ISS_C=
AMERARX_CORE1_END,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_=
RT
>> =A0 =A0 =A0 },
> This patch will result in build failure, because, the above base addr=
esses
> are getting defined in the next patch
>
> [PATCH v2 05/11] OMAP4: Add base addresses for ISS

Agreed. Will revisit "git-bisectability" of the patch series. Will fix.

Regards,
Sergio

>
> Thanks,
> Vaibhav
>
>> =A0 =A0 =A0 { }
>> @@ -5350,7 +5360,7 @@ static __initdata struct omap_hwmod
>> *omap44xx_hwmods[] =3D {
>> =A0 =A0 =A0 &omap44xx_ipu_c1_hwmod,
>>
>> =A0 =A0 =A0 /* iss class */
>> -/* =A0 &omap44xx_iss_hwmod, */
>> + =A0 =A0 &omap44xx_iss_hwmod,
>>
>> =A0 =A0 =A0 /* iva class */
>> =A0 =A0 =A0 &omap44xx_iva_hwmod,
>> --
>> 1.7.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-medi=
a" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
