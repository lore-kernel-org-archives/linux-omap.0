From: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>
Subject: [RESEND] [PATCH] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Wed, 10 Feb 2010 18:22:59 -0600
Message-ID: <B321760590390941B64F0F8AB59ED250885B13EF@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684Ab0BKAXG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 19:23:06 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>

Please discard this patch.The rework patch will be available in v1.

Thanks,
Deepak
________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Chitriki Rudramuni, Deepak
Sent: Thursday, February 11, 2010 4:44 AM
To: Ameya Palande
Cc: linux-omap; Ramirez Luna, Omar; Menon, Nishanth
Subject: RE: [PATCH] DSPBRIDGE: Fix to avoid possible recursive locking

Hi Ameya,

Yes I agree with your comments.
As I understand NTFY_Notify() is called again inside WMD_MSG_Get() to make sure that notification is done in case if message queue is not empty.Since notification is already done once in InputMsg() while copying message to message queue,it doesn't make sense to notify again in
WMD_MSG_Get().I guess this is not needed.I did a quick sanity testing removing NTFY_Notify() from WMD_MSG_Get() and no issues.
I will rework the patch and update.

Thanks,
Deepak
______________________________________
From: Ameya Palande [ameya.palande@nokia.com]
Sent: Wednesday, February 10, 2010 6:57 PM
To: Chitriki Rudramuni, Deepak
Cc: linux-omap; Ramirez Luna, Omar; Menon, Nishanth
Subject: Re: [PATCH] DSPBRIDGE: Fix to avoid possible recursive locking

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
>                       if (LST_IsEmpty(hMsgQueue->msgUsedList))
>                               SYNC_ResetEvent(hMsgQueue->hSyncEvent);
>                       else {
> +                             (void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
>                               NTFY_Notify(hMsgQueue->hNtfy,
>                                       DSP_NODEMESSAGEREADY);
> +                             (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
>                               SYNC_SetEvent(hMsgQueue->hSyncEvent);
>                       }
>
> @@ -352,8 +354,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>                       hMsgQueue->refCount--;
>                       /* Reset the event if there are still queued messages */
>                       if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
> +                             (void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
>                               NTFY_Notify(hMsgQueue->hNtfy,
>                                       DSP_NODEMESSAGEREADY);
> +                             (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
>                               SYNC_SetEvent(hMsgQueue->hSyncEvent);
>                       }
>                       /* Exit critical section */

Can you explain the need of calling NTFY_Notify() in WMD_MSG_Get()?
I can see that the InputMsg calls NTFY_Notify() already!

Can we get rid of NTFY_Notify() from WMD_MSG_Get() all together?

Cheers,
Ameya.--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html