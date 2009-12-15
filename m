From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 16/17] DSPBRIDGE: Avoid REGistry if pDevContext is
 	available
Date: Tue, 15 Dec 2009 13:03:40 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042D396895@dlee03.ent.ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
	 <1260857998-19349-17-git-send-email-omar.ramirez@ti.com>
 <94a0d4530912151021k231e5135q892721d091d8f101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58782 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbZLOTDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 14:03:50 -0500
In-Reply-To: <94a0d4530912151021k231e5135q892721d091d8f101@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Tuesday, December 15, 2009 12:22 PM
>
>On Tue, Dec 15, 2009 at 8:19 AM, Omar Ramirez Luna <omar.ramirez@ti.co=
m> wrote:
>> Avoid calls to read the register if pDevContext is available
>> to the function, this will save a call to query and hold
>> a semaphore under registry operations.
>
>[...]
>
>> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>> @@ -82,11 +82,8 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_=
CONTEXT *pDevContext,
>> =A0#ifdef CONFIG_BRIDGE_DVFS
>> =A0 =A0 =A0 =A0u32 *pConstraintVal;
>> =A0 =A0 =A0 =A0DSP_STATUS status =3D DSP_SOK;
>> - =A0 =A0 =A0 struct CFG_HOSTRES resources;
>
>This breaks the build when DVFS is enabled, because of:
>status =3D HW_MBOX_saveSettings(resources.dwMboxBase);

Yes, this was removed in old patches, so patch assumes it is not there.=
 I'll drop from the series for now.

>
>> =A0 =A0 =A0 =A0struct dspbridge_platform_data *pdata =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dspbridge_dev->dev.platform_data=
;
>> - =A0 =A0 =A0 status =3D CFG_GetHostResources(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct CFG_DEVNODE *)DRV_GetFirstDevE=
xtension(), &resources);
>>
>> =A0 =A0 =A0 =A0pConstraintVal =3D (u32 *)(pArgs);
>> =A0 =A0 =A0 =A0/* Read the target value requested by DSP =A0*/
>
>BTW. Nobody is checking for errors in the 'status' variable.

Will recheck.

- omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
