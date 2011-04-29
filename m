From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] OMAP3 cpuidle: remove useless SDP specific timings
Date: Fri, 29 Apr 2011 16:44:33 +0530
Message-ID: <4DBA9D99.4070908@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com> <1304069186-3086-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46964 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932104Ab1D2LPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 07:15:02 -0400
Received: by mail-gy0-f171.google.com with SMTP id 5so1628551gye.2
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 04:15:02 -0700 (PDT)
In-Reply-To: <1304069186-3086-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On 4/29/2011 2:56 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> The cpuidle states settings can be overriden by some board-
> specific settings, by calling omap3_pm_init_cpuidle.
> Remove the 3430SDP specific states settings registration
> since the figures are identical to the default ones (in cpuidle34xx.c).
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/board-3430sdp.c |   19 -------------------
>   1 files changed, 0 insertions(+), 19 deletions(-)
>
Looks like the example table to show the API usage never got
updated with board specific timings :)

-19 lines more :)

Regards
Santosh
