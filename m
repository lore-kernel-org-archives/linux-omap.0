From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Remove conditional check from the InputMsg
 function
Date: Wed, 27 Jan 2010 22:34:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A542EDF@dbde02.ent.ti.com>
References: <1264556672-27492-1-git-send-email-omar.ramirez@ti.com>
 <1264585443.2100.2.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52649 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755731Ab0A0RET convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 12:04:19 -0500
In-Reply-To: <1264585443.2100.2.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com] 
> Sent: Wednesday, January 27, 2010 3:44 AM
> To: Ramirez Luna, Omar
> Cc: linux-omap; Doyu Hiroshi (Nokia-D/Helsinki); Contreras Felipe (Nokia-> >D/Helsinki); Menon, Nishanth; Hebbar, Shivananda
>Subject: Re: [PATCH] DSPBRIDGE: Remove conditional check from the InputMsg >function

>Hi Shivananda,

On Wed, 2010-01-27 at 02:44 +0100, ext Omar Ramirez Luna wrote:
> From: Shivananda Hebbar <x0hebbar@ti.com>
> 
> This patch removes the conditional check which can result in
> message skip.
> 
> Discovered-by: Bhavin Shah <bshah@ti.com>
> Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
> ---
>  drivers/dsp/bridge/wmd/io_sm.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
> index 39b37a6..b2092a2 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -1328,7 +1328,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
>  	fInputEmpty = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
>  				 bufEmpty);
>  	uMsgs = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, size);
> -	if (fInputEmpty || uMsgs >= hMsgMgr->uMaxMsgs)
> +	if (fInputEmpty)
>  		goto func_end;
>  
>  	pMsgInput = pIOMgr->pMsgInput;
> @@ -1356,9 +1356,6 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
>  		 * input locations have been set up. If all nodes were
>  		 * cleaned up, hMsgMgr->uMaxMsgs should be 0.
>  		 */
> -		if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
> -			goto func_end;
> -
>  		while (hMsgQueue != NULL) {
>  			if (msg.dwId == hMsgQueue->dwId) {
>  				/* Found it */

>Forgive me for the stupid question, but now since uMsgs >=
>hMsgMgr->uMaxMsgs condition is removed, what is the side effect of that?
>At least I am not able to understand how it affects the logic just by
>seeing your patch. I guess if you can modify the patch description to
>reflect the logic behind this then it will be nice :)

I don't see any side effects with the removal of this conditional check.
Intention of the patch was to remove the redundant check on uMaxMsgs as the DSP side of the bridge code check will ensure that uMsgs can't exceed uMaxMsgs.
If you are ok with this explanation, I will update the description and resend it.

And the initial patch description was written with the intention that in case the uMsgs exceeds the uMaxMessages (), then we shouldn't discard it by returning from function but process it. 


Regards,
Shivananda


