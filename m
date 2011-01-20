From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Thu, 20 Jan 2011 06:08:25 +0200
Message-ID: <20110120040825.GB2389@legolas.emea.dhcp.ti.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
 <20110118031038.GA2436@legolas.emea.dhcp.ti.com>
 <87d3nus4jr.fsf@gmail.com>
 <20110119034528.GA2406@legolas.emea.dhcp.ti.com>
 <874o947j9e.fsf@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49177 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755018Ab1ATEId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 23:08:33 -0500
Received: by yxe42 with SMTP id 42so49351yxe.23
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 20:08:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <874o947j9e.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 19, 2011 at 03:04:13PM -0500, Ben Gamari wrote:
> On Wed, 19 Jan 2011 05:45:28 +0200, Felipe Balbi <balbi@ti.com> wrote:
> > The point is, being able to disable features I don't want on my kernel
> > image, is completely valid, if there's a compile breakage, then fix the
> > breakage but don't prevent the board from compiling.
> > 
> I understand. That being said, Linus has made it well known that
> defconfigs will not be an option going forward. Have we found another

I never mentioned defconfigs here.

> means of selecting the basic drivers necessary to get a fully functional
> board? Perhaps a CONFIG_MACH_OMAP3_BEAGLE_CORE option selecting the
> necessary driver for a fully functional board would be a solution. I

I'll leave this for Tony to decide, but I don't like your proposal.

> remember this being discussed several months ago (when Linus started
> pulling defconfigs out of the tree), but I don't recall there being any
> replacement proposals. It should be possible to build a functional
> kernel from the mainline without iterating over all available
> configuration options.

So you're saying that when you're building a kernel for you
laptop/desktop you don't have to get a menuconfig and choose the drivers
you want to compile ? I dare to doubt that.

-- 
balbi
