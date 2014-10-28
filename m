From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH typo-resend] mtd: omap: fix mtd devices not showing up
Date: Tue, 28 Oct 2014 09:57:41 +0100
Message-ID: <20141028085740.GG2383@ci00147.xsens-tech.local>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
 <544E4F19.8060205@ti.com>
 <544E9CB1.5020804@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:39229 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbaJ1I6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2014 04:58:06 -0400
Content-Disposition: inline
In-Reply-To: <544E9CB1.5020804@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Oct 27, 2014 at 04:27:45PM -0300, Ezequiel Garcia wrote:
> 
> On 10/27/2014 10:56 AM, Roger Quadros wrote:
> 
> > Alternatively we could fix either elm_config() or omap_nand_probe() to
> > return -EPROBE_DEFER in case the device is present but driver not yet probed.
> > 
> 
> Yes, that's a good idea. Can't we do both? Getting a systematic deferred
> probe sounds like a bit silly to me.

It may be. If we do both and something moves again, or something is
added that depends on omap_elm but is probed earlier, you won't be
noticing the new systematic probe deferral until you really start
looking at it.

There isn't a real dependency system in the drivers, is there?

Thanks,
Frans
