From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and
	CPU_V7
Date: Fri, 19 Feb 2010 08:35:56 +0000
Message-ID: <20100219083556.GB19649@n2100.arm.linux.org.uk>
References: <20100219002748.GB21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49833 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0BSIgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 03:36:08 -0500
Content-Disposition: inline
In-Reply-To: <20100219002748.GB21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Feb 18, 2010 at 04:27:48PM -0800, Tony Lindgren wrote:
> @@ -779,5 +779,5 @@ config CACHE_XSC3L2
>  
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> +	default 6 if (ARCH_OMAP3 || ARCH_S5PC1XX) && !ARCH_OMAP2
>  	default 5

This one is definitely wrong.  Setting the L1 cache line size larger
than it actually is should be safe; setting it smaller is definitely
unsafe.
