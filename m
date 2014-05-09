From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 9 May 2014 08:30:09 -0700
Message-ID: <20140509153008.GC17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
 <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C924E.5000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12238 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757166AbaEIPaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 11:30:14 -0400
Content-Disposition: inline
In-Reply-To: <536C924E.5000307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 01:31]:
> On 09/05/14 02:33, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [140507 11:00]:
> >> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
> >>> On 07/05/14 18:03, Tony Lindgren wrote:
> >>>>
> >>>> BTW, I'm also personally fine with all five gpios showing in a single
> >>>> gpios property, I'm not too exited about naming anything in DT..
> >>>
> >>> I don't have a strong opinion here. I don't have much experience with
> >>> DT, especially with making bindings compatible with other ones.
> >>>
> >>> I'd just forget the simple-panel, and have single gpio array.
> >>
> >> Well if it's a don't care flag for both of us, let's try to use
> >> the existing standard for simple-panel.txt and add mode-gpios
> >> property. I'll post a patch for that.
> > 
> > Here's an updated version using enable-gpios, reset-gpios and
> > mode-gpios. So it follows simple-panel.txt and adds mode-gpios
> > that's currently specific to this panel only.
> > 
> > Also updated for -EPROBE_DEFER handling, tested that by changing
> > one of the GPIOs to be a twl4030 GPIO.
> 
> To speed things up a bit, I made the changes I suggested. Compile tested
> only.

OK thanks did not get the penguin with it so need to look at it a bit
more.

Regards,

Tony
