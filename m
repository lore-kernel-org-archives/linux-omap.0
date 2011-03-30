From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/5] OMAP: l3: fixes and cleanup
Date: Wed, 30 Mar 2011 12:15:26 +0530
Message-ID: <4D92D186.1070302@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45626 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab1C3Gpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:45:47 -0400
Received: by gwb20 with SMTP id 20so400005gwb.3
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 23:45:46 -0700 (PDT)
In-Reply-To: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

Omar,

On 3/29/2011 10:50 PM, Omar Ramirez Luna wrote:
> Based on the comments received for the first patch:
> OMAP3: l3: fix for "irq 10: nobody cared" message[1],
> and quick skimming through the code.
>
> Although there are still parenthesis that are not needed
> because of operator precedence, they were left for clarity.
>
> E.g.:
> (error>>  32)&  0xffff;
>
> clear = (L3_AGENT_STATUS_CLEAR_IA<<  int_type) |
>          L3_AGENT_STATUS_CLEAR_TA;
>
> ---
> [1] https://patchwork.kernel.org/patch/665141/
>
> Omar Ramirez Luna (5):
>    OMAP3: l3: fix for "irq 10: nobody cared" message
>    OMAP3: l3: fix omap3_l3_probe error path
>    OMAP3: l3: minor cleanup for error message, parenthesis and extra
>      lines
>    OMAP4: l3: fix omap4_l3_probe error path
>    OMAP4: l3: minor cleanup for parenthesis and extra spaces
>
Thanks for the cleanup. I have reviewed the series and it looks
good to me.
I would suggest to fold similar changes like,
- PATCH 2/5 and PATCH 4/5 into one patch
- PATCH 3/5 and PATCH 5/5 into one patch

With this update you can add my ack for this series

>   arch/arm/mach-omap2/omap_l3_noc.c |   51 ++++++++++++++++--------------------
>   arch/arm/mach-omap2/omap_l3_smx.c |   46 ++++++++++++---------------------
>   2 files changed, 40 insertions(+), 57 deletions(-)
>

