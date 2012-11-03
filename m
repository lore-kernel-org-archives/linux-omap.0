From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Sat, 3 Nov 2012 12:47:29 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
 <5095037A.2020503@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35216 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab2KCMrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 08:47:39 -0400
In-Reply-To: <5095037A.2020503@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Kevin,

On Sat, Nov 03, 2012 at 17:13:54, Kevin Hilman wrote:
> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> > AM33XX has only one usable timer in the WKUP domain.
> > Currently the timer instance in WKUP domain is used
> > as the clockevent and the timer in non-WKUP domain
> > as the clocksource. The timer in WKUP domain can keep
> > running in suspend from a 32K clock and hence serve
> > as the persistent clock. To enable this, interchange
> > the timers used as clocksource and clockevent for
> > AM33XX.
> 
> Doesn't this also mean that you won't get timer wakeups
> in idle?  Or are you keeping the domain where the clockevent is
> on during idle?
> 

The lowest idle state that we are targeting will have MPU powered
off with external memory in self-refresh mode. Peripheral domain
with the clockevent will be kept on.

Regards,
Vaibhav
