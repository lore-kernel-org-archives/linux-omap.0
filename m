From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH v5 3/5] omap3: pm: Generic TRITON power scripts for
	OMAP3 based boards
Date: Mon, 10 May 2010 17:30:43 +0300
Message-ID: <20100510143043.GA4703@codecarver.research.nokia.com>
References: <1271677408-2143-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27810 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab0EJObz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 10:31:55 -0400
Content-Disposition: inline
In-Reply-To: <1271677408-2143-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Lesly A M <leslyam@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Apr 19, 2010 at 01:43:28PM +0200, ext Lesly A M wrote:
> This pacth will create the generic TRITON power scripts which can be used
> by different OMAP3 boards with the same power companion chip (TWL4030 series).
> 
> Added the api(twl4030_get_scripts/twl4030_get_vc_timings) to update
> the sleep/wakeup/warm_rest sequence & voltsetup_time in the board file.
> 

any reason why you use a different type for the messages sent for P3 and P1/P2
transitions ?

> +/*
> + * Sequence to control the TRITON Power resources,
> + * when the system goes into sleep.
> + * Executed upon P1_P2/P3 transition for sleep.
> + */
> +static struct twl4030_ins __initdata sleep_on_seq[] = {
> +	/* Broadcast message to put res to sleep */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +							RES_STATE_SLEEP), 2},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_SLEEP), 2},
> +};
> +
> +static struct twl4030_script sleep_on_script __initdata = {
> +	.script	= sleep_on_seq,
> +	.size	= ARRAY_SIZE(sleep_on_seq),
> +	.flags	= TWL4030_SLEEP_SCRIPT,
> +};
> +
> +/*
> + * Sequence to control the TRITON Power resources,
> + * when the system wakeup from sleep.
> + * Executed upon P1_P2 transition for wakeup.
> + */
> +static struct twl4030_ins wakeup_p12_seq[] __initdata = {
> +	/* Broadcast message to put res to active */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +							RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wakeup_p12_script __initdata = {
> +	.script	= wakeup_p12_seq,
> +	.size	= ARRAY_SIZE(wakeup_p12_seq),
> +	.flags	= TWL4030_WAKEUP12_SCRIPT,
> +};

Cheers,

Peter.

-- 
goa is a state of mind
