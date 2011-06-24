From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP3: PM: remove get_*_restore_pointer functions, directly
 use entry points
Date: Fri, 24 Jun 2011 05:55:36 +0530
Message-ID: <4E03D980.9000705@ti.com>
References: <1308874574-30663-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37407 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759923Ab1FXAZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 20:25:40 -0400
Received: by mail-yw0-f43.google.com with SMTP id 2so1245324ywt.2
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 17:25:39 -0700 (PDT)
In-Reply-To: <1308874574-30663-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Jean Pihet <jean.pihet@newoldbits.com>, linux-arm-kernel@lists.infradead.org

On 6/24/2011 5:46 AM, Kevin Hilman wrote:
> Upon return from off-mode, the ROM code jumps to a restore function
> saved in the scratchpad.  Based on SoC revision or errata, this
> restore entry point is different.  Current code uses some helper
> functions in sleep34xx.S (get_*_restore_pointer) to get the restore
> function entry point.
>
> When returning from off-mode, this code is executed from SDRAM, so
> there's no reason to use these helper functions when using the SDRAM
> entry points directly would work just fine.
>
> This patch uses ENTRY/ENDPROC to create "real" entry points for these
> functions, and uses those values directly when writing the scratchpad.
>
> Tested all three entry points
> - restore_es3: 3430/n900
> - restore_3630: 3630/Zoom3
> - restore: 3530/Overo
>
> Suggested-by: Russell King<rmk+kernel@arm.linux.org.uk>
> Cc: Jean Pihet<jean.pihet@newoldbits.com>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
This is a nice change. In general now omap3 suspend code
is looking much cleaner and after Jean's DDR patch, it would
be even better.

For this patch, my ack if you need one
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

