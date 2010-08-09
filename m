From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 7/8] : Hwmod api changes
Date: Mon, 9 Aug 2010 02:21:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1008090156250.8958@utopia.booyaka.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401D2AC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1585636690-1281340752=:8958"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58492 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab0HIIVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 04:21:13 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401D2AC@dbde02.ent.ti.com>
Content-ID: <alpine.DEB.2.00.1008090159330.8958@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, b-cousson@ti.com, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1585636690-1281340752=:8958
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1008090159331.8958@utopia.booyaka.com>

(cc Beno=EEt)

On Mon, 9 Aug 2010, Nayak, Rajendra wrote:

> Does it make sense for the framework itself to enable wakeup
> for all devices when the slave port is programmed to be in
> Smartidle

It seems to me that they are separate mechanisms?  If a module is=20
programmed for slave smart-idle, then the module prevents the PRCM from=20
shutting off the module clock(s) until the module is not busy.  This seems=
=20
distinct from ENAWAKEUP, which I thought simply controlled whether the=20
module would assert the SWakeup signal to the PRCM when an external wakeup=
=20
condition occurred for that module.  Is that an accurate summary? =20

> instead of exposing 2 more omap device level api;s to the drivers?

Something like this probably needs to be exposed to core code that would=20
also set/clear PM_WKEN_* for the appropriate processor module.  Right now=
=20
we just set a bunch of these bits directly in pmXXXX.c, and that needs to=
=20
change.

The other issue is that I suspct the module needs to be enabled in order=20
for SYSCONFIG writes to succeed; right now the underlying hwmod code does=
=20
not appear to enforce this :-(

But I don't see why drivers would need to call these functions directly. =
=20
Hema, was that your intention?  If so, you could you please explain the=20
use case?

> I have a patch for this and can post it for review in case you
> feel it makes sense.


- Paul
--155748971-1585636690-1281340752=:8958--
