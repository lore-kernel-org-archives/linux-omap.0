From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend v2] TWL4030-RTC: Fix the broken functionality
Date: Tue, 9 Sep 2008 12:16:18 -0700
Message-ID: <20080909191618.GU29054@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB027DC93D5A@dbde02.ent.ti.com> <48B2A600.2060406@gmail.com> <20080909174434.GS29054@atomide.com> <200809091135.55643.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55267 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbYIITQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 15:16:25 -0400
Content-Disposition: inline
In-Reply-To: <200809091135.55643.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [080909 11:36]:
> On Tuesday 09 September 2008, Tony Lindgren wrote:
> > 
> > > The patch might be acceptable as a temporary workaround, but obviously
> > > it won't be accepted in mainline, as well as commit
> > > 7ef9abe1e9cf53c2dd7556f12d35b06053847f72 which has introduced periodic
> > > IRQ functionality to rtc-twl4030 driver.
> > 
> > Sounds like this still needs work, so not pushing.
> 
> More like:  fixed by the RTC cleanup patch I sent, which
> you said you're merging.  It removed that periodic IRQ
> functionality, since the RTC interface only supports
> periods of 2^N Hz while this RTC only supports periods
> of 1 Hz ("update" irq) and below.

OK cool.

Tony
