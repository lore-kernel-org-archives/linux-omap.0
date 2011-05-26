From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/13] OMAP2+: PM: export suspend_set_ops to PM modules
Date: Thu, 26 May 2011 16:09:47 -0700
Message-ID: <87lixt9hz8.fsf@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-10-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44127 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932515Ab1EZXJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 19:09:50 -0400
Received: by mail-pv0-f181.google.com with SMTP id 13so613399pvg.40
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 16:09:49 -0700 (PDT)
In-Reply-To: <1305739950-11695-10-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 18 May 2011 19:32:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Export the suspend_set_ops API as omap_pm_suspend_set_ops in the pm
> generic code, under CONFIG_SUSPEND.
>
> Note -hack warning-: since the 'suspend_valid_only_mem' function is
> not exported to modules, fill the 'valid' field value of
> 'struct platform_suspend_ops' in the common code.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Can you try the patch below instead?    If that works, I'll submit to
Rafael/linux-pm.

Kevin

>From d3aca6317f5f92a5fd4fbaf1d039232c83cac4f4 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 26 May 2011 16:10:13 -0700
Subject: [PATCH] PM: export suspend_set_ops, suspend_valid_only_mem

Some platforms wish to implement their PM core code as modules.  To
do so, these functions need to be exported for modules.

Reported-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 kernel/power/suspend.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6275970..eca495d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -44,6 +44,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
 	suspend_ops = ops;
 	mutex_unlock(&pm_mutex);
 }
+EXPORT_SYMBOL(suspend_set_ops);
 
 bool valid_state(suspend_state_t state)
 {
@@ -65,6 +66,7 @@ int suspend_valid_only_mem(suspend_state_t state)
 {
 	return state == PM_SUSPEND_MEM;
 }
+EXPORT_SYMBOL(suspend_valid_only_mem);
 
 static int suspend_test(int level)
 {
-- 
1.7.4

