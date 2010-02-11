From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCHv1] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Wed, 10 Feb 2010 22:23:53 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012EC4DA91@dlee02.ent.ti.com>
References: <1265848189-10697-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719Ab0BKEYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 23:24:03 -0500
In-Reply-To: <1265848189-10697-1-git-send-email-deepak.chitriki@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>


> From: Chitriki Rudramuni, Deepak
> Sent: Thursday, February 11, 2010 2:30 AM


> 
> Removed NTFY_Notify() in WMD_MSG_Get() to avoid locking contention
> as NTFY_Notify() is already invoked in InputMsg().
> 
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> 
> Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
> 
> Ref:
> v0:http://marc.info/?l=linux-omap&m=126584779011493&w=2
> v1:Comment fixes from v0
Please move the Ref into the diff stat section (below ---
In the next line).

> ---
>  drivers/dsp/bridge/wmd/msg_sm.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/msg_sm.c
> b/drivers/dsp/bridge/wmd/msg_sm.c
> index 3a275f1..7de3705 100644
> --- a/drivers/dsp/bridge/wmd/msg_sm.c
> +++ b/drivers/dsp/bridge/wmd/msg_sm.c
> @@ -296,8 +296,6 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>  			if (LST_IsEmpty(hMsgQueue->msgUsedList))
>  				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
>  			else {
> -				NTFY_Notify(hMsgQueue->hNtfy,
> -					DSP_NODEMESSAGEREADY);
>  				SYNC_SetEvent(hMsgQueue->hSyncEvent);
>  			}
> 
One line code does not need {} - please remove it as well.

> @@ -348,8 +346,6 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>  			hMsgQueue->refCount--;
>  			/* Reset the event if there are still queued messages */
>  			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
> -				NTFY_Notify(hMsgQueue->hNtfy,
> -					DSP_NODEMESSAGEREADY);
>  				SYNC_SetEvent(hMsgQueue->hSyncEvent);
>  			}
One line code does not need {} - please remove it as well.

>  			/* Exit critical section */
> --
> 1.6.3.3


Regards,
Nishanth Menon

