From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
 DVFS+SR operation
Date: Fri, 4 Dec 2009 11:06:11 -0800
Message-ID: <20091204190611.GG24013@atomide.com>
References: <1259918576-31870-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60476 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbZLDTGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 14:06:06 -0500
Content-Disposition: inline
In-Reply-To: <1259918576-31870-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

* Vishwanath BS <vishwanath.bs@ti.com> [091204 01:20]:
> From: Shweta Gulati <shweta.gulati@ti.com>
> 
> DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM UCs
> running DSP codec was earlier restricted as DSP crashed.
> The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2. 
> The workaround is:
> 	For DPLL2 (DSP) select CORECLK/4 as DPLL2 bypass clock for 3430.
> 	Select CORECLK/2 as DPLL2 bypass clock for 3630.
> During DPLL2 relock phase, DSP clock will be 83MHz/200MHz which is always OK
> irrespective of Vdd1 voltage.
> For DPLL1 (MPU), prior to any DVFS transition to OPP1, select CORECLK/4
> 	(CORECLK/2 for 3630) as DPLL1 bypass clock.
> 	For other OPPs select CORECLK/2 (CORECLK/1 for 3630) as DPLL1 bypass
> 	clock.
> These configurations are typically set in bootloader. However bootloaders may 
> mess up configuration and kernel with this chang ensures that system is in a 
> known state.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++--
>  arch/arm/mach-omap2/pm34xx.c          |   19 +++++++++++++++++++
>  arch/arm/mach-omap2/resource34xx.c    |   20 ++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/cm-regbits-34xx.h
>  mode change 100644 => 100755 arch/arm/mach-omap2/pm34xx.c
>  mode change 100644 => 100755 arch/arm/mach-omap2/resource34xx.c

This mode change stuff does not look right.

Tony
