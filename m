From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Fri, 28 Jan 2011 10:46:51 +0000
Message-ID: <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	 <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	 <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
	 <20110127185935.GA1651@n2100.arm.linux.org.uk>
	 <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
	 <20110128095953.GA13005@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:35147 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751482Ab1A1KrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 05:47:04 -0500
In-Reply-To: <20110128095953.GA13005@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2011-01-28 at 09:59 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 28, 2011 at 09:46:06AM +0000, Catalin Marinas wrote:
> > My point is that we may want SWP_EMULATE disabled (or depending on !
> > CPU_USE_DOMAINS). With domains enabled every read-only user page is
> > writeable by the kernel. This has the side-effect that SWP emulation
> > using LDREX/STREX breaks COW.
> 
> Yes, and maybe we should instead just enable the SWP instruction by default
> on ARMv7, and if SWP emulation is built, disable it at that point.

We can't disable the SWP instruction as long as domains are enabled (COW
not working for in-kernel STREX).

On ARMv7 we could always force R/O kernel/user pages in set_pte_ext
independent of the domains setting and have early_trap_init() use
vectors_page() if cpu_architecture() >= 7 (this would actually catch
ARM11MPCore as well because of the way we interpret CPUID).

-- 
Catalin


