From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/4] OMAP4: hwmod data: Add GPMC
Date: Mon, 1 Aug 2011 18:33:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108011831220.28427@utopia.booyaka.com>
References: <1309557267-27165-1-git-send-email-b-cousson@ti.com> <1309557267-27165-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49105 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab1HBAdT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 20:33:19 -0400
In-Reply-To: <1309557267-27165-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Add the GPMC hwmod data.
> 
> The GPMC hwmod does need the flags HWMOD_INIT_NO_IDLE and
> HWMOD_INIT_NO_RESET due to a bug described in the previous commit:
> 
>  OMAP4: clock: Keep GPMC clocks always enabled and hardware managed
> 
>  On OMAP4, CPU accesses on unmapped addresses are redirected to GPMC by
>  L3 interconnect. Because of CPU speculative nature, such accesses are
>  possible which can lead to indirect access to GPMC and if it's clock is
>  not running, it can result in hang/abort on the platform.
> 
>  Above makes access to GPMC unpredictable during the execution, so it's
>  module mode needs to be kept under hardware control instead of software
>  control.
>  Since the auto gating is supported for GPMC, there isn't any power impact
>  because of this change.
> 
>  The issue was un-covered with security middleware running along with HLOS.
>  In this case GPMC had a valid MMU descriptor on secure side where as HLOS
>  didn't map the GMPC because it isn't being used.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Looks to me like this patch would need to be accompanied by one that 
cleans up arch/arm/mach-omap2/gpmc.c.  The init code in that file messes 
around with the OCP_SYSCONFIG bits.  It also hardcodes a bunch of stuff 
that should be supplied by dynamic data.


- Paul
