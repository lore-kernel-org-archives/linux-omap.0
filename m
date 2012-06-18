From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Bringing back gptimer_wakeup
Date: Mon, 18 Jun 2012 15:30:52 +0530
Message-ID: <CAMQu2gwvSMNBr54t3jKsnSbkLKEscGuPFac-ywuruktosWjPgA@mail.gmail.com>
References: <4FDEF24C.8020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:43733 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234Ab2FRKBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 06:01:16 -0400
Received: by qcmv28 with SMTP id v28so3817353qcm.39
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 03:01:12 -0700 (PDT)
In-Reply-To: <4FDEF24C.8020305@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jun 18, 2012 at 2:48 PM, Tasslehoff Kjappfot
<tasskjapp@gmail.com> wrote:
> The support for using a timer to wake from suspend was removed in:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=98e182a26bbbf5575457622337684ef61493e864
>
> I found an alternative patch
> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47836.html) that
> claimed to keep it working using GPTIMER1 instead, but I haven't been able
> to make it work (likely because the timer code has changed a good deal since
> the patch was posted).
>
> Anyone got
> a) a patch that enables this feature on newer kernels, or
> b) an idea how the patch above can be made to work?
>
I had one working against 3.4. may be you can try this out and see it helps.

Regards
Santosh

---
 arch/arm/mach-omap2/pm-debug.c |    5 +++++
 arch/arm/mach-omap2/timer.c    |   12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 814bcd9..8f59a70 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -39,6 +39,7 @@
 #include "pm.h"

 u32 enable_off_mode;
+u32 wakeup_timer_seconds = 0;

 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -276,6 +277,10 @@ static int __init pm_dbg_init(void)

 	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
 				   &enable_off_mode, &pm_dbg_option_fops);
+
+	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUSR, d,
+				   &wakeup_timer_seconds, &pm_dbg_option_fops);
+
 	pm_dbg_init_done = 1;

 	return 0;
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b28ea5e..31a0628 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -82,6 +82,9 @@
 #define MAX_GPTIMER_ID		12

 static u32 sys_timer_reserved;
+#ifdef CONFIG_PM_DEBUG
+extern u32	wakeup_timer_seconds;
+#endif

 /* Clockevent code */

@@ -138,6 +141,15 @@ static void omap2_gp_timer_set_mode(enum
clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
+#ifdef CONFIG_PM_DEBUG
+		if (wakeup_timer_seconds) {
+			__omap_dm_timer_write(&clkev, OMAP_TIMER_LOAD_REG,
+			0xffffffff - (clkev.rate * wakeup_timer_seconds), 1);
+			__omap_dm_timer_load_start(&clkev, OMAP_TIMER_CTRL_ST,
+			0xffffffff - (clkev.rate * wakeup_timer_seconds), 1);
+		}
+#endif
+		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
 	}
-- 
1.7.9.5
