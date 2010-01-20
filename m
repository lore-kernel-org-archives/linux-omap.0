From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: dont pass invalid DSP OPP requests
Date: Wed, 20 Jan 2010 12:01:23 +0200
Message-ID: <1263981683.2066.5.camel@sanganak>
References: <1263951848-16822-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22687 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab0ATKCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 05:02:07 -0500
In-Reply-To: <1263951848-16822-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Deepak Chitriki <deepak.chitriki@ti.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Hi Nishanth,

On Wed, 2010-01-20 at 02:44 +0100, ext Nishanth Menon wrote:
> If DSP baseimage requests for invalid OPPs, do not pass them
> to the rest of the linux kernel subsystem. with a test baseimage
> it was found to send
> IO_DispatchPM: WMDIOCTL_CONSTRAINT_REQUEST with parameter 0.
> this is an invalid OPP ID and should not be passed anywhere.
> we add a param check for this prior to passing it along to the
> workqueue.
> 
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Cc: Deepak Chitriki <deepak.chitriki@ti.com>
> Cc: Felipe Contreras <felipe.contreras@nokia.com>
> Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/dsp/bridge/wmd/io_sm.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
> index 6c140c5..618bedb 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -960,9 +960,12 @@ static void IO_DispatchPM(struct work_struct *work)
>  			pArg[1] = pIOMgr->pSharedMem->oppRequest.rqstOppPt;
>  			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Value of OPP "
>  				 "value =0x%x \n", pArg[1]);
> -			status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
> -				 hWmdContext, WMDIOCTL_CONSTRAINT_REQUEST,
> -				 pArg);
> +			if (!pArg[1])
> +				status = DSP_EINVALIDARG;
> +			else
> +				status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
> +					 hWmdContext,
> +					 WMDIOCTL_CONSTRAINT_REQUEST, pArg);
>  			if (DSP_FAILED(status)) {
>  				DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
>  					 "to set constraint = 0x%x \n",

Instead of checking just for 0, isn't it better to check for any value
outside of valid OPPs? (Especially if we need robust implementation
which shouldn't break because of DSP BIOS blackbox!).

Cheers,
Ameya.

