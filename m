From: Peter Barada <peter.barada@gmail.com>
Subject: Re: How to enable sys_clkout1 for use by brf6300
Date: Wed, 22 Sep 2010 10:40:28 -0400
Message-ID: <1285166428.3138.0.camel@thunk>
References: <AANLkTim9o3XdNAK5shVm8u6wa8_0rV7i9PkR3-qgskYK@mail.gmail.com>
	 <874odkxpe1.fsf@deeprootsystems.com>
Reply-To: peter.barada@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58110 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0IVOkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 10:40:31 -0400
Received: by yxp4 with SMTP id 4so180487yxp.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 07:40:30 -0700 (PDT)
In-Reply-To: <874odkxpe1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2010-09-20 at 11:04 -0700, Kevin Hilman wrote:
> Hi Peter,
> 
> Peter Barada <peter.barada@gmail.com> writes:
> 
> > I have a brf6300 that requires sys_clkout1, and I have it working fine
> > right now, but if I enable CONFIG_OMAP_RESET_CLOCKS, then
> > sys_clkou1 is disabled.
> 
> Yes, any unused clocks will be disabled.  Where "unused" means it has a
> zero use-count (nobody has called clk_enable)
> 
> > How do I tell the system that I need sys_clkout1 enabled for the
> > brf6300 chip to work?  Should I use "clk = clk_get(NULL,
> > "sys_clkout1"); clk_enable(clk)'"?
> 
> Yes.
> 
> Did that not work for you?

No, that worked fine.  Next challenge is to add into the brf6300 driver
proper suspend/resume support to allow
disabling/enabling the clock.

Thanks!

> Kevin


