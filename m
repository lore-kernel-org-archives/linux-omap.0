From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 7/8] : Hwmod api changes
Date: Mon, 9 Aug 2010 15:07:38 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401D438@dbde02.ent.ti.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401D2AC@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1008090156250.8958@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41086 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab0HIJhw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 05:37:52 -0400
In-Reply-To: <alpine.DEB.2.00.1008090156250.8958@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

=20

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]=20
> Sent: Monday, August 09, 2010 1:51 PM
> To: Nayak, Rajendra
> Cc: Kalliguddi, Hema; linux-usb@vger.kernel.org;=20
> linux-omap@vger.kernel.org; Basak, Partha; Felipe Balbi; Tony=20
> Lindgren; Cousson, Benoit; Kevin Hilman
> Subject: RE: [PATCH 7/8] : Hwmod api changes
>=20
> (cc Beno=EEt)
>=20
> On Mon, 9 Aug 2010, Nayak, Rajendra wrote:
>=20
> > Does it make sense for the framework itself to enable wakeup
> > for all devices when the slave port is programmed to be in
> > Smartidle
>=20
> It seems to me that they are separate mechanisms?  If a module is=20
> programmed for slave smart-idle, then the module prevents the=20
> PRCM from=20
> shutting off the module clock(s) until the module is not=20
> busy.  This seems=20
> distinct from ENAWAKEUP, which I thought simply controlled=20
> whether the=20
> module would assert the SWakeup signal to the PRCM when an=20
> external wakeup=20
> condition occurred for that module.  Is that an accurate summary?=20

hmm.. the reason I thought the two were related was because the need to
assert a SWakeup will arise only when the module is programmed in smart=
-idle.
If the module is either in no-idle (in which case no idle-ack is assert=
ed
by the module) or force-idle (when the module is forced to idle and
expected to stay idle) there might not be a need for the module to be
capable of asserting a SWakeup.
=20
The reason I proposed ENAWAKEUP to be always enabled with smart-idle wa=
s=20
with as understanding that we may never have a case wherein the module
is programmed in smart-idle but not expected to assert SWakeup (if it
supports one). I will check up on this if there ever could be such a
case.

>=20
> > instead of exposing 2 more omap device level api;s to the drivers?
>=20
> Something like this probably needs to be exposed to core code=20
> that would=20
> also set/clear PM_WKEN_* for the appropriate processor=20
> module.  Right now=20
> we just set a bunch of these bits directly in pmXXXX.c, and=20
> that needs to=20
> change.
>=20
> The other issue is that I suspct the module needs to be=20
> enabled in order=20
> for SYSCONFIG writes to succeed; right now the underlying=20
> hwmod code does=20
> not appear to enforce this :-(
>=20
> But I don't see why drivers would need to call these=20
> functions directly. =20
> Hema, was that your intention?  If so, you could you please=20
> explain the=20
> use case?
>=20
> > I have a patch for this and can post it for review in case you
> > feel it makes sense.
>=20
>=20
> - Paul--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
