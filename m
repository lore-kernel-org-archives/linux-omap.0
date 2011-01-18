From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Tue, 18 Jan 2011 08:51:52 -0500
Message-ID: <87d3nus4jr.fsf@gmail.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com> <20110118031038.GA2436@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45619 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1ARNxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 08:53:06 -0500
Received: by vws16 with SMTP id 16so2383426vws.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 05:53:04 -0800 (PST)
In-Reply-To: <20110118031038.GA2436@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 18 Jan 2011 05:10:39 +0200, Felipe Balbi <balbi@ti.com> wrote:
> NAK. This is totally bogus. The board doesn't really depend on
> GPIO_TWL4030, the MMC driver does.
> 
I've looked a little more deeply into this and I'm not entirely
convinced that what you claim is true. It seems that the only dependency
that the MMC module _might_ have on the TWL4030 is for the LDOs, which I
believe should be covered in the regulator driver, not GPIO.

In light of this, I think the use of the TWL's GPIO lines for MMC it
might be a board specific design decision. In the case of the
Beagleboard, they are only TWL GPIO used by the MMC configuration is for
.gpio_cd but as far as I could see they could have chosen any GPIO for
this. Am I missing something?

Cheers,

- Ben
