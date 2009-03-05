From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Remove variables not used in cfgdefs.h
Date: Thu, 5 Mar 2009 12:14:24 +0200
Message-ID: <269694c00903050214uafe7ea1ke13472afa149162d@mail.gmail.com>
References: <1236190296-21667-1-git-send-email-x0095840@ti.com>
	 <1236190296-21667-2-git-send-email-x0095840@ti.com>
	 <1236190296-21667-3-git-send-email-x0095840@ti.com>
	 <1236190296-21667-4-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:4416 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbZCEKO2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 05:14:28 -0500
Received: by rv-out-0506.google.com with SMTP id g37so3802266rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2009 02:14:25 -0800 (PST)
In-Reply-To: <1236190296-21667-4-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: leed.aguilar@ti.com, vikram.pandita@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

On Wed, Mar 4, 2009 at 8:11 PM, Fernando Guzman Lugo <x0095840@ti.com> =
wrote:
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

Couldn't apply :(
I guess you missed the following commit.

commit 3b313ff3e50d3c46c506e8939f92c406aa5b0bc6
Author: Ramesh Gupta G <grgupta@ti.com>
Date:   Fri Feb 13 14:51:19 2009 +0530

patching file arch/arm/plat-omap/include/dspbridge/cfgdefs.h
Hunk #2 FAILED at 93.
1 out of 2 hunks FAILED -- saving rejects to file
arch/arm/plat-omap/include/dspbridge/cfgdefs.h.rej
patching file drivers/dsp/bridge/rmgr/drv.c
Hunk #1 succeeded at 1736 (offset 3 lines).
Hunk #2 succeeded at 1862 (offset 7 lines).

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
