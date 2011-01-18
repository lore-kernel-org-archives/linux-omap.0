From: Felipe Balbi <balbi@ti.com>
Subject: Re: NULL deref on sched_clock_poll()
Date: Tue, 18 Jan 2011 08:25:05 +0200
Message-ID: <20110118062504.GH2436@legolas.emea.dhcp.ti.com>
References: <20110118051227.GE2436@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1101172321450.13225@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55646 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733Ab1ARGZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 01:25:12 -0500
Received: by mail-yx0-f176.google.com with SMTP id 8so2876693yxm.7
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 22:25:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101172321450.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Jan 17, 2011 at 11:21:56PM -0700, Paul Walmsley wrote:
> On Tue, 18 Jan 2011, Felipe Balbi wrote:
> 
> > with today's mainline plus Russell's v6k patchset, I can't get
> > pandaboard to boot with omap2plus_defconfig.
> > 
> > The problem is that noone seems to be setting sched_clock_update_fn(),
> > so we we call sched_clock_poll() we have a NULL pointer deref.
> > 
> > I have 32k counter enabled but after adding a printk() to
> > omap_init_clocksource_32k() I don't see that getting called at all :-(
> > 
> > Am I missing any patch on top of Linus' tree ?
> 
> http://www.spinics.net/lists/linux-omap/msg44013.html

tks

-- 
balbi
