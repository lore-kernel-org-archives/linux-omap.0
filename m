From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 1/2]OMAP3: PM: To put all the powerdomains in OFF mode instead of Ret
Date: Fri, 14 May 2010 10:04:04 -0700
Message-ID: <877hn6mn3v.fsf@deeprootsystems.com>
References: <1273830555-19750-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48253 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab0ENREK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 13:04:10 -0400
Received: by gyg13 with SMTP id 13so1335417gyg.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 10:04:08 -0700 (PDT)
In-Reply-To: <1273830555-19750-1-git-send-email-shweta.gulati@ti.com> (shweta gulati's message of "Fri\, 14 May 2010 15\:19\:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shweta gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath BS <Vishwanath.bs@ti.com>

shweta gulati <shweta.gulati@ti.com> writes:

> From: Shweta Gulati <shweta.gulati@ti.com>
>
> According to Defect OMAPS00210499 CAM, DSS and USBHOST should stay
> in OFF state instead of Retention in OS Idle Path.

Please summarize the above defect.

> This Patch puts all the powerdomain in OFF state by default 
> in pm init code and ensures that Mpu next state is OFF only
> before it goes to Suspend/Idle and RET initiallly as that 
> could have caused system to hang if ROM code issues WFI.  

That's a long sentence that is not clear.  It attempts to explain
_what_ is happening, but is not clear about why.

IIUC, this same patch could be done with a one-liner patch[1]

> Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---

-EDOESNOTAPPLY

Please state what this patch applies to.  It does not apply to
mainline, linux-omap or the PM branch.  I see OSWR related code
in this patch which means it's clearly against an internal tree.

Because of that, I didn't read the rest of the patch.

Kevin

[1] 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5039b35..5b93a84 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -74,7 +74,7 @@ static inline bool is_suspending(void)
 #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
 
-u32 enable_off_mode;
+u32 enable_off_mode = 1;
 u32 sleep_while_idle;
 u32 wakeup_timer_seconds;
 u32 wakeup_timer_milliseconds;
