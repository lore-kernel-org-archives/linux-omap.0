From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: RE: off mode and smartreflex
Date: Tue, 12 Aug 2008 16:35:07 +0300
Message-ID: <1218548107.8751.44.camel@kj-ubuntu>
References: <20080801100024.GB8857@codecarver.research.nokia.com>
	 <13B9B4C6EF24D648824FF11BE89671620361E3890B@dlee02.ent.ti.com>
	 <1218545870.8751.31.camel@kj-ubuntu>
	 <13B9B4C6EF24D648824FF11BE89671620362037029@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42224 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYHLNcO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 09:32:14 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620362037029@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On ti, 2008-08-12 at 08:10 -0500, ext Woodruff, Richard wrote:
> > I thought I'd fix this issue for both pm-idle and the up-coming cpu-idle
> > by moving the smartreflex disable/enable calls to omap_sram_idle. But I
> > could not do it, because this way the device hangs on both suspend and
> > dynamic idle. I wonder why this is?
> >
> > The CDP code seems to disable smartreflex in the early stages of the
> > function calling omap_sram_idle. In the suspend path the disable call is
> > made just before local_fiq_disable. In pm-idle path the call seems to be
> > before checking if some interrupt has occurred. So I gathered this might
> > have something to do with interrupts.
> >
> > The thing that puzzles me is that with linux-omap, the suspend path does
> > not have any local_fiq_disable calls. Nevertheless, if the smartreflex
> > disable call is in omap_sram_idle, the suspend hangs. But, if it is in
> > start of the preceding omap3_pm_suspend call, as it is now, suspending
> > works fine. So this makes me think there could be some delay from when
> > smartreflex is disabled to when the actual I2C commands stop to the
> > voltage controller.
> 
> Have you enabled SR really to do something?

Yes, I'm using vdd1&vdd2 autocompensation with the hardcoded testing
values instead of efuse. My board seems quite stable using them. 

> 
> With out proper efuse values its job is to do OPP changes.  Once you
> have proper efuses it can do safe auto-adjustment.  Most early
> non-production devices won't have useable efuse values.
> 
> I agree hardware I2C messages when it is in use might be a point of
> worry when investigating issues.

Ok. The hang actually happens when coming out of suspend. The silicon
errata states that if smartreflex is sending i2c commands while sleep
command is issued, a warm reset will be generated. I don't know if warm
resets are handled now, but this could be something causing the hang. Or
it's something else, gotta do some debugging.

> 
> > Do you know why the smartreflex disable calls are positioned as they are
> > in the CDP code?
> 
> I don't recall there being a placement.  I can ask others if there
> aware.

Thanks!

Regards,
Kalle


> 
> Regards,
> Richard W.
> 
