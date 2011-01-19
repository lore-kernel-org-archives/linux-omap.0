From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Wed, 19 Jan 2011 05:45:28 +0200
Message-ID: <20110119034528.GA2406@legolas.emea.dhcp.ti.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
 <20110118031038.GA2436@legolas.emea.dhcp.ti.com>
 <87d3nus4jr.fsf@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:54513 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752699Ab1ASDpj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 22:45:39 -0500
Received: by yws5 with SMTP id 5so104853yws.16
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 19:45:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87d3nus4jr.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 18, 2011 at 08:51:52AM -0500, Ben Gamari wrote:
> On Tue, 18 Jan 2011 05:10:39 +0200, Felipe Balbi <balbi@ti.com> wrote:
> > NAK. This is totally bogus. The board doesn't really depend on
> > GPIO_TWL4030, the MMC driver does.
> > 
> I've looked a little more deeply into this and I'm not entirely
> convinced that what you claim is true. It seems that the only dependency
> that the MMC module _might_ have on the TWL4030 is for the LDOs, which I
> believe should be covered in the regulator driver, not GPIO.
> 
> In light of this, I think the use of the TWL's GPIO lines for MMC it
> might be a board specific design decision. In the case of the
> Beagleboard, they are only TWL GPIO used by the MMC configuration is for
> .gpio_cd but as far as I could see they could have chosen any GPIO for
> this. Am I missing something?

it's all true, still you making a board depend on a driver is inverting
the dependencies. If you don't enable TWL4030_GPIO, all what will happen
is that MMC won't work, but that's completely valid if I'm e.g.
debugging UART of USB.

The point is, being able to disable features I don't want on my kernel
image, is completely valid, if there's a compile breakage, then fix the
breakage but don't prevent the board from compiling.

-- 
balbi
