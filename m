From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH v2 3/4] dsp-bridge: cleanup and remove HW_MBOX_IsFull
Date: Mon, 23 Feb 2009 16:06:59 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E211807CE@dlee03.ent.ti.com>
References: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
 <1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
 <1235295144-22097-2-git-send-email-felipe.contreras@gmail.com>
 <1235295144-22097-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbZBWWHN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 17:07:13 -0500
In-Reply-To: <1235295144-22097-3-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>

Hi Felipe,

> HW_MBOX_IsFull has many convoluted macros and is used only once. Clean
> it up so it's easier to see what it's actually doing.

-- Is this the reason you added a new function that checks if fifo is full or is there any issue with the existing function ?

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Sunday, February 22, 2009 3:32 AM
> To: linux-omap@vger.kernel.org
> Cc: Hiroshi DOYU; Kanigeri, Hari; ameya.palande@nokia.com; Felipe
> Contreras
> Subject: [PATCH v2 3/4] dsp-bridge: cleanup and remove HW_MBOX_IsFull
> 
> HW_MBOX_IsFull has many convoluted macros and is used only once. Clean
> it up so it's easier to see what it's actually doing.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/hw/hw_mbox.c    |   25 -------------------------
>  drivers/dsp/bridge/hw/hw_mbox.h    |   35 -------------------------------
> ----
>  drivers/dsp/bridge/wmd/tiomap_sm.c |   15 +++++++++------
>  3 files changed, 9 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c
> b/drivers/dsp/bridge/hw/hw_mbox.c
> index 2c14ade..31b890a 100644
> --- a/drivers/dsp/bridge/hw/hw_mbox.c
> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
> @@ -104,31 +104,6 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress,
> const HW_MBOX_Id_t mailBoxId,
>  	return status;
>  }
> 
> -/* Reads the full status register for mailbox. */
> -HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t
> mailBoxId,
> -			u32 *const pIsFull)
> -{
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
> -							(u32)mailBoxId);
> -
> -	/* fill in return parameter */
> -	*pIsFull = (fullStatus & 0xFF);
> -
> -	return status;
> -}
> -
>  /* Gets number of messages in a specified mailbox. */
>  HW_STATUS HW_MBOX_NumMsgGet(const u32 baseAddress, const HW_MBOX_Id_t
> mailBoxId,
>  				u32 *const pNumMsg)
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h
> b/drivers/dsp/bridge/hw/hw_mbox.h
> index 225fb40..d2981d3 100644
> --- a/drivers/dsp/bridge/hw/hw_mbox.h
> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
> @@ -130,41 +130,6 @@ extern HW_STATUS HW_MBOX_MsgWrite(
>  		  );
> 
>  /*
> -* FUNCTION      : HW_MBOX_IsFull
> -*
> -* INPUTS:
> -*
> -*   Identifier  : baseAddress
> -*   Type	: const u32
> -*   Description : Base Address of instance of Mailbox module
> -*
> -*   Identifier  : mailBoxId
> -*   Type	: const HW_MBOX_Id_t
> -*   Description : Mail Box Sub module Id to check
> -*
> -* OUTPUTS:
> -*
> -*   Identifier  : pIsFull
> -*   Type	: u32 *const
> -*   Description : false means mail box not Full
> -*		 true means mailbox full.
> -*
> -* RETURNS:
> -*
> -*   Type	: ReturnCode_t
> -*   Description : RET_OK	      No errors occured
> -*		 RET_BAD_NULL_PARAM  Address/pointer Paramater was set to
> 0/NULL
> -*		 RET_INVALID_ID      Invalid Id used
> -*
> -* PURPOSE:      : this function reads the full status register for
> mailbox.
> -*/
> -extern HW_STATUS HW_MBOX_IsFull(
> -		      const u32	 baseAddress,
> -		      const HW_MBOX_Id_t   mailBoxId,
> -		      u32 *const	pIsFull
> -		  );
> -
> -/*
>  * FUNCTION      : HW_MBOX_NumMsgGet
>  *
>  * INPUTS:
> diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c
> b/drivers/dsp/bridge/wmd/tiomap_sm.c
> index 2f381c8..4ad893b 100644
> --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
> +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
> @@ -156,6 +156,13 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct
> WMD_DEV_CONTEXT *hDevContext)
>  	return status;
>  }
> 
> +#define MAILBOX_FIFOSTATUS(m) (0x80 + 4 * (m))
> +
> +static inline unsigned int fifo_full(void __iomem *mbox_base, int
> mbox_id)
> +{
> +	return __raw_readl(mbox_base + MAILBOX_FIFOSTATUS(mbox_id)) & 0x1;
> +}
> +
>  /*
>   *  ======== CHNLSM_InterruptDSP ========
>   *      Send an interrupt to the DSP processor(s).
> @@ -171,7 +178,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT
> *hDevContext)
>  	u32 opplevel = 0;
>  #endif
>  	HW_STATUS hwStatus;
> -	u32 mbxFull;
>  	struct CFG_HOSTRES resources;
>  	u16 cnt = 10;
>  	u32 temp;
> @@ -214,12 +220,9 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT
> *hDevContext)
>  		pDevContext->dwBrdState = BRD_RUNNING;
>  	}
>  	while (--cnt) {
> -		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
> -					   MBOX_ARM2DSP, &mbxFull);
> -		if (mbxFull)
> -			mdelay(1);
> -		else
> +		if (!fifo_full((void __iomem *) resources.dwMboxBase, 0))
>  			break;
> +		mdelay(1);
>  	}
>  	if (!cnt) {
>  		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
> --
> 1.6.1.3
> 

