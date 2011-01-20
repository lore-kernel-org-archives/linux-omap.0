From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to speed-up
 boot
Date: Thu, 20 Jan 2011 09:14:29 -0600
Message-ID: <4D385155.4050301@gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35218 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab1ATPOg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 10:14:36 -0500
Received: by ywl5 with SMTP id 5so194091ywl.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 07:14:35 -0800 (PST)
In-Reply-To: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On 01/20/2011 03:42 AM, Santosh Shilimkar wrote:
> On some architectures, secondary cores shares clock with primiary
> core and hence scale together. Hence secondary core lpj calibration
> is not necessary and can be skipped to save considerable time.
>
> This can speed up the secondary cpu boot and hotplug cpu online
> paths.
>
> Discussion thread:
> 	http://www.spinics.net/lists/arm-kernel/msg111124.html
>

There's already one way to do this with pre-calculated lpj.

Also, this isn't multi-platform friendly. You could accomplish the same 
thing using the clock api to get the core frequency of each core and 
only calculate lpj if the frequency is different.

Rob
