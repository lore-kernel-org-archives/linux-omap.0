From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Wed, 06 Aug 2008 10:53:48 +0100
Message-ID: <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:34075 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755250AbYHFJyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 05:54:16 -0400
In-Reply-To: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, r-woodruff2@ti.com

On Mon, 2008-08-04 at 17:40 -0600, Paul Walmsley wrote:
> Add the MT_MEMORY_STRONGLY_ORDERED memory type for ARM strongly ordered
> memory.
> 
> This is used on OMAP3 for on-board SRAM.  On OMAP, SRAM is used for code 
> that changes the SDRAM controller's clock, temporarily blocking access to 
> SDRAM.  During this period, as code executes from SRAM, the ARM cache 
> controller can attempt to write dirty cache lines back to SDRAM to make 
> room for SRAM cache lines, causing the MPU subsystem to hang.  To avoid 
> this, we mark SRAM as strongly- ordered memory.

Why not use normal uncached memory? Strongly ordered is pretty
inefficient as it cannot do any reordering or write buffer merging (it's
like having a memory barrier before and after each instruction).
Speculative accesses are not allowed either. Strongly ordered memory is
not really meant for executing code from.

> +	[MT_MEMORY_STRONGLY_ORDERED] = {
> +		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE |
> +				PMD_SECT_UNCACHED,

You can add PMD_SECT_TEX(1) for normal uncached memory.

-- 
Catalin

