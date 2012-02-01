From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there is
 CAM domain ACTIVE
Date: Wed, 1 Feb 2012 15:19:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202011458490.10541@utopia.booyaka.com>
References: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-378822278-1328134756=:10541"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39290 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2BAWTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 17:19:17 -0500
In-Reply-To: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com, khilman@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-378822278-1328134756=:10541
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Jan 2012, Sakari Ailus wrote:

> MPU and CORE should stay awake if there is CAM domain ACTIVE.

I guess this should read that MPU and CORE should stay awake if the ISP IP=
=20
block is active?

> This is because that module doesn't have wake-up capability.
>
> The original patch was written by Jouni H=F6gander in 2008 and this is th=
e
> last part left of it which is not in upstream yet.
>=20
> I wonder if the approach taken in the patch is valid these days;
> nevertheless it seems to do the job...

Unfortunately we do not yet have a Linux generic framework for this sort=20
of thing yet, and Tony doesn't want to add more platform_data function=20
pointers.  So in the interim, would suggest following an=20
approach similar to the patch at the bottom of this message:

http://www.spinics.net/lists/linux-omap/msg63495.html

using PM QoS constraints to get what you want.  Make sure you keep the big=
=20
nasty comment in there.  That way, when someone manages to get some=20
generic support in for it, we can convert it over easily.

We should probably be marking all of these IP blocks with broken wakeup=20
with a hwmod flag also, for warning purposes if nothing else.  "Warning,=20
missing IP block wakeup line; energy consumption will be higher than=20
necessary; please annoy your silicon vendor"


- Paul
--155748971-378822278-1328134756=:10541--
