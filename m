From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
Date: Tue, 30 Jul 2013 17:01:27 -0600
Message-ID: <51F845C7.8020106@wwwdotorg.org>
References: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org> <20130730225233.GF21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57452 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3G3XBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 19:01:31 -0400
In-Reply-To: <20130730225233.GF21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>

On 07/30/2013 04:52 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 30, 2013 at 04:49:18PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> DEBUG_UNCOMPRESS was previously disallowed for omap2plus due to
>> omap2plus.S's use of .data, which is not allowed in the decompressor.
>> Solve this by placing that data into .text when building the file into
>> the decompressor. This relies on .text actually being writable in the
>> decompressor, which it is in practice.
> 
> Unless you decide to use ZBOOT and flash the zImage.

I knew there had to be a catch:-)

I have no idea if ZBOOT is a use-case that's relevant to OMAP?

On Tegra at least (the same issue applies to the other patch I just
sent), that use-case is almost impossible; even if the boot ROM directly
booted a kernel, the boot ROM is hard-coded to copy whatever it's
booting to SDRAM first, although I suppose if that was a boot-loader it
could just jump back to a ROM location. That said, NOR flash is
extremely rare on Tegra. So, I don't know if we care about this issue.

Is it reasonable to just say "If you use ZBOOT, don't enable
DEBUG_UNCOMPRESS"? Perhaps these patches should not completely remove
the !DEBUG_TEGRA_UART from config DEBUG_UNCOMPRESS, but instead say:

default y if DEBUG_LL && (!DEBUG_TEGRA_UART || !ZBOOT)?
