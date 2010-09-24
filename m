From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: PM: Declare idle modules as functional too
Date: Fri, 24 Sep 2010 10:30:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009241029460.10678@utopia.booyaka.com>
References: <1285312248-15734-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009240123420.10678@utopia.booyaka.com> <4C9C5846.1000409@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-432898760-1285345806=:10678"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48739 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844Ab0IXQaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:30:09 -0400
In-Reply-To: <4C9C5846.1000409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-432898760-1285345806=:10678
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 24 Sep 2010, Cousson, Benoit wrote:

> On 9/24/2010 9:28 AM, Paul Walmsley wrote:
> > Hi Rajendra, Partha, Beno=EEt,
> >=20
> > On Fri, 24 Sep 2010, Rajendra Nayak wrote:
> >=20
> > > The omap4_cm_wait_module_ready function would only check for
> > > the modules to be completely functional before declaring them
> > > ready to be accessed.
> > > There might also be instances where in the module is actually
> > > in idle (under h/w control) but should still be declared
> > > accessible, as the h/w control would make it functional when
> > > needed.
> > >=20
> > > Hence make omap4_cm_wait_module_ready return true in case
> > > the module is fully functional *or* in idle state.
> > > Fail only if the module is fully disabled or stuck intransition.
> > >=20
> > > The explaination from the TRM for the idlest bits on OMAP4 is as
> > > below for quick reference
> > >=20
> > > Module idle state:
> > > 0x0 func:     Module is fully functional, including OCP
> > > 0x1 trans:    Module is performing transition: wakeup, or sleep, or s=
leep
> > >                abortion
> > > 0x2 idle:     Module is in Idle mode (only OCP part). It is functiona=
l if
> > >                using separate functional clock
> >=20
> > Thanks for the detailed changelog.  Do we need to check any other
> > registers to ensure that the OCP port is in autoidle, or to ensure that
> > the separate functional clock is active?
>=20
> Unfortunately, we do not have any other status than that in OMAP4 for the
> modules clocks activity :-(

OK, thanks Rajendra and Beno=EEt.  Queued for 2.6.37.


- Paul
--155748971-432898760-1285345806=:10678--
