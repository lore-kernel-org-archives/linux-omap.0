From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Thu, 27 Jan 2011 18:14:56 +0000
Message-ID: <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53167 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1A0SO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 13:14:56 -0500
Received: by iyj18 with SMTP id 18so1725116iyj.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 10:14:56 -0800 (PST)
In-Reply-To: <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 17 January 2011 19:24, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Rather than turning off CPU domain switching when the build architecture
> includes ARMv6K, thereby causing problems for ARMv6-supporting kernels,
> turn it on when it's required to support a CPU architecture.

(sorry, I'm well behind list messages, didn't reply earlier)

Does it mean that we get domains enabled even for ARMv7 when ARMv6 is
built in the same kernel? The side effect is that user read-only
addresses are writable by the kernel and SWP emulation no longer
works.

-- 
Catalin
