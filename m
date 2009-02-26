From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH][OMAPZOOM] DSPBRIDGE: Remove unnecessary checks in
	HW_MBOX_IsFull function
Date: Thu, 26 Feb 2009 02:27:22 +0200
Message-ID: <94a0d4530902251627i1a0d9303xd8acb6a376f67307@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602877519D3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:54962 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZBZA1Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 19:27:25 -0500
Received: by fg-out-1718.google.com with SMTP id 16so370134fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:27:22 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602877519D3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 26, 2009 at 1:58 AM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
>
> Hi,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This patch removes unncessary checks in HW=
_MBOX_IsFull this patch is base on the previous patch that Felipe Contr=
eras sent.
>
> Regards,
> Fernando.
>
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 25 Feb 2009 17:48:01 -0600
> Subject: [PATCH] DSPBRIDGE: Remove unnecessary checks in HW_MBOX_IsFu=
ll function
>
> This patch removes some unnecessary checks in HW_MBOX_IsFull
> function
> Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
> ---
> =C2=A0drivers/dsp/bridge/hw/hw_mbox.c =C2=A0 =C2=A0| =C2=A0 22 ++----=
----------------
> =C2=A0drivers/dsp/bridge/hw/hw_mbox.h =C2=A0 =C2=A0| =C2=A0 =C2=A06 +=
+----
> =C2=A0drivers/dsp/bridge/wmd/tiomap_sm.c | =C2=A0 =C2=A06 +++---
> =C2=A03 files changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/=
hw_mbox.c
> index bc61d64..0f9e5a7
> --- a/drivers/dsp/bridge/hw/hw_mbox.c
> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
> @@ -105,28 +105,10 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddres=
s, const HW_MBOX_Id_t mailBoxId,
> =C2=A0}
>
> =C2=A0/* Reads the full status register for mailbox. */
> -HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t m=
ailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u32 *const pIsFull)
> +bool HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBo=
xId)

Why not 'static inline'?

> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> - =C2=A0 =C2=A0 =C2=A0 u32 fullStatus;
> -
> - =C2=A0 =C2=A0 =C2=A0 /* Check input parameters */
> - =C2=A0 =C2=A0 =C2=A0 CHECK_INPUT_PARAM(baseAddress, 0, RET_BAD_NULL=
_PARAM, RES_MBOX_BASE +
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 RES_INVALID_INPUT_PARAM);
> - =C2=A0 =C2=A0 =C2=A0 CHECK_INPUT_PARAM(pIsFull, =C2=A0NULL, RET_BAD=
_NULL_PARAM, RES_MBOX_BASE +
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 RES_INVALID_INPUT_PARAM);
> - =C2=A0 =C2=A0 =C2=A0 CHECK_INPUT_RANGE_MIN0(mailBoxId, HW_MBOX_ID_M=
AX, RET_INVALID_ID,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 RES_MBOX_BASE + RES_INVALID_INPUT_PARAM);
> -
> - =C2=A0 =C2=A0 =C2=A0 /* read the is full status parameter for Mailb=
ox */
> - =C2=A0 =C2=A0 =C2=A0 fullStatus =3D MLBMAILBOX_FIFOSTATUS___0_15Fif=
oFullMBmRead32(baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 return MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBm=
Read32(baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(u32)mailBoxId);

This would return an int, not a bool, right? The int would have only 0
and 1 and values, so that might be ok, I'm not sure.

> -
> - =C2=A0 =C2=A0 =C2=A0 /* fill in return parameter */
> - =C2=A0 =C2=A0 =C2=A0 *pIsFull =3D (fullStatus & 0xFF);
> -
> - =C2=A0 =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> =C2=A0/* Gets number of messages in a specified mailbox. */
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/=
hw_mbox.h
> index 225fb40..e70305d
> --- a/drivers/dsp/bridge/hw/hw_mbox.h
> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
> @@ -158,11 +158,9 @@ extern HW_STATUS HW_MBOX_MsgWrite(
> =C2=A0*
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function reads the full s=
tatus register for mailbox.
> =C2=A0*/
> -extern HW_STATUS HW_MBOX_IsFull(
> +extern bool HW_MBOX_IsFull(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const u32 =C2=A0baseAddress,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const HW_MBOX_Id_t =C2=A0 mailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 u32 *const =C2=A0 =C2=A0 =C2=A0 =C2=A0pIsFull
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const HW_MBOX_Id_t =C2=A0 mailBoxId);
>
> =C2=A0/*
> =C2=A0* FUNCTION =C2=A0 =C2=A0 =C2=A0: HW_MBOX_NumMsgGet
> diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/=
wmd/tiomap_sm.c
> index edc3bcf..7acb4f8
> --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
> +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
> @@ -178,7 +178,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CON=
TEXT *hDevContext)
> =C2=A0#endif
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS hwStatus;
> - =C2=A0 =C2=A0 =C2=A0 u32 mbxFull;
> + =C2=A0 =C2=A0 =C2=A0 bool mbxFull;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct CFG_HOSTRES resources;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 cnt =3D 10;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 temp;
> @@ -242,8 +242,8 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CON=
TEXT *hDevContext)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pDevContext->d=
wBrdState =3D BRD_RUNNING;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (--cnt) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwStatus =3D HW_MB=
OX_IsFull(resources.dwMboxBase,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MBOX_ARM2DSP, &mbxFull);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbxFull =3D HW_MBO=
X_IsFull(resources.dwMboxBase,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MBOX_ARM2DSP);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mbxFull)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0UTIL_Wait(1000); =C2=A0 =C2=A0 =C2=A0 =C2=A0/* wait for 1=
 ms) =C2=A0 =C2=A0 =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> --

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
