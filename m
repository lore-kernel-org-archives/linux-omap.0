From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1 v2] ARM: Thumb-2: Symbol manipulation macros for
	function body copying
Date: Thu, 13 Jan 2011 23:55:24 +0000
Message-ID: <20110113235524.GB28040@n2100.arm.linux.org.uk>
References: <1294951905-23748-1-git-send-email-dave.martin@linaro.org> <1294951905-23748-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56063 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1AMXzj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 18:55:39 -0500
Content-Disposition: inline
In-Reply-To: <1294951905-23748-2-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Thu, Jan 13, 2011 at 02:51:45PM -0600, Dave Martin wrote:
> +/* Cast function pointer to integer: */
> +#define __funcp_to_uint(funcp) ({				\

uint is confusing here - it suggests casting a pointer to an unsigned int,
rather than a uintptr_t.  Please use uintptr here.

> +/*
> + * FSYM_REBASE: Determine the correct function pointer for funcp,
> + * after the function has been copied to dest_buf:
> + */
> +#define FSYM_REBASE(funcp, dest_buf)					\
> +	__uint_to_funcp((uintptr_t)(dest_buf) | FSYM_TYPE(funcp), funcp)
> +
> +/*
> + * FSYM_BASE: Determine the base address in memory of the function funcp
> + * FSYM_TYPE: Determine the instruction set type (ARM/Thumb) of funcp
> + * (both defined below)
> + */
> +
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define FSYM_BASE(funcp) ((void *)(__funcp_to_uint(funcp) & ~(uintptr_t)1))
> +#define FSYM_TYPE(funcp) (__funcp_to_uint(funcp) & 1)
> +#else /* !CONFIG_THUMB2_KERNEL */
> +#define FSYM_BASE(funcp) ((void *)__funcp_to_uint(funcp))
> +#define FSYM_TYPE(funcp) 0
> +#endif /* !CONFIG_THUMB2_KERNEL */

I'd really like to see these gone - otherwise they'll end up being used
in code inappropriately.  I like things to be kept as simple as possible
with as few opportunities for people to needlessly hook into internal
implementation details.

If you expose implementation details, people will use them, and then if
you need to change the implementation, you've got a lot of code to deal
with.

I don't think we need to make this conditional on THUMB2 either - we're
probably not wasting much by always clearing and copying the LSB.  And
this isn't particularly performance code.
