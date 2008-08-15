From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/10] OMAP3 SRF: OMAP PM srf implementation
Date: Fri, 15 Aug 2008 01:46:15 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808150102390.6619@utopia.booyaka.com>
References: <00d701c8fd1e$1716b730$LocalHost@wipultra1382> <87y73147qb.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-630960037-1218783858=:6619"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43733 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYHOHqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:46:16 -0400
In-Reply-To: <87y73147qb.fsf@trdhcp146196.ntc.nokia.com>
Content-ID: <alpine.DEB.1.00.0808150104320.6619@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: ext Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-630960037-1218783858=:6619
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.1.00.0808150104321.6619@utopia.booyaka.com>

Hello Jouni, Rajendra,

On Wed, 13 Aug 2008, H=F6gander Jouni wrote:

> "ext Rajendra Nayak" <rnayak@ti.com> writes:
> > Its needed so that a power domain is turned ON while the first clock no=
de in it is=20
> > requested, and turned OFF while the last clock node is disabled.
>=20
> Isn't this already taken care by clock framework? If not I think it
> should be. I mean directly requesting domain to wakeup rather than
> requesting resource which causes it to wakeup.
>=20
> Paul, Any comment on this?

On the clock enable path, the clock code will wake up the clockdomain (or=
=20
add a wakeup dependency from MPU), which should cause the powerdomain to=20
automatically wake up if it is currently in retention or off.

Similarly, on the clock disable path, the clock code puts the clockdomain=
=20
to sleep (removes the MPU/IVA2 wakeup dependencies), which should cause=20
the powerdomain to enter whatever state was previously configured in=20
PM_PWSTCTRL_x.POWERSTATE.  POWERSTATE would have been set earlier by=20
device drivers calling into the OMAP PM code ("set_max_wakeup_lat" etc.)

If all of that is correct, then as you wrote, Jouni, there shouldn't be a=
=20
need for omap_pm_pwrdm_{in,}active() in Rajendra's current patch set.  In=
=20
fact the current code might actually prevent the powerdomain from dropping=
=20
below ON state.

Rajendra, can you confirm this?  Or am I missing something in the above?


- Paul
--155748971-630960037-1218783858=:6619--
