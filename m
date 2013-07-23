From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
Date: Tue, 23 Jul 2013 07:04:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307230659430.27017@utopia.booyaka.com>
References: <1374556774-18795-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50418 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3GWHEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 03:04:30 -0400
In-Reply-To: <1374556774-18795-1-git-send-email-festevam@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux@arm.linux.org.uk, catalin.marinas@arm.com, rogerq@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Tue, 23 Jul 2013, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181 
> (TLBI/DSB operations)) causes the following undefined instruction error on a
> mx53 (Cortex-A8):
> 
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> CPU: 0 PID: 275 Comm: modprobe Not tainted 3.11.0-rc2-next-20130722-00009-g9b0f371 #881
> task: df46cc00 ti: df48e000 task.ti: df48e000
> PC is at check_and_switch_context+0x17c/0x4d0
> LR is at check_and_switch_context+0xdc/0x4d0
> 
> This problem happens because check_and_switch_context() calls 
> dummy_flush_tlb_a15_erratum() without checking if we are really running on a 
> Cortex-A15 or not. 
> 
> To avoid this issue, always check if we are running on a Cortex-A15 or not 
> (via erratum_a15_798181()) inside dummy_flush_tlb_a15_erratum(), so that we do 
> not need to keep doing the same check in all occurrences of 
> dummy_flush_tlb_a15_erratum().
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Nice work.  This fixes the v3.11-rc boot regression on most OMAP3/AM33xx 
devices.

Tested-by: Paul Walmsley <paul@pwsan.com> # for OMAP2,3,4,AM33xx



- Paul
