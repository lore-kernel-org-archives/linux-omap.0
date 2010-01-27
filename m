From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Remove conditional check from the InputMsg
 function
Date: Wed, 27 Jan 2010 11:44:03 +0200
Message-ID: <1264585443.2100.2.camel@sanganak>
References: <1264556672-27492-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51267 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0A0Jok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 04:44:40 -0500
In-Reply-To: <1264556672-27492-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>

Hi Shivananda,

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

Forgive me for the stupid question, but now since uMsgs >=
hMsgMgr->uMaxMsgs condition is removed, what is the side effect of that?
At least I am not able to understand how it affects the logic just by
seeing your patch. I guess if you can modify the patch description to
reflect the logic behind this then it will be nice :)

Cheers,
Ameya.


