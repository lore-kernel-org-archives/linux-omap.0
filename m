From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Fri, 8 Jun 2012 16:22:53 +0300
Message-ID: <1339161773.2091.49.camel@sokoban>
References: <20120607060901.25532.68354.stgit@dusk>
	 <20120607061309.25532.13430.stgit@dusk>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42356 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2FHNXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jun 2012 09:23:01 -0400
In-Reply-To: <20120607061309.25532.13430.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Paul,

There's a bug in this patch, see below.

<clip>

>  {
> @@ -1141,8 +1143,26 @@ static void _enable_sysc(struct omap_hwmod *oh)
>  	sf = oh->class->sysc->sysc_flags;
>  
>  	if (sf & SYSC_HAS_SIDLEMODE) {
> -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> +		if (oh->flags & HWMOD_SWSUP_SIDLE) {
> +			/*
> +			 * IP blocks without smart idle should be left
> +			 * in force-idle.  Currently this only applies
> +			 * to 32k sync "timer" which is guaranteed to
> +			 * be accessible when the kernel is running.
> +			 * HWMOD_SWSUP_IDLE must also be set on these
> +			 * IP blocks to indicate a hardware problem.
> +			 * XXX Not an ideal workaround.
> +			 */
> +			if (oh->class->sysc->idlemodes &
> +			    (SIDLE_NO | SIDLE_FORCE) &&
> +			    !(oh->class->sysc->idlemodes &
> +			      (SIDLE_SMART || SIDLE_SMART_WKUP)))

There should by binary or, not logical here.

-Tero


