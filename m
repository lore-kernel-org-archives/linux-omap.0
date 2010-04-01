From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV3 0/2] MPU/IVA bypass clock configuration
Date: Thu, 1 Apr 2010 03:15:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004010315000.27004@utopia.booyaka.com>
References: <> <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56166 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0DAJPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:15:52 -0400
In-Reply-To: <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Vishwanath,

On Thu, 1 Apr 2010, Vishwanath BS wrote:

> DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM
> UCs running DSP codec was earlier restricted as DSP crashed.
> The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> The solution is to make sure DPLL1/DPLL2 bypass clock is always less
> than maximum supported frequency for the specific OPP.
> Typically these settings are to be done in bootloaders.
> 
> All the patches have been tested on OMAP3630 ZOOM3  platform.
> Comments adressed in V3:
> 1. Used clk_set_rate API instead of directly writing to registers
> 2. Split the patch into 2 patches.
> 
> Vishwanath BS (4):
> 	OMAP3: Set MPU and IVA bypass Clock Divider
> 	OMAP3 PM: Set MPU and IVA bypass clock dividers in DVFS

On what tree do these patches apply?


- Paul
