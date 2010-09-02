From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/8] : Hwmod api changes
Date: Thu, 2 Sep 2010 15:30:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009021518560.17425@utopia.booyaka.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401D2AC@dbde02.ent.ti.com> <alpine.DEB.2.00.1008090156250.8958@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401D438@dbde02.ent.ti.com>
 <4C601953.7070309@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1188270133-1283463003=:17425"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53939 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab0IBVaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 17:30:05 -0400
In-Reply-To: <4C601953.7070309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Kalliguddi, Hema" <hemahk@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1188270133-1283463003=:17425
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Beno=EEt, Rajendra, Hema,

On Mon, 9 Aug 2010, Cousson, Benoit wrote:

> On 8/9/2010 11:37 AM, Nayak, Rajendra wrote:
> >=20
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Monday, August 09, 2010 1:51 PM
> > >=20
> > > On Mon, 9 Aug 2010, Nayak, Rajendra wrote:
> > >=20
> > > > Does it make sense for the framework itself to enable wakeup
> > > > for all devices when the slave port is programmed to be in
> > > > Smartidle
> > >=20
> > > It seems to me that they are separate mechanisms?  If a module is
> > > programmed for slave smart-idle, then the module prevents the
> > > PRCM from
> > > shutting off the module clock(s) until the module is not
> > > busy.  This seems
> > > distinct from ENAWAKEUP, which I thought simply controlled
> > > whether the
> > > module would assert the SWakeup signal to the PRCM when an
> > > external wakeup
> > > condition occurred for that module.  Is that an accurate summary?
> >=20
> > hmm.. the reason I thought the two were related was because the need to
> > assert a SWakeup will arise only when the module is programmed in
> > smart-idle.
> > If the module is either in no-idle (in which case no idle-ack is assert=
ed
> > by the module) or force-idle (when the module is forced to idle and
> > expected to stay idle) there might not be a need for the module to be
> > capable of asserting a SWakeup.
>=20
> In fact, the SWakeup is asserted as soon as the module is in idle (idle_a=
ck =3D
> 1) and cannot use the OCP interface to communicate a IRQ_REQ or DMA_REQ.
> But the wakeup capability is disabled by setting the SidleMode to Force-I=
dle,
> regardless of the value of Wakeup enable.
> Bottom-line is that the SWakeup can be asserted only if the module is in
> smart-idle.

In that case, it sounds like Rajendra's patch would be useful (to=20
automatically enable ENAWAKEUP during target smart-idle, and disable it=20
during target no-idle or force-idle, would be worthwhile)?

One other situation that we should consider would be if it ever makes=20
sense to program a module to target smart-idle, but disable ENAWAKEUP.  I=
=20
suppose it should only be necessary if there is a hardware bug where an IP=
=20
block generates spurious SWakeups.  -- But if we have no current need for=
=20
this type of workaround, maybe we can just ignore this case and have the=20
ENAWAKEUP bit follow target smart-idle status.  Then if such a hardware=20
bug appears, we can separate ENAWAKEUP programming later.

Thoughts?


- Paul
--155748971-1188270133-1283463003=:17425--
