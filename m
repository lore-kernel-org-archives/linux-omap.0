From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v3] ARM: OMAP: Cortex-A9 PERIPHCLK node for 3.2
Date: Tue, 8 Nov 2011 08:56:18 -0800
Message-ID: <20111108165618.GK31337@atomide.com>
References: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com>
 <alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com>
 <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
 <20111105005312.GQ31337@atomide.com>
 <alpine.DEB.2.00.1111080051471.12394@utopia.booyaka.com>
 <CAMQu2gwAezM7WZRyZFijYf0vLGEWRaUOGkyctBp=9A5+7oV=tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24286 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752802Ab1KHQ4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 11:56:23 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gwAezM7WZRyZFijYf0vLGEWRaUOGkyctBp=9A5+7oV=tA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, keshava_mgowda@ti.com

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [111107 23:33]:
> On Tue, Nov 8, 2011 at 1:23 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Fri, 4 Nov 2011, Tony Lindgren wrote:
> >
> >> * Paul Walmsley <paul@pwsan.com> [111010 17:09]:
> >> > The following changes since commit be73246058737beec52ae232bcab7=
776332a9e06:
> >> >
> >> > =C2=A0 ARM: OMAP2+: Remove custom init_irq for remaining boards =
(2011-09-26 17:50:37 -0700)
> >> >
> >> > are available in the git repository at:
> >> > =C2=A0 git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2
> >> >
> >> > This pull request drops the EHCI/OHCI hwmod data due to some
> >> > inconsistencies that were just found in the data.
> >> >
> >> > Santosh Shilimkar (1):
> >> > =C2=A0 =C2=A0 =C2=A0 ARM: OMAP4: clock: Add CPU local timer cloc=
k node.
> >> >
> >> > =C2=A0arch/arm/mach-omap2/clock44xx_data.c | =C2=A0 =C2=A09 ++++=
+++++
> >> > =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
> >>
> >> Should this be pulled into fixes for v3.2 -rc cycle?
> >
> > Santosh would be the right person to ask. =C2=A0Santosh, is anythin=
g broken in
> > 3.2 if this patch doesn't get merged in -rc? =C2=A0Or is it just a =
feature
> > which could be added in 3.3?
> >
> Nope nothing broken now since OMAP CPUFreq has not
> got into mainline yet. We need this patch to present once we
> start supporting MPU frequency scaling which I guess would
> happen now in 3.3.

OK thanks for the update.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
