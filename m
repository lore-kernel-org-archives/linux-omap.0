From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH][OMAPZOOM] DSPBRIDGE: Remove variables not used in
	cfgdefs.h
Date: Mon, 2 Mar 2009 15:10:03 +0200
Message-ID: <269694c00903020510v990197emdd32101fe0feef1f@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602877517C9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:25804 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZCBNKG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 08:10:06 -0500
Received: by nf-out-0910.google.com with SMTP id d21so492518nfb.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 05:10:03 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602877517C9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Feb 25, 2009 at 7:32 PM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
> From d3aeedc4677ebe6fdfb7f9f68b72ad5dc96463f0 Mon Sep 17 00:00:00 200=
1
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 25 Feb 2009 10:19:12 -0600
> Subject: [PATCH] DSPBRIDGE: Remove variables not used in cfgdefs.h
>
> This patch removes some variable that are not used.
> Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/include/dspbridge/cfgdefs.h | =C2=A0 10 ----=
------
> =C2=A0drivers/dsp/bridge/rmgr/drv.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 --
> =C2=A02 files changed, 0 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/ar=
m/plat-omap/include/dspbridge/cfgdefs.h
> index e7633b5..34a28f8
> --- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
> +++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
> @@ -77,15 +77,6 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 bIRQAttrib;=
 =C2=A0/* IRQ Attribute */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwOffsetFo=
rMonitor; /* The Shared memory starts from
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
* dwMemBase + this offset */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwBusType; =C2=
=A0/* Bus type for this device */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwProgBase; /*=
 DSP ProgBase */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwProgLength; =
=C2=A0 =C2=A0 =C2=A0 /* DSP ProgBase Length */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwRegBase; =C2=
=A0/* DSP memory mapped register base */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwRegLength; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* DSP Register Base Length */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 ClientHandle; =
=C2=A0 =C2=A0 =C2=A0 /* Client Handle */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 SocketHandle; =
=C2=A0 =C2=A0 =C2=A0 /* Socket and Function Pair */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 CardInfo; =C2=A0=
 /* This will be used as a context data in
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in the CardRequestIRQ */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0Info needed by NODE for allocatin=
g channels to communicate with RMS:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0 =C2=A0dwChnlOffset: =C2=A0=
 =C2=A0 =C2=A0 Offset of RMS channels. Lower channels are
> @@ -102,7 +93,6 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *=
dwWdTimerDspBase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *=
dwMboxBase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *=
dwDmmuBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *dwDipiBase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *=
dwSysCtrlBase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} ;
>
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/=
drv.c
> index 2241f48..160d730
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -1733,7 +1733,6 @@ static DSP_STATUS RequestBridgeResources(u32 dw=
Context, s32 bRequest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Second wind=
ow is for DSP external memory shared with MPU */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DSP_SUCCEE=
DED(status)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* for Linux, these are hard-coded values */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwBusType =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->bIRQRegisters =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->bIRQAttrib =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->dwOffsetForMonitor =3D 0;
> @@ -1856,7 +1855,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32=
 dwContext, s32 bRequest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DSP_SUCCEE=
DED(status)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* for Linux, these are hard-coded values */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwBusType =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->bIRQRegisters =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->bIRQAttrib =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->dwOffsetForMonitor =3D 0;
> --
> 1.5.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Can't apply this one as I guess your base tree has missed the following=
 patch:

Author: Ramesh Gupta G <grgupta@ti.com>
Date:   Fri Feb 13 14:51:19 2009 +0530

DSPBRIDGE DVFS and offmode support

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
