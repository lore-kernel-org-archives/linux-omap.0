From: Mike Turquette <mturquette@linaro.org>
Subject: Re: RE: [PATCH v2 1/4] ARM: OMAP2+: dpll: round rate to closest value
Date: Fri, 25 Jan 2013 14:20:32 -0800
Message-ID: <20130125222032.10623.47200@quantum>
References: <cover.1358937533.git.afzal@ti.com>
 <871e6890897534b6c3669e252f23bef5ff1247b6.1358937533.git.afzal@ti.com>
 <alpine.DEB.2.00.1301250816010.471@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39624 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab3AYWUi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 17:20:38 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so511474pad.10
        for <linux-omap@vger.kernel.org>; Fri, 25 Jan 2013 14:20:37 -0800 (PST)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

Quoting Mohammed, Afzal (2013-01-25 04:18:22)
> Hi Paul,
> 
> On Fri, Jan 25, 2013 at 13:48:11, Paul Walmsley wrote:
> > On Wed, 23 Jan 2013, Afzal Mohammed wrote:
> 
> > > Currently round rate function would return proper rate iff requested
> > > rate exactly matches the PLL lockable rate. This causes set_rate to
> > > fail if exact rate could not be set. Instead round rate may return
> > > closest rate possible (less than the requested). And if any user is
> > > badly in need of exact rate, then return value of round rate could
> > > be used to decide whether to invoke set rate or not.
> > > 
> > > Modify round rate so that it return closest possible rate.
> > 
> > This doesn't look like the right approach to me.  For some PLLs, an exact 
> > rate is desired.
> 
> If exact rate is required, there is a way to achieve it as mentioned
> in the commit message, i.e. by first invoking round rate over reqd. rate
> and if it doesn't match, bail out w/o invoking set_rate.
> 
> And it seems requirement of CCF w.r.t to round rate is to return closest
> possible rate.

Is MULT_ROUND_UP doing the right thing for you in the clk_divider code?
What is the clock rate requested of the parent PLL?  I just want to make
sure that we're doing the right thing in the basic divider code.

Thanks,
Mike
