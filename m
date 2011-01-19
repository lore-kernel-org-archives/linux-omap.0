From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Wed, 19 Jan 2011 15:04:13 -0500
Message-ID: <874o947j9e.fsf@gmail.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com> <20110118031038.GA2436@legolas.emea.dhcp.ti.com> <87d3nus4jr.fsf@gmail.com> <20110119034528.GA2406@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46484 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab1ASUEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 15:04:21 -0500
Received: by qyk12 with SMTP id 12so1331364qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 12:04:21 -0800 (PST)
In-Reply-To: <20110119034528.GA2406@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 19 Jan 2011 05:45:28 +0200, Felipe Balbi <balbi@ti.com> wrote:
> The point is, being able to disable features I don't want on my kernel
> image, is completely valid, if there's a compile breakage, then fix the
> breakage but don't prevent the board from compiling.
> 
I understand. That being said, Linus has made it well known that
defconfigs will not be an option going forward. Have we found another
means of selecting the basic drivers necessary to get a fully functional
board? Perhaps a CONFIG_MACH_OMAP3_BEAGLE_CORE option selecting the
necessary driver for a fully functional board would be a solution. I
remember this being discussed several months ago (when Linus started
pulling defconfigs out of the tree), but I don't recall there being any
replacement proposals. It should be possible to build a functional
kernel from the mainline without iterating over all available
configuration options.

- Ben
