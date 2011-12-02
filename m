From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 04/11] OMAP4: hwmod: Include CSI2A and CSIPHY1 memory sections
Date: Fri, 02 Dec 2011 14:49:10 -0800
Message-ID: <87pqg6lhcp.fsf@ti.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
	<1322698500-29924-5-git-send-email-saaguirre@ti.com>
	<79CD15C6BA57404B839C016229A409A8046FCD@DBDE01.ent.ti.com>
	<CAKnK67TrzD1hoKOOaodRK=-Ct5bNYAtXab3hY4UdxJTNdD0Tuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36733 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171Ab1LBWtP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 17:49:15 -0500
In-Reply-To: <CAKnK67TrzD1hoKOOaodRK=-Ct5bNYAtXab3hY4UdxJTNdD0Tuw@mail.gmail.com>
	(Sergio Aguirre's message of "Thu, 1 Dec 2011 07:17:25 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, Benoit Cousson <b-cousson@ti.com>

+Benoit,

"Aguirre, Sergio" <saaguirre@ti.com> writes:

> Hi Vaibhav,
>
> Thanks for the comments.
>
> On Thu, Dec 1, 2011 at 12:34 AM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
>>
>>> -----Original Message-----
>>> From: linux-media-owner@vger.kernel.org [mailto:linux-media-
>>> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
>>> Sent: Thursday, December 01, 2011 5:45 AM
>>> To: linux-media@vger.kernel.org
>>> Cc: linux-omap@vger.kernel.org; laurent.pinchart@ideasonboard.com;
>>> sakari.ailus@iki.fi; Aguirre, Sergio
>>> Subject: [PATCH v2 04/11] OMAP4: hwmod: Include CSI2A and CSIPHY1 m=
emory
>>> sections
>>>
>>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =C2=A0 16 ++++++=
+++++++---
>>> =C2=A01 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/=
mach-
>>> omap2/omap_hwmod_44xx_data.c
>>> index 7695e5d..1b59e2f 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -2623,8 +2623,18 @@ static struct omap_hwmod_ocp_if
>>> *omap44xx_iss_masters[] =3D {
>>>
>>> =C2=A0static struct omap_hwmod_addr_space omap44xx_iss_addrs[] =3D =
{
>>> =C2=A0 =C2=A0 =C2=A0 {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=A0=
 =C2=A0 =3D 0x52000000,
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 0x520000ff,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=A0=
 =C2=A0 =3D OMAP44XX_ISS_TOP_BASE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D OMAP44XX_ISS_TOP_END,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D ADDR_TYPE_RT
>>> + =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=A0=
 =C2=A0 =3D OMAP44XX_ISS_CSI2_A_REGS1_BASE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D OMAP44XX_ISS_CSI2_A_REGS1_END,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D ADDR_TYPE_RT
>>> + =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=A0=
 =C2=A0 =3D OMAP44XX_ISS_CAMERARX_CORE1_BASE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D OMAP44XX_ISS_CAMERARX_CORE1_END,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D ADDR_TYPE_RT
>>> =C2=A0 =C2=A0 =C2=A0 },
>> This patch will result in build failure, because, the above base add=
resses
>> are getting defined in the next patch
>>
>> [PATCH v2 05/11] OMAP4: Add base addresses for ISS
>
> Agreed. Will revisit "git-bisectability" of the patch series. Will fi=
x.

To fix this, just drop the #defines from the header, and use raw
addresses directly.

Also, work with Benoit to make sure at the scripts that autogenerate
this data are updated to include these two regions.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
