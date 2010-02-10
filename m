From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Wed, 10 Feb 2010 15:27:15 +0200
Message-ID: <1265808435.30481.48.camel@sanganak>
References: <1265763677-7012-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34356 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab0BJN1u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 08:27:50 -0500
In-Reply-To: <1265763677-7012-1-git-send-email-deepak.chitriki@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Deepak Chitriki <deepak.chitriki@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>

Hi Deepak,

On Wed, 2010-02-10 at 02:01 +0100, ext Deepak Chitriki wrote:
> This patch fixes possible recursive locking detection.The implementation
> in which the spinlock is acquired and released is rectified in WMD_MSG_Get()
> to avoid locking contention.
> Added SYNC_EnterCS() and SYNC_LeaveCS()in WMD_MSG_Get()function.
> 
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> 
> Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
> ---
>  drivers/dsp/bridge/wmd/msg_sm.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
> index 50201e5..8faf5ad 100644
> --- a/drivers/dsp/bridge/wmd/msg_sm.c
> +++ b/drivers/dsp/bridge/wmd/msg_sm.c
> @@ -300,8 +300,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>  			if (LST_IsEmpty(hMsgQueue->msgUsedList))
>  				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
>  			else {
> +				(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
>  				NTFY_Notify(hMsgQueue->hNtfy,
>  					DSP_NODEMESSAGEREADY);
> +				(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
>  				SYNC_SetEvent(hMsgQueue->hSyncEvent);
>  			}
>  
> @@ -352,8 +354,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>  			hMsgQueue->refCount--;
>  			/* Reset the event if there are still queued messages */
>  			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
> +				(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
>  				NTFY_Notify(hMsgQueue->hNtfy,
>  					DSP_NODEMESSAGEREADY);
> +				(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
>  				SYNC_SetEvent(hMsgQueue->hSyncEvent);
>  			}
>  			/* Exit critical section */

Can you explain the need of calling NTFY_Notify() in WMD_MSG_Get()?
I can see that the InputMsg calls NTFY_Notify() already!

Can we get rid of NTFY_Notify() from WMD_MSG_Get() all together?

Cheers,
Ameya.

