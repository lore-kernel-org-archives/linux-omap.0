From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 16/17] DSPBRIDGE: Avoid REGistry if pDevContext is
	available
Date: Tue, 15 Dec 2009 20:21:42 +0200
Message-ID: <94a0d4530912151021k231e5135q892721d091d8f101@mail.gmail.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
	 <1260857998-19349-17-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:54875 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885AbZLOSVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 13:21:43 -0500
Received: by iwn1 with SMTP id 1so102328iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 10:21:43 -0800 (PST)
In-Reply-To: <1260857998-19349-17-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

On Tue, Dec 15, 2009 at 8:19 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> Avoid calls to read the register if pDevContext is available
> to the function, this will save a call to query and hold
> a semaphore under registry operations.

[...]

> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -82,11 +82,8 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_C=
ONTEXT *pDevContext,
> =C2=A0#ifdef CONFIG_BRIDGE_DVFS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *pConstraintVal;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP_STATUS status =3D DSP_SOK;
> - =C2=A0 =C2=A0 =C2=A0 struct CFG_HOSTRES resources;

This breaks the build when DVFS is enabled, because of:
status =3D HW_MBOX_saveSettings(resources.dwMboxBase);

> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dspbridge_platform_data *pdata =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_dspbridge=
_dev->dev.platform_data;
> - =C2=A0 =C2=A0 =C2=A0 status =3D CFG_GetHostResources(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct CFG_DEVNOD=
E *)DRV_GetFirstDevExtension(), &resources);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pConstraintVal =3D (u32 *)(pArgs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Read the target value requested by DSP =
=C2=A0*/

BTW. Nobody is checking for errors in the 'status' variable.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
