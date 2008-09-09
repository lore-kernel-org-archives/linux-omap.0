From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH resend v2] TWL4030-RTC: Fix the broken functionality
Date: Tue, 9 Sep 2008 11:35:54 -0700
Message-ID: <200809091135.55643.david-b@pacbell.net>
References: <EAF47CD23C76F840A9E7FCE10091EFAB027DC93D5A@dbde02.ent.ti.com> <48B2A600.2060406@gmail.com> <20080909174434.GS29054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:29415 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751731AbYIISf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 14:35:57 -0400
In-Reply-To: <20080909174434.GS29054@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 09 September 2008, Tony Lindgren wrote:
> 
> > The patch might be acceptable as a temporary workaround, but obviously
> > it won't be accepted in mainline, as well as commit
> > 7ef9abe1e9cf53c2dd7556f12d35b06053847f72 which has introduced periodic
> > IRQ functionality to rtc-twl4030 driver.
> 
> Sounds like this still needs work, so not pushing.

More like:  fixed by the RTC cleanup patch I sent, which
you said you're merging.  It removed that periodic IRQ
functionality, since the RTC interface only supports
periods of 2^N Hz while this RTC only supports periods
of 1 Hz ("update" irq) and below.

- Dave


