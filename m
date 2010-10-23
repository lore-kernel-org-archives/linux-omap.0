From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix data abort accessing proc_info from
	__lookup_processor_type (Re: [PATCH 03/10] ARM: hotplug cpu: Keep
	processor information, startup code & __lookup_processor_type)
Date: Sat, 23 Oct 2010 09:30:45 +0100
Message-ID: <20101023083044.GA13009@n2100.arm.linux.org.uk>
References: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk> <20101022185108.GF17595@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41890 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab0JWIbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 04:31:00 -0400
Content-Disposition: inline
In-Reply-To: <20101022185108.GF17595@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>

On Fri, Oct 22, 2010 at 11:51:08AM -0700, Tony Lindgren wrote:
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 1953e3d..a58b91d 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -114,6 +114,7 @@ SECTIONS
>  			*(.glue_7)
>  			*(.glue_7t)
>  		*(.got)			/* Global offset table		*/
> +			. = ALIGN(4);
>  			ARM_CPU_KEEP(PROC_INFO)

The got table should also be word aligned - but the kernel doesn't use
one.  In any case, it would be a good idea to place it before the .got.
