From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/5] ARM: GIC: provide a single initialization function
 for boot CPU
Date: Sun, 5 Dec 2010 21:45:23 +0000
Message-ID: <AANLkTikRW3ScQBoSPetNvCLuZ0oA3BvuHB5JqigNhMOi@mail.gmail.com>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCrC-0004xO-Fs@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56531 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab0LEVpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 16:45:24 -0500
In-Reply-To: <E1PPCrC-0004xO-Fs@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Daniel Walker <dwalker@codeaurora.org>, linux-tegra@vger.kernel.org, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, Anton Vorontsov <avorontsov@mvista.com>, linux-samsung-soc@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, David Brown <davidb@codeaurora.org>

On 5 December 2010 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Provide gic_init() which initializes the GIC distributor and current
> CPU's GIC interface for the boot (or single) CPU.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
