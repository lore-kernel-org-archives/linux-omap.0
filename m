From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V2 7/7] ARM: OMAP: Add DT support for timer driver
Date: Wed, 19 Sep 2012 19:19:10 -0500
Message-ID: <505A60FE.3050105@gmail.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com> <1347579091-3794-8-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44870 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2ITATO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 20:19:14 -0400
Received: by obbuo13 with SMTP id uo13so943345obb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 17:19:13 -0700 (PDT)
In-Reply-To: <1347579091-3794-8-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>



On 09/13/2012 06:31 PM, Jon Hunter wrote:
> In order to add device-tree support to the timer driver the following changes
> were made ...
> 
> 1. Allocate system timers (used for clock-events and clock-source) based upon
>    timer properties rather than using an hard-coded timer instance ID. To allow
>    this a new helper function called omap_dmtimer_find_by_property() has been
>    added for finding a timer with the particular properties in the device-tree
>    blob. Please note that this is an internal helper function for system timers
>    only to find a timer in the device-tree blob. This cannot be used by device
>    drivers, another API has been added for that (see below). Timers that are
>    allocated for system timers are dynamically disabled at boot time by adding
>    a status property with the value "disabled" to the timer's device-tree node.
> 
>    Please note that when allocating system timers we now pass a timer ID and
>    timer property. The timer ID is only be used for allocating a timer when
>    booting without device-tree. Once device-tree migration is complete, all
>    the timer ID references will be removed.
> 
> 2. If DT blob is present, then let device-tree create the timer devices
>    dynamically.
> 
> 3. When device-tree is present the "id" field in the platform_device structure
>    (pdev->id) is initialised to -1 and hence cannot be used to identify a timer
>    instance. Due to this the following changes were made ...
>    a). The API omap_dm_timer_request_specific() is not supported when using
>        device-tree, because it uses the device ID to request a specific timer.
>        This function will return an error if called when device-tree is present.
>        Users of this API should use omap_dm_timer_request_by_cap() instead.
>    b). When removing the DMTIMER driver, the timer "id" was used to identify the
>        timer instance. The remove function has been modified to use the device
>        name instead of the "id".
> 
> 4. When device-tree is present the platform_data structure will be NULL and so
>    check for this.
> 
> 5. The OMAP timer device tree binding has the following optional parameters ...
>    a). ti,timer-alwon  --> Timer is in an always-on power domain
>    b). ti,timer-dsp    --> Timer can generate an interrupt to the on-chip DSP
>    c). ti,timer-pwm    --> Timer can generate a PWM output
>    d). ti,timer-secure --> Timer is reserved on a secure OMAP device
>    Search for the above parameters and set the appropriate timer attribute
>    flags.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---

Looks pretty good from a DT perspective. I won't try to understand the
omap timer code. One comment though.

>  arch/arm/mach-omap2/timer.c  |   96 +++++++++++++++++++++++++++++++++---------
>  arch/arm/plat-omap/dmtimer.c |   41 +++++++++++++++---
>  2 files changed, 112 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 60d43c8..d1c7771 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -58,16 +58,20 @@
>  #define OMAP3_32K_SOURCE	"omap_32k_fck"
>  #define OMAP4_32K_SOURCE	"sys_32k_ck"
>  
> +#define TIMER_PROP_ALWON	"ti,timer-alwon"
> +

It would be easier to follow the code if you use the strings directly
(and you do in some places).

>  #ifdef CONFIG_OMAP_32K_TIMER
>  #define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
>  #define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
>  #define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
>  #define OMAP3_SECURE_TIMER	12
> +#define TIMER_PROP_SECURE	"ti,timer-secure"
>  #else
>  #define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
>  #define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
>  #define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
>  #define OMAP3_SECURE_TIMER	1
> +#define TIMER_PROP_SECURE	TIMER_PROP_ALWON
>  #endif
>  
