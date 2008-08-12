From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: off mode and smartreflex
Date: Tue, 12 Aug 2008 08:10:57 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620362037029@dlee02.ent.ti.com>
References: <20080801100024.GB8857@codecarver.research.nokia.com>
	 <13B9B4C6EF24D648824FF11BE89671620361E3890B@dlee02.ent.ti.com>
 <1218545870.8751.31.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:51440 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbYHLNLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 09:11:07 -0400
In-Reply-To: <1218545870.8751.31.camel@kj-ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I thought I'd fix this issue for both pm-idle and the up-coming cpu-idle
> by moving the smartreflex disable/enable calls to omap_sram_idle. But I
> could not do it, because this way the device hangs on both suspend and
> dynamic idle. I wonder why this is?
>
> The CDP code seems to disable smartreflex in the early stages of the
> function calling omap_sram_idle. In the suspend path the disable call is
> made just before local_fiq_disable. In pm-idle path the call seems to be
> before checking if some interrupt has occurred. So I gathered this might
> have something to do with interrupts.
>
> The thing that puzzles me is that with linux-omap, the suspend path does
> not have any local_fiq_disable calls. Nevertheless, if the smartreflex
> disable call is in omap_sram_idle, the suspend hangs. But, if it is in
> start of the preceding omap3_pm_suspend call, as it is now, suspending
> works fine. So this makes me think there could be some delay from when
> smartreflex is disabled to when the actual I2C commands stop to the
> voltage controller.

Have you enabled SR really to do something?

With out proper efuse values its job is to do OPP changes.  Once you have proper efuses it can do safe auto-adjustment.  Most early non-production devices won't have useable efuse values.

I agree hardware I2C messages when it is in use might be a point of worry when investigating issues.

> Do you know why the smartreflex disable calls are positioned as they are
> in the CDP code?

I don't recall there being a placement.  I can ask others if there aware.

Regards,
Richard W.

