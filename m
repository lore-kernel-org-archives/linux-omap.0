From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform device
 driver
Date: Thu, 15 Sep 2011 14:16:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
 <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52781 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab1IOIrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 04:47:08 -0400
In-Reply-To: <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

Hi Tony,

On Thu, Sep 15, 2011 at 11:12:53, DebBarma, Tarun Kanti wrote:
> On Thu, Sep 15, 2011 at 3:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
> >> removed from timer code. New set of timers present on
> >> OMAP4 are now supported.
> > Also, as we don't need the support for different register offsets for 
> > the first two omap4 timers, please rather implement support for the 
> > new timers and the timeouts directly in plat-omap/dmtimer.c.
> >
> > That way we can still keep the minimal timer support simple for 
> > clocksource and clockevent. Of course this means that we'll be only 
> > supporting the first two timers as system timers on omap4, but that's 
> > fine.
> Ok, I can make the change!
> But, do we have to keep OMAP5 in mind right now where even timers[1,2] require addition of offsets?

We need clocksource & clockevent to be able to work with
timers requiring addition of offsets. Without this AM335X,
TI816X and TI814X SoC's will not boot.

Regards
Afzal
