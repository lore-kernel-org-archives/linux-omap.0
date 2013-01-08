From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 13/18] ARM: OMAP2+: AM33XX: timer: Interchance clkevt
 and clksrc timers
Date: Tue, 8 Jan 2013 20:47:28 +0530
Message-ID: <50EC3888.1070504@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37671 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756329Ab3AHPQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:16:41 -0500
In-Reply-To: <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Vaibhav Hiremath <hvaibhav@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> AM33XX has two timers (DTIMER0/1) in the WKUP domain.
> On GP devices the source of DMTIMER0 is fixed to an
> inaccurate internal 32k RC oscillator and this makes
> the DMTIMER0 practically either as a clocksource or
> as clockevent.
>
> Currently the timer instance in WKUP domain is used
> as the clockevent and the timer in non-WKUP domain
> as the clocksource. DMTIMER1 in WKUP domain can keep
> running in suspend from a 32K clock fed from external
> OSC and can serve as the persistent clock for the kernel.
> To enable this, interchange the timers used as clocksource
> and clockevent for AM33XX.
>
> For now a new DT property has been added to allow the timer code
> to select the timer with the right property.
>
> It has been pointed out by Santosh Shilimkar and Kevin Hilman
> that such a change will result in soc-idle never being achieved
> on AM33XX. There are other reasons why soc-idle does not look
> feasible on AM33XX so for now we go ahead with the interchange
> of the the timers. If at a later point of time we do come up
> with an approach which makes soc-idle possible on AM33XX, this
> can be revisited.
>
Can you please explain other reasons as well for clarity ?

Regards
Santosh
