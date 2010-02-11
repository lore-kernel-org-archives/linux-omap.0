From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH v2] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Thu, 11 Feb 2010 20:36:18 +0200
Message-ID: <1265913378.4084.6.camel@sanganak>
References: <1265909597-4436-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36084 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0BKSg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:36:58 -0500
In-Reply-To: <1265909597-4436-1-git-send-email-deepak.chitriki@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Deepak Chitriki <deepak.chitriki@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>

Hi Deepak,

On Thu, 2010-02-11 at 18:33 +0100, ext Deepak Chitriki wrote:
> Removed NTFY_Notify() in WMD_MSG_Get() to avoid locking contention
> as NTFY_Notify() is already invoked in InputMsg().
> 
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> 
> Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
> 
> ---
> Ref:
> v0:http://marc.info/?l=linux-omap&m=126584779011493&w=2
> v1:http://marc.info/?l=linux-omap&m=126586224627725&w=2
> v2:Comment fixes from v1
> 
>  drivers/dsp/bridge/wmd/msg_sm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
> index d778cbc..7414113 100644
> --- a/drivers/dsp/bridge/wmd/msg_sm.c
> +++ b/drivers/dsp/bridge/wmd/msg_sm.c
> @@ -295,7 +295,7 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>  				   (struct list_head *)pMsgFrame);
>  			if (LST_IsEmpty(hMsgQueue->msgUsedList))
>  				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
> -			else 
> +			else
>  				SYNC_SetEvent(hMsgQueue->hSyncEvent);
>  
>  			fGotMsg = true;
> @@ -344,7 +344,7 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>  			}
>  			hMsgQueue->refCount--;
>  			/* Reset the event if there are still queued messages */
> -			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) 
> +			if (!LST_IsEmpty(hMsgQueue->msgUsedList))
>  				SYNC_SetEvent(hMsgQueue->hSyncEvent);
>  
>  			/* Exit critical section */

Is this the correct change?

Cheers,
Ameya.

