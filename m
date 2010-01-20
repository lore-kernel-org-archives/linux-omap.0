From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: replace init_timer with init_timer_on_stack
Date: Wed, 20 Jan 2010 11:55:03 +0200
Message-ID: <1263981303.2066.2.camel@sanganak>
References: <1263948311-22140-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51925 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab0ATJ4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 04:56:10 -0500
In-Reply-To: <1263948311-22140-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Deepak Chitriki <deepak.chitriki@ti.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Wed, 2010-01-20 at 01:45 +0100, ext Nishanth Menon wrote:
> With LOCK_DEP enabled and DEBUG_OBJECTS_TIMERS, DSPBridge
> SYNC_WaitOnMultipleEvents will fail with message
> "ODEBUG: object is on stack, but not annotated"
> since the timeout timer is on the stack, we should rightly use
> init_timer_on_stack.
> 
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Cc: Deepak Chitriki <deepak.chitriki@ti.com>
> Cc: Felipe Contreras <felipe.contreras@nokia.com>
> Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/dsp/bridge/services/sync.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
> index c2d79c7..d246656 100644
> --- a/drivers/dsp/bridge/services/sync.c
> +++ b/drivers/dsp/bridge/services/sync.c
> @@ -330,7 +330,7 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
>  	if (Wp->state != wo_signalled && dwTimeout > 0) {
>  		struct timer_list timeout;
>  		if (dwTimeout != SYNC_INFINITE) {
> -			init_timer(&timeout);
> +			init_timer_on_stack(&timeout);
>  			timeout.function = timeout_callback;
>  			timeout.data = (unsigned long)Wp;
>  			timeout.expires = jiffies + dwTimeout * HZ / 1000;

Acked-by: Ameya Palande <ameya.palande@nokia.com>

