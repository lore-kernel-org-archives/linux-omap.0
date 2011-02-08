From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 17:58:14 +0100
Message-ID: <201102081758.14606.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <201102081617.59092.arnd@arndb.de> <20110208163229.GC6188@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50351 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1BHQ6T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 11:58:19 -0500
In-Reply-To: <20110208163229.GC6188@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Tuesday 08 February 2011 17:32:29 Russell King - ARM Linux wrote:
> On Tue, Feb 08, 2011 at 04:17:58PM +0100, Arnd Bergmann wrote:
> > On Tuesday 08 February 2011, Dave Martin wrote:
> > > CFLAGS_cpu_specific_object.o        += -march=armv7-a
> > > 
> > > Whether it's safe to do it depends on whether code from that file
> > > could ever get run on other processors.  I'm not so sure of the answer
> > > to that..., but perhaps someone else has a better idea.
> > 
> > We already do this a lot from arch/arm/mm/Makefile, and those
> > files are typically just one function per file, so they can easily
> > be proven to be safe that way.
> 
> No, we do that with assembly files.  It doesn't work soo well with
> C files as we really don't want GCC itself to generate v7 instructions
> unless we explicitly ask for them.
>
> The other issue here is that somtimes generating code with different
> -march options leads to the linker refusing to link them together...

Ok, I see. Is that a bug in existing toolchains, or something more
fundamental?

I would have expected that you could at least mix all compiler options
that don't impact the ABI or the instruction set like -mthumb.

Also, I think we can still build with e.g. "-march=armv6 -Wa,-march=armv7",
which should tell the compiler to only emit armv6 instructions, but make
the assembler more permissive for inline assembly.

	Arnd
