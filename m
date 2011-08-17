From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON when
 using clockdomain force wakeup
Date: Wed, 17 Aug 2011 10:41:44 +0530
Message-ID: <4E4B4D90.9040103@ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1107150159580.16606@utopia.booyaka.com> <4E214267.2090700@ti.com> <4E43E23C.2080207@ti.com> <alpine.DEB.2.00.1108120730220.10963@utopia.booyaka.com> <alpine.DEB.2.00.1108161946550.9948@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35155 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978Ab1HQFMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Aug 2011 01:12:00 -0400
Received: by mail-yw0-f41.google.com with SMTP id 13so500637ywm.28
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 22:11:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108161946550.9948@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, khilman@ti.com, p-titiano@ti.com, b-cousson@ti.com

On Wednesday 17 August 2011 07:17 AM, Paul Walmsley wrote:
>
> Hi everyone
>
> I've updated this patch per my earlier comments and also to apply.
> Please let me know if you have any issues with it ASAP.
>
>
> - Paul
>
> From: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Date: Sat, 13 Aug 2011 08:56:28 +0530
> Subject: [PATCH] [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON
>   when using clockdomain force wakeup
>
> While using clockdomain force wakeup method, not waiting for powerdomain
> to be effectively ON may end up locking the clockdomain FSM until a
> next wakeup event occurs.
>
> One such issue was seen on OMAP4430, where L4_PER was periodically
> getting stuck in in-transition state when transitioning from from OSWR to ON.
>
> This issue was reported and investigated by Patrick Titiano<p-titiano@ti.com>
>
> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Reported-by: Patrick Titiano<p-titiano@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> [paul@pwsan.com: updated to apply; added transition wait on clkdm_deny_idle();
>   remove two superfluous pwrdm_wait_transition() calls]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
Thanks Paul. Patch looks good to me.

Regards
Santosh
