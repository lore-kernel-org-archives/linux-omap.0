From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Fri, 1 Oct 2010 19:03:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE06C@dbde02.ent.ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com> <20100930150713.GG3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD03185@dbde02.ent.ti.com>
 <87bp7ff962.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CD033D6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36152 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab0JANeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 09:34:24 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD033D6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Menon, Nishanth" <nm@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Tony, Benoit, Kevin,

> > >> > >
> > >> > > I think that disabling it should be done only if the
> > CONFIG_OMAP_WDT
> > >> > > is not set.
> > >> >
> > >> > How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
> > >> > is set?
> > >>
> > >> As given in the patch description, this patch does a disable of
> > watchdog
> > >> timer, during init, to avoid the system rebooting that happens due to
> > >> enabling of watchdog timer after a reset of the module (during hwmod
> > init).
> > >>
> > >> According to the default WDT registers values, the system reboot
> would
> > >> happen in ~10s if watchdog is enabled with default values. Hence,
> after
> > >> a WDT module reset during init, the watchdog has to be disabled
> within
> > 10s
> > >> otherwise the system will keep rebooting.
> > >>
> > >> Hence irrespective of CONFIG_WATCHDOG_NOWAYOUT/ CONFIG_OMAP_WDT,
> > >> the watchdog timer needs to be disabled after a WDT reset has
> happened.
> > >>
> > > One more option is to avoid the software reset using the
> CONFIG_OMAP_WDT
> > > flag. Something like below.
> >
> > This was already proposed by Charu, and rejected.
> >
> > Doing this means we have a dependency on particular bootloader init, and
> > we'd like to get rid of *all* assumptions about what the bootloader does
> > (or does not do.)
> >
> you mean is not depeding on bootloader to disable WDT. Make sense.
> 

Let me know your opinion on how to handle this issue.

- V Charulatha
