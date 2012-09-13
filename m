From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Thu, 13 Sep 2012 15:28:11 +0100
Message-ID: <20120913142810.GD20420@e102568-lin.cambridge.arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913125347.GD2470@linaro.org>
 <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43944 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2IMO2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 10:28:14 -0400
In-Reply-To: <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 02:01:35PM +0100, Shilimkar, Santosh wrote:
> On Thu, Sep 13, 2012 at 6:23 PM, Dave Martin <dave.martin@linaro.org> wrote:

[...]

> > LoUIS matches the power domain affected by turning a single CPU off
> > on most (all?) current v7 SoCs where this matters, but only by coincidence.
> > There is no guarantee of that.
> >
> > The _louis() API is useful, because this is exactly what you need to to
> > I-/D-/TLB synchronisation in an SMP OS.  Using it as preparation for
> > powering a CPU off feels like misuse, at least in theory.
> >
> > For powerdown, we would logically need a separate function,
> > flush_cache_cpu() or something, whose job is precisely to flush those
> > levels which will be affected by the power-down if that single CPU.
> >
> In the series, there is patch "[PATCH 3/6]" which adds an
> API which let you operate on a specific level.

Yep, but that's not callable from __cpu_suspend_save in a generic way
(it is v7 specific and we are not going to add another API/macro for
that to be usable in generic code, at least for now).

Let's keep that patch in our trees and as Russell suggested we will repost it
with the PM BSP accordingly to raise the point and take it from there.

Thanks,
Lorenzo

