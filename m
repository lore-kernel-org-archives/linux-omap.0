From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/13] dmtimer: hwmod: OMAP: rev field to identify timer
 version
Date: Mon, 16 Aug 2010 13:59:56 +0200
Message-ID: <4C69283C.5050807@ti.com>
References: <1281800301-15210-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49373 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab0HPMAF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 08:00:05 -0400
In-Reply-To: <1281800301-15210-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Hi Tarun,

You series is missing the omap4 hwmod data. You should rebase it on the 
latest pm_wip/hwmods-omap4 and add the hwmod data for the timers.

For further details please read this:
http://www.spinics.net/lists/linux-omap/msg34700.html


On 8/14/2010 5:38 PM, DebBarma, Tarun Kanti wrote:
> This patch adds revision (.rev) to hwmod class to identify different
> timer types. In the present implementation it is used to identify
> millisecond timers, legacy timers and highlander timers present in
> OMAP4. This identification serves following purposes:
> (1) select appropriate timers register maps associated with legacy
> ip timers and highlander ip timers present on OMAP4.
> (2) select millisecond timers to perform specific operations upon
> them during _probe()
>
> Signed-off-by: Partha Basak<p-basak2@ti.com>
> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
>   arch/arm/plat-omap/include/plat/dmtimer.h  |    5 +++++
>   3 files changed, 11 insertions(+), 0 deletions(-)
>   mode change 100644 =>  100755 arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>   mode change 100644 =>  100755 arch/arm/plat-omap/include/plat/dmtimer.h
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 6b9e7a1..98fcf3d 100755
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -17,6 +17,7 @@
>   #include<mach/irqs.h>
>   #include<plat/cpu.h>
>   #include<plat/dma.h>
> +#include<plat/dmtimer.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -115,6 +116,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
>   static struct omap_hwmod_class omap3xxx_timer_1ms_hwmod_class = {
>   	.name = "timer_1ms",
>   	.sysc =&omap3xxx_timer_1ms_sysc,
> +	.rev = OMAP_TIMER_MILLISECOND,
>   };
>
>
> @@ -131,6 +133,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
>   static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
>   	.name = "timer",
>   	.sysc =&omap3xxx_timer_sysc,
> +	.rev =  OMAP_TIMER_IP_LEGACY,
>   };
>
>   /* timer10 */
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 9736a49..c5478f7
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -22,6 +22,7 @@
>
>   #include<plat/omap_hwmod.h>
>   #include<plat/cpu.h>
> +#include<plat/dmtimer.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -4339,6 +4340,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
>   static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
>   	.name = "timer_1ms",
>   	.sysc =&omap44xx_timer_1ms_sysc,
> +	.rev = OMAP_TIMER_MILLISECOND,

That information is redundant, you already know from the class that this 
is a 1ms timer.
If you need to get that information from the driver, you can set this 
settings in device data using the class name at device init time.

Moreover, this rev field is supposed to contain the revision per class 
so in your case it should contain OMAP_TIMER_IP_LEGACY.

>   };
>
>   static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
> @@ -4353,6 +4355,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
>   static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
>   	.name = "timer",
>   	.sysc =&omap44xx_timer_sysc,
> +	.rev = OMAP_TIMER_IP_VERSION_2,
>   };
>
>   /* timer1 */
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 20f1054..2926dc6
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -44,6 +44,11 @@
>   #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
>   #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
>
> +/* timer ip constants */
> +#define OMAP_TIMER_MILLISECOND			0x0
> +#define OMAP_TIMER_IP_LEGACY			0x1

Legacy is not very meaningful, you'd better use VERSION_1 in that case.

Benoit

> +#define OMAP_TIMER_IP_VERSION_2			0x2
> +
>   struct omap_dm_timer;
>   struct clk;
>

