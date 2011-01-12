From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/0] RFC: ARM: Thumb-2: Symbol manipulation macros for
	function body copying
Date: Wed, 12 Jan 2011 09:32:09 +0000
Message-ID: <20110112093209.GA18833@n2100.arm.linux.org.uk>
References: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33517 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab1ALJcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 04:32:24 -0500
Content-Disposition: inline
In-Reply-To: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Jan 11, 2011 at 06:02:30PM -0600, Dave Martin wrote:
> To make it easier to deal with cases like this, I've had a
> go at writing some macros to make copying function bodies
> easier, while being robust for ARM and Thumb-2.

How about instead providing some infrastructure which coes the
copy too?  Something like:

#define copy_fn_to_sram(to, fn, size) ({		\
	__typeof__(fn) f;				\
	unsigned long ptr;				\
	__asm__("" : "=r" (ptr) : "0" (fn));		\
	memcpy(to, (void *)(ptr & ~1), size);		\
	ptr = (ptr & 1) | (unsigned long)to;		\
	__asm__("" : "=r" (f) : "0" (ptr));		\
	f;						\
})

Used by:
extern void my_func(int foo);
extern int my_func_size;

void call_my_func(void *to, int arg)
{
	void (*fn)(int);

	fn = copy_fn_to_sram(to, my_func, my_func_size);
	fn(arg);
}

Then if you need to fix the way the copies are done for some
architectural reason, there's only one place to do it.

I'm not sure asm/unified.h is the right place - I don't think this has
anything to do with the unified assembler syntax.  Please create a new
header for this.
