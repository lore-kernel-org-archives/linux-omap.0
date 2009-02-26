From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH][OMAPZOOM] DSPBRIDGE: Remove unnecessary checks in
 HW_MBOX_IsFull function
Date: Wed, 25 Feb 2009 18:07:38 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E22D737CB@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602877519D3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763624AbZBZAHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 19:07:47 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1Q07eKh004777
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 18:07:45 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1Q07ef9025528
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 18:07:40 -0600 (CST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602877519D3@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Fernando,


I think you are missing the CHNLSM_InterruptDSP() function changes from Felipe patch; ie. To wait less.


Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Guzman Lugo, Fernando
> Sent: Wednesday, February 25, 2009 5:58 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH][OMAPZOOM] DSPBRIDGE: Remove unnecessary checks in
> HW_MBOX_IsFull function
> 
> 
> Hi,
> 
> 	This patch removes unncessary checks in HW_MBOX_IsFull this patch is
> base on the previous patch that Felipe Contreras sent.
> 
> Regards,
> Fernando.
> 
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 25 Feb 2009 17:48:01 -0600
> Subject: [PATCH] DSPBRIDGE: Remove unnecessary checks in HW_MBOX_IsFull
> function
> 
> This patch removes some unnecessary checks in HW_MBOX_IsFull
> function
> Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
> ---
>  drivers/dsp/bridge/hw/hw_mbox.c    |   22 ++--------------------
>  drivers/dsp/bridge/hw/hw_mbox.h    |    6 ++----
>  drivers/dsp/bridge/wmd/tiomap_sm.c |    6 +++---
>  3 files changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c
> b/drivers/dsp/bridge/hw/hw_mbox.c
> index bc61d64..0f9e5a7
> --- a/drivers/dsp/bridge/hw/hw_mbox.c
> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
> @@ -105,28 +105,10 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress,
> const HW_MBOX_Id_t mailBoxId,
>  }
> 
>  /* Reads the full status register for mailbox. */
> -HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t
> mailBoxId,
> -			u32 *const pIsFull)
> +bool HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId)
>  {
> -	HW_STATUS status = RET_OK;
> -	u32 fullStatus;
> -
> -	/* Check input parameters */
> -	CHECK_INPUT_PARAM(baseAddress, 0, RET_BAD_NULL_PARAM, RES_MBOX_BASE
> +
> -			RES_INVALID_INPUT_PARAM);
> -	CHECK_INPUT_PARAM(pIsFull,  NULL, RET_BAD_NULL_PARAM, RES_MBOX_BASE
> +
> -			RES_INVALID_INPUT_PARAM);
> -	CHECK_INPUT_RANGE_MIN0(mailBoxId, HW_MBOX_ID_MAX, RET_INVALID_ID,
> -			RES_MBOX_BASE + RES_INVALID_INPUT_PARAM);
> -
> -	/* read the is full status parameter for Mailbox */
> -	fullStatus =
> MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
> +	return MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
>  							(u32)mailBoxId);
> -
> -	/* fill in return parameter */
> -	*pIsFull = (fullStatus & 0xFF);
> -
> -	return status;
>  }
> 
>  /* Gets number of messages in a specified mailbox. */
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h
> b/drivers/dsp/bridge/hw/hw_mbox.h
> index 225fb40..e70305d
> --- a/drivers/dsp/bridge/hw/hw_mbox.h
> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
> @@ -158,11 +158,9 @@ extern HW_STATUS HW_MBOX_MsgWrite(
>  *
>  * PURPOSE:      : this function reads the full status register for
> mailbox.
>  */
> -extern HW_STATUS HW_MBOX_IsFull(
> +extern bool HW_MBOX_IsFull(
>  		      const u32	 baseAddress,
> -		      const HW_MBOX_Id_t   mailBoxId,
> -		      u32 *const	pIsFull
> -		  );
> +		      const HW_MBOX_Id_t   mailBoxId);
> 
>  /*
>  * FUNCTION      : HW_MBOX_NumMsgGet
> diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c
> b/drivers/dsp/bridge/wmd/tiomap_sm.c
> index edc3bcf..7acb4f8
> --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
> +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
> @@ -178,7 +178,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT
> *hDevContext)
>  #endif
>  #endif
>  	HW_STATUS hwStatus;
> -	u32 mbxFull;
> +	bool mbxFull;
>  	struct CFG_HOSTRES resources;
>  	u16 cnt = 10;
>  	u32 temp;
> @@ -242,8 +242,8 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT
> *hDevContext)
>  		pDevContext->dwBrdState = BRD_RUNNING;
>  	}
>  	while (--cnt) {
> -		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
> -					   MBOX_ARM2DSP, &mbxFull);
> +		mbxFull = HW_MBOX_IsFull(resources.dwMboxBase,
> +					   MBOX_ARM2DSP);
>  		if (mbxFull)
>  			UTIL_Wait(1000);	/* wait for 1 ms)      */
>  		else
> --
> 1.5.6.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

