From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 03/12] ARM: omap4: use remapped PPI interrupts for
 local timer
Date: Fri, 29 Apr 2011 12:54:21 +0530
Message-ID: <4DBA67A5.4060803@ti.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com> <1303326501-15664-4-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46340 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754537Ab1D2HYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 03:24:50 -0400
Received: by yxm8 with SMTP id 8so1423231yxm.40
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 00:24:49 -0700 (PDT)
In-Reply-To: <1303326501-15664-4-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>

Marc,

On 4/21/2011 12:38 AM, Marc Zyngier wrote:
> Use the normal interrupt scheme for the local timers by using
> a remapped PPI interrupt.
>
> Tested on a Pandaboard.
>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> ---

Have reviewed and tested your series along with
OMAP changes. It boots fine on OMAP4430 SDP.

# cat /proc/interrupts
            CPU0       CPU1
.
410:       3678          0   GIC-PPI  local_timer
413:          0       1042   GIC-PPI  local_timer
.
LOC:          0          0  Local timer interrupts
.

Though above output would be bit miss leading, this
series removes the duplicate code from platforms and
consolidate it at one place.

FWIW, you can add my

Reviewedd-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
