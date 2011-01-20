From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Thu, 20 Jan 2011 16:44:42 -0500
Message-ID: <8739ondzcl.fsf@gmail.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com> <20110118031038.GA2436@legolas.emea.dhcp.ti.com> <87d3nus4jr.fsf@gmail.com> <20110119034528.GA2406@legolas.emea.dhcp.ti.com> <874o947j9e.fsf@gmail.com> <20110120040825.GB2389@legolas.emea.dhcp.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42368 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab1ATVra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 16:47:30 -0500
Received: by qyj19 with SMTP id 19so2444694qyj.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 13:47:29 -0800 (PST)
In-Reply-To: <20110120040825.GB2389@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--text follows this line--
On Thu, 20 Jan 2011 06:08:25 +0200, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Jan 19, 2011 at 03:04:13PM -0500, Ben Gamari wrote:
> > I understand. That being said, Linus has made it well known that
> > defconfigs will not be an option going forward. Have we found another
> 
> I never mentioned defconfigs here.
> 
Certainly, I was trying to point out that there is no good way to
package a configuration for a given board, which definitely increases
the learning curve for a board integrator.

> > means of selecting the basic drivers necessary to get a fully functional
> > board? Perhaps a CONFIG_MACH_OMAP3_BEAGLE_CORE option selecting the
> > necessary driver for a fully functional board would be a solution. I
> 
> I'll leave this for Tony to decide, but I don't like your proposal.
> 
Fair enough.

> So you're saying that when you're building a kernel for you
> laptop/desktop you don't have to get a menuconfig and choose the drivers
> you want to compile ? I dare to doubt that.
> 
On the whole x86 hardware is far more uniform than ARM hardware. There
is a good reason why there used to be so many defconfigs for ARM in the tree.

Cheers,

- Ben
