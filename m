From: Peter Barada <peterb@logicpd.com>
Subject: Re: TSC2004 touch driver
Date: Tue, 01 Jul 2008 17:42:07 -0400
Message-ID: <1214948527.22345.463.camel@blackhole>
References: <1214935195.22345.452.camel@blackhole>
	 <1214938569.30276.784.camel@sax-lx.fischerfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 207-67-87-34.static.twtelecom.net ([207.67.87.34]:64922 "EHLO
	smtp.logicpd.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754329AbYGAVmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 17:42:08 -0400
In-Reply-To: <1214938569.30276.784.camel@sax-lx.fischerfamily.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: todd.fischer@ridgerun.com
Cc: linux-omap@vger.kernel.org

On Tue, 2008-07-01 at 12:56 -0600, Todd Fischer wrote:
> Peter,
> 
> We used the TSC2046, which is a "next generation ADS7846" chip.  We
> just used the ads7846 driver and it worked fine.  The TSC2004
> datasheet doesn't make the same compatibility claim however.  The
> ads7846 driver is a place to start.

The TSC2004 is I2C, wheras the ADS7846 is SPI.  I've found a TSC2003
driver written by Bill Gatliff for 2.4, but was wondering if anyone had
a better starting point.

Also, any idea where I can find a "snap" (as in source) of the kernel
work-in-progress, or is it all in the git trees?

> Todd
> 
> 
> 
> 
> The TSC2004 is a newer version the 
> On Tue, 2008-07-01 at 13:59 -0400, Peter Barada wrote: 
> > I'm trying to incorporate a TSC2004 touch driver for my omap3430 board,
> > and before I go off and reinvent the wheel, fiugred I'd ask.  Google
> > doesn't come up with anything for a driver on tsc2004.
> > 
> > Thanks in advance!
> > 
-- 
Peter Barada <peterb@logicpd.com>
