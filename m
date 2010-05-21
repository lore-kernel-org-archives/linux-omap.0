From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Fri, 21 May 2010 06:14:14 -0700 (PDT)
Message-ID: <396934.73027.qm@web180307.mail.gq1.yahoo.com>
References: <20100521111136.53dba6c9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n12.bullet.mail.mud.yahoo.com ([209.191.125.209]:24124 "HELO
	n12.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751692Ab0EUNOP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 May 2010 09:14:15 -0400
In-Reply-To: <20100521111136.53dba6c9@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>




--- On Fri, 5/21/10, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:


> GPIO is almost always fairly tightly platform bound

Not entirely.  SOC based ones, yes.  But GPIOs on expanders
and ancillary chips have more variable capabilities, and many
SOC-based boards have a bunch of those.

> so features only
> existing on certain ports is fine. The platform vendor will
> have made
> sure they relevant ports have suitable debounce
> facilities.

One of the earlier examples of why to want debouncing (in the
original discussion, not this one) was for buttons (one signal
per button press) and the hardware designers don't necessarily
hook buttons up to only GPIOs with hardware debounce.  So code
to kick in debounce there needed to be sensitive to whether or
not the capability was available ... and moreover, whether the
debounce scale was adequate to compensate the contact chatter.
When not, then software debounce was inescapable.


