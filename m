From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 28 May 2015 15:24:13 -0700
Message-ID: <20150528222412.GM30984@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502112128.44852@pali>
 <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali>
 <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54517 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577AbbE1WYQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2015 18:24:16 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150528 13:28]:
> On 28 May 2015 at 18:01, Tony Lindgren <tony@atomide.com> wrote:
> > For failed device access you get an interrupt
> 
> Well for failed reads you get a bus error, and "catching" those (e.g.
> using the existing exception mechanism used to catch MMU faults) is
> the whole issue.
> 
> Though now that you mention it, it is true that for writes you won't
> get any fault (at least on the DM814x and AM335x the posting point
> appears to be the async bridge from MPUSS to the L3 interconnect) but
> an interconnect error irq instead. It may be easier to make some kind
> of harmless write (e.g. to the version register), wait a bit, and
> check if the write triggered an interconnect error.
> 
> Feels hackish though: you'd need to be sure you waited long enough
> (though using a read from another device on the same L4 interconnect
> should be a reliable barrier in this case), and drivers for
> receiving/interpreting interconnect errors are not implemented yet on
> all SoCs (for some, like the AM335x, TI didn't even bother publishing
> the relevant data in its TRM). Interconnect errors can also be lost in
> some cases (multiple errors involving the same target in a short time
> window) though that problem shouldn't arise in this particular case.

Hmm I believe the interrupt happens immediately trying to access an
invalid device. But maybe I'm thinking about just errors if a device
is not powered or clocked. So obviously some experiments need to be
done :)

The advantage here would be that the l3 driver actually already knows
quite a bit about the devices on the bus.
 
> Also, presumably interconnect error reporting is unavailable on HS
> devices given the fact that all interconnect registers seemed to be
> inaccessible?

Oh OK yeah then that would not work for Pali's case. I guess it just
needs to be tested.

Regards,

Tony
