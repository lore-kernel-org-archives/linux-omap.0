From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/5] ARM: OMAP2+: Display correct system timer name
Date: Fri, 1 Feb 2013 08:41:37 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED07255@DBDE01.ent.ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
 <1359565471-30721-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317Ab3BAIlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 03:41:44 -0500
In-Reply-To: <1359565471-30721-2-git-send-email-jon-hunter@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jan 30, 2013 at 22:34:27, Hunter, Jon wrote:
> Currently on boot, when displaying the name of the gptimer used for
> clockevents and clocksource timers, the timer ID is shown. However,
> when booting with device-tree, the timer ID is not used to select a
> gptimer but a timer property. Hence, it is possible that the timer
> selected when booting with device-tree does not match the ID shown.
> Therefore, instead display the HWMOD name of the gptimer and use
> the HWMOD name as the name of clockevent and clocksource timer (if a
> gptimer is used).
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |   44 +++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 72c2ca1..18cb856 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -71,6 +71,9 @@
>  #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET		0x14
>  #define NUMERATOR_DENUMERATOR_MASK			0xfffff000
>  
> +/* Timer name needs to be big enough to store a string of "timerXX" */
> +static char timer_name[10];
> +

Why not move this inside omap_dm_timer_init_one()?

Regards,
Vaibhav
