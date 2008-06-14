From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/21] ARM: OMAP: DMTimer: Optimize by adding load and start
Date: Sat, 14 Jun 2008 09:20:29 +0100
Message-ID: <20080614082028.GM32122@flint.arm.linux.org.uk>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41232 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbYFNIUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 04:20:41 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>

On Fri, Jun 06, 2008 at 06:30:34PM -0700, Tony Lindgren wrote:
> From: Richard Woodruff <r-woodruff2@ti.com>
> 
> This patch optimizes the timer load and start sequence.  By combining the
> load and start a needless posted wait can be removed from the system timer
> execution path.
> 
> * Before patch register writes are taking up .078% @ 500MHz during idle.
> 
>  Address                 |total  |min  |max      |avr     |count|ratio%
>  old\process\default_idle|7.369s |0.0us|999.902ms|14.477ms|509. |62.661%
>  ld\Global\cpu_v7_do_idle|4.265s |0.0us|375.786ms|24.374ms|175. |36.270%
>                 (UNKNOWN)|17.503ms|0.us|531.080us|5.119us|3419. |0.148%
>  r\omap_dm_timer_set_load|8.135ms|0.0us|79.887us|15.065us|540.  |0.069% <--
>  \vmlinux-old\Global\_end|2.023ms|0.0us|4.000us|0.560us|3613.   |0.017%
>  -old\Global\__raw_readsw|1.962ms|0.0us|108.610us|9.167us|214.  |0.016%
>  old\smc91x\smc_interrupt|1.353ms|0.0us|10.212us|2.348us|576.   |0.011%
>  s/namei\__link_path_walk|1.161ms|0.0us|4.310us|0.762us|  1524. |0.009%
>  \omap_dm_timer_write_reg|1.085ms|0.0us|126.150us|2.153us|504.  |0.009% <--
> 
> * After patch timer functions do not show up in top listings for long captures.

Ok.  Not for -rc.
