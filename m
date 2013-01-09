From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 13/18] ARM: OMAP2+: AM33XX: timer: Interchance clkevt
 and clksrc timers
Date: Wed, 9 Jan 2013 05:31:45 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD02B@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com>
 <50EC3888.1070504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab3AIFb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 00:31:57 -0500
In-Reply-To: <50EC3888.1070504@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hunter, Jon" <jon-hunter@ti.com>

On Tue, Jan 08, 2013 at 20:47:28, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > AM33XX has two timers (DTIMER0/1) in the WKUP domain.
> > On GP devices the source of DMTIMER0 is fixed to an
> > inaccurate internal 32k RC oscillator and this makes
> > the DMTIMER0 practically either as a clocksource or
> > as clockevent.
> >
> > Currently the timer instance in WKUP domain is used
> > as the clockevent and the timer in non-WKUP domain
> > as the clocksource. DMTIMER1 in WKUP domain can keep
> > running in suspend from a 32K clock fed from external
> > OSC and can serve as the persistent clock for the kernel.
> > To enable this, interchange the timers used as clocksource
> > and clockevent for AM33XX.
> >
> > For now a new DT property has been added to allow the timer code
> > to select the timer with the right property.
> >
> > It has been pointed out by Santosh Shilimkar and Kevin Hilman
> > that such a change will result in soc-idle never being achieved
> > on AM33XX. There are other reasons why soc-idle does not look
> > feasible on AM33XX so for now we go ahead with the interchange
> > of the the timers. If at a later point of time we do come up
> > with an approach which makes soc-idle possible on AM33XX, this
> > can be revisited.
> >
> Can you please explain other reasons as well for clarity ?
> 

I guess from h/w perspective it boils down to lack of HW-AUTO and IO-Daisy
chaining on AM33xx [1]. 

Since there's no 32ksynctimer, do we also need to register DMTIMER1 as the persistent
clock on AM33xx? This can only be done from DMTIMER1 which is currently serving as
the clockevent.

Regards,
Vaibhav

[1] http://marc.info/?l=linux-arm-kernel&m=135238055717206&w=4
