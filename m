From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 14/14] omap: mailbox: reorganize headers
Date: Mon, 24 May 2010 20:16:34 +0300
Message-ID: <20100524171634.GA23202@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
 <1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49608 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025Ab0EXRQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 13:16:35 -0400
Content-Disposition: inline
In-Reply-To: <1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>

Hi,

On Sat, May 22, 2010 at 07:14:25PM +0200, ext Felipe Contreras wrote:
>Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>---
> arch/arm/mach-omap1/mailbox.c             |    3 ---
> arch/arm/mach-omap2/mailbox.c             |    1 -
> arch/arm/plat-omap/include/plat/mailbox.h |    3 ++-
> arch/arm/plat-omap/mailbox.c              |    5 ++---
> 4 files changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
>index e50b3c2..fdd6cc9 100644
>--- a/arch/arm/mach-omap1/mailbox.c
>+++ b/arch/arm/mach-omap1/mailbox.c
>@@ -9,13 +9,10 @@
>  * for more details.
>  */
>
>-#include <linux/kernel.h>
>-#include <linux/resource.h>
> #include <linux/interrupt.h>
> #include <linux/platform_device.h>
> #include <linux/io.h>
> #include <plat/mailbox.h>
>-#include <mach/irqs.h>
>
> #define MAILBOX_ARM2DSP1		0x00
> #define MAILBOX_ARM2DSP1b		0x04
>diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>index 66d366d..d46e439 100644
>--- a/arch/arm/mach-omap2/mailbox.c
>+++ b/arch/arm/mach-omap2/mailbox.c
>@@ -10,7 +10,6 @@
>  * for more details.
>  */
>
>-#include <linux/kernel.h>
> #include <linux/clk.h>
> #include <linux/err.h>
> #include <linux/platform_device.h>
>diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
>index c44fde3..9976565 100644
>--- a/arch/arm/plat-omap/include/plat/mailbox.h
>+++ b/arch/arm/plat-omap/include/plat/mailbox.h
>@@ -3,9 +3,10 @@
> #ifndef MAILBOX_H
> #define MAILBOX_H
>
>-#include <linux/wait.h>
>+#include <linux/spinlock.h>
> #include <linux/workqueue.h>
> #include <linux/interrupt.h>
>+#include <linux/device.h>
> #include <linux/kfifo.h>
>
> typedef u32 mbox_msg_t;
>diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>index a8e22e1..8d4c7be 100644
>--- a/arch/arm/plat-omap/mailbox.c
>+++ b/arch/arm/plat-omap/mailbox.c
>@@ -21,10 +21,9 @@
>  *
>  */
>
>-#include <linux/kernel.h>
>-#include <linux/module.h>
> #include <linux/interrupt.h>
>-#include <linux/device.h>
>+#include <linux/spinlock.h>
>+#include <linux/mutex.h>
> #include <linux/delay.h>
> #include <linux/slab.h>
> #include <linux/kfifo.h>

personally I don't like this patch since it makes the C-sources rely on 
indirect header inclusion by another header. That's really error prone 
and will cause build failures if someone decides to remove the include 
<linux/device.h> from plat/mailbox.h.

Those headers are safe against multiple inclusions and I think they 
should be included directly in all source files (header or not) that 
need any symbols from it.

-- 
balbi

DefectiveByDesign.org
