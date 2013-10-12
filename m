From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: wakeupgen: AM43x adaptation
Date: Sat, 12 Oct 2013 15:52:06 +0530
Message-ID: <525922CE.6080200@ti.com>
References: <1381302753-7045-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34589 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab3JLKWc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Oct 2013 06:22:32 -0400
In-Reply-To: <1381302753-7045-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Hi Tony,

On Wednesday 09 October 2013 12:42 PM, Afzal Mohammed wrote:
> AM43x has 224 interrupts and 7 banks, make it as maximum values. Keep
> default values as earlier, if am43x is detected, update interrupts and
> banks accordingly.
> 
> Also AM43x has only one cpu, ensure that clearing bitmask at wakeupgen
> is done only for the single existing cpu, existing code assumes that
> there are two cpu's.
> 
> If bitmask is cleared in wakeupgen for the nonexistent second cpu,
> an imprecise abort happens as soon as Kernel switches to user space.
> It was rootcaused by Sekhar Nori <nsekhar@ti.com>.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> v2:
> 1. make AM43x adaptation such that changes required for new SoC addition is less
> 2. avoid usage of am43x local variable, use soc_is_am43xx() instead

Seems you missed this one, please consider this for the coming merge
window. Without this AM43x would not boot to prompt.

Regards
Afzal

