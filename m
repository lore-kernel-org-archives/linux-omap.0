From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix declaration and initialization of sync
 objects.
Date: Mon, 19 Apr 2010 17:58:53 -0500
Message-ID: <4BCCE02D.6080407@ti.com>
References: <496565EC904933469F292DDA3F1663E602CB215E41@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44197 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0DSW67 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 18:58:59 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB215E41@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

Guzman Lugo, Fernando wrote:
> From 2edd80839e6d3bbe6e92914c3097a6dedca23784 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Sun, 18 Apr 2010 00:32:01 -0500
> Subject: [PATCH] DSPBRIDGE: Fix declaration and initialization of sync objects.
>
> This patch fixes declaration of completions for sync in
> drv_interface and also initialize sync->done object in
> msg_sm.c
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |    4 ++--
>  drivers/dsp/bridge/wmd/msg_sm.c         |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index d62e508..1dd635e 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -98,8 +98,8 @@ static int tc_wordswapon;	/* Default value is always false */
>  static atomic_t bridge_cref;	/* number of bridge open handles */
>  static struct workqueue_struct *bridge_rec_queue;
>  static struct work_struct bridge_recovery_work;
> -static DECLARE_COMPLETION_ONSTACK(bridge_comp);
> -static DECLARE_COMPLETION_ONSTACK(bridge_open_comp);
> +static DECLARE_COMPLETION(bridge_comp);
> +static DECLARE_COMPLETION(bridge_open_comp);
>  static bool recover;
>  #endif
>  
> diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
> index 19e3cee..6f00071 100644
> --- a/drivers/dsp/bridge/wmd/msg_sm.c
> +++ b/drivers/dsp/bridge/wmd/msg_sm.c
> @@ -185,8 +185,8 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,
>  	if (DSP_SUCCEEDED(status)) {
>  		msg_q->sync_done = kzalloc(sizeof(struct sync_object),
>  							GFP_KERNEL);
> -		if (msg_q->sync_event)
> -			sync_init_event(msg_q->sync_event);
> +		if (msg_q->sync_done)
> +			sync_init_event(msg_q->sync_done);
>  		else
>  			status = DSP_EMEMORY;
>  	}
> @@ -194,7 +194,7 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,
>  	if (DSP_SUCCEEDED(status)) {
>  		msg_q->sync_done_ack = kzalloc(sizeof(struct sync_object),
>  							GFP_KERNEL);
> -		if (msg_q->sync_event)
> +		if (msg_q->sync_done_ack)
>  			sync_init_event(msg_q->sync_done_ack);
>  		else
>  			status = DSP_EMEMORY;
>   
Acked-by: Deepak Chitriki <deepak.chitriki@ti.com>

Deepak
