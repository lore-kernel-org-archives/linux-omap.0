From: Tero Kristo <t-kristo@ti.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Thu, 12 Jul 2012 11:31:11 +0300
Message-ID: <1342081871.4672.32.camel@sokoban>
References: <4FD1D570.1010508@ti.com>	<20120608105611.GO12766@atomide.com>
	 <4FD1EF25.3060906@ti.com>	<1339160732.2091.47.camel@sokoban>
	 <4FD1FB47.8040007@ti.com>	<4FD72FB7.60905@ti.com>
	 <CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>
	 <87mx36ht3y.fsf@ti.com>
	 <CALLhW=7FwtPy0_u863fH7-nSMW4AvxuqHvNeO2CqtF3aJEgh4Q@mail.gmail.com>
	 <4FFE6049.7040908@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59582 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab2GLIbQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 04:31:16 -0400
In-Reply-To: <4FFE6049.7040908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>

On Thu, 2012-07-12 at 10:57 +0530, Rajendra Nayak wrote:
> On Thursday 12 July 2012 05:28 AM, Omar Ramirez Luna wrote:
> > I suspect this might be specific to 4460 as Rajendra reported it was
> > working for him on 4430 but not on 4460, I haven't tried 4430 but let
> > me see if I can find one.
> 
> Yes, this is an issue specific to 4460. The patch 'ARM: OMAP4460:
> Workaround for ROM bug because of CA9 r2pX GIC control register change'
> from Tero's Core retention series [1] fixes it. Unfortunately the patch
> does not apply on it own and has dependencies with other patches in the
> series.
> 
> [1] http://comments.gmane.org/gmane.linux.ports.arm.omap/78399

The dependencies are by design, I am trying to force maintainers to get
that stuff in. ;)

-Tero


