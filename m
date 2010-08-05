From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/6] TI816X: Update common OMAP machine specific sources
Date: Thu, 05 Aug 2010 06:48:53 -0700
Message-ID: <87wrs541bu.fsf@deeprootsystems.com>
References: <1280523112-25081-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39732 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab0HENs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 09:48:56 -0400
Received: by pzk26 with SMTP id 26so2451854pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 06:48:56 -0700 (PDT)
In-Reply-To: <1280523112-25081-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Sat, 31 Jul 2010 02:21:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch updates the common machine spcific source files with support for
> TI816X.
>
> Note that the nr_irqs is overridden in INTC driver since the number of IRQs on
> TI816X are different (128) comapared to other OMAPs (96).
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

One minor issue below...

[...]

> @@ -899,10 +899,10 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
>  
>  	/*
>  	 * XXX This should be removed once TI adds wakeup/sleep
> -	 * dependency code and data for OMAP4.
> +	 * dependency code and data for OMAP4, TI816X
>  	 */
> -	if (cpu_is_omap44xx()) {
> -		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
> +	if (cpu_is_omap44xx() || cpu_is_ti816x()) {
> +		WARN_ONCE(1, "clockdomain: wakeup/sleep dependency "
>  			  "support is not yet implemented\n");
>  	} else {
>  		if (atomic_read(&clkdm->usecount) > 0)
> @@ -941,9 +941,9 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
>  
>  	/*
>  	 * XXX This should be removed once TI adds wakeup/sleep
> -	 * dependency code and data for OMAP4.
> +	 * dependency code and data for OMAP4, TI816X.
>  	 */
> -	if (cpu_is_omap44xx()) {
> +	if (cpu_is_omap44xx() || cpu_is_ti816x()) {
>  		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "

Did you want to remove the 'OMAP4' here as you did in the hunk above?

Kevin
