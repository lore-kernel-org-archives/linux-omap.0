From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH][OMAPZOOM] DSPBRIDGE: Remove variables not used in
 	cfgdefs.h
Date: Mon, 2 Mar 2009 10:29:39 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602877521CD@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602877517C9@dlee06.ent.ti.com>
 <269694c00903020510v990197emdd32101fe0feef1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56481 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbZCBQ3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 11:29:48 -0500
In-Reply-To: <269694c00903020510v990197emdd32101fe0feef1f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <2ameya@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Ok, let me check, I think I didn't use the same base tree.

Regards,
=46ernando.

-----Original Message-----
=46rom: Ameya Palande [mailto:2ameya@gmail.com]=20
Sent: Monday, March 02, 2009 7:10 AM
To: Guzman Lugo, Fernando
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH][OMAPZOOM] DSPBRIDGE: Remove variables not used in =
cfgdefs.h

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
> =A0arch/arm/plat-omap/include/dspbridge/cfgdefs.h | =A0 10 ----------
> =A0drivers/dsp/bridge/rmgr/drv.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 --
> =A02 files changed, 0 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/ar=
m/plat-omap/include/dspbridge/cfgdefs.h
> index e7633b5..34a28f8
> --- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
> +++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
> @@ -77,15 +77,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 bIRQAttrib; =A0/* IRQ Attribute */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 dwOffsetForMonitor; /* The Shared =
memory starts from
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 * dwMemBase + this offset */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 dwBusType; =A0/* Bus type for this =
device */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 dwProgBase; /* DSP ProgBase */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 dwProgLength; =A0 =A0 =A0 /* DSP Pr=
ogBase Length */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 dwRegBase; =A0/* DSP memory mapped =
register base */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 dwRegLength; =A0 =A0 =A0 =A0/* DSP =
Register Base Length */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ClientHandle; =A0 =A0 =A0 /* Client=
 Handle */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 SocketHandle; =A0 =A0 =A0 /* Socket=
 and Function Pair */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 CardInfo; =A0 /* This will be used =
as a context data in
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in=
 the CardRequestIRQ */
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * =A0Info needed by NODE for allocating channels to c=
ommunicate with RMS:
> =A0 =A0 =A0 =A0 * =A0 =A0 =A0dwChnlOffset: =A0 =A0 =A0 Offset of RMS =
channels. Lower channels are
> @@ -102,7 +93,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void __iomem *dwWdTimerDspBase;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void __iomem *dwMboxBase;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void __iomem *dwDmmuBase;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *dwDipiBase;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void __iomem *dwSysCtrlBase;
> =A0 =A0 =A0 =A0} ;
>
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/=
drv.c
> index 2241f48..160d730
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -1733,7 +1733,6 @@ static DSP_STATUS RequestBridgeResources(u32 dw=
Context, s32 bRequest)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Second window is for DSP external m=
emory shared with MPU */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DSP_SUCCEEDED(status)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* for Linux, these ar=
e hard-coded values */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pResources->dwBusType =3D=
 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pResources->bIRQRegist=
ers =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pResources->bIRQAttrib=
 =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pResources->dwOffsetFo=
rMonitor =3D 0;
> @@ -1856,7 +1855,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32=
 dwContext, s32 bRequest)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DSP_SUCCEEDED(status)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* for Linux, these ar=
e hard-coded values */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pResources->dwBusType =3D=
 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pResources->bIRQRegist=
ers =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pResources->bIRQAttrib=
 =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pResources->dwOffsetFo=
rMonitor =3D 0;
> --
> 1.5.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
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
