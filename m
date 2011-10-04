From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific
 clocks
Date: Mon, 3 Oct 2011 21:51:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110032145400.4611@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-7-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1109291911390.26728@utopia.booyaka.com> <20111004004331.GR6324@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-302427832-1317700276=:4611"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38631 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab1JDDvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 23:51:17 -0400
In-Reply-To: <20111004004331.GR6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, rnayak@ti.com, santosh.shilimkar@ti.com, b-cousson@ti.com, Vishwanath BS <vishwanath.bs@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-302427832-1317700276=:4611
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

+ Rajendra, Santosh, Beno=EEt

Hi

On Mon, 3 Oct 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110929 17:40]:
> > On Thu, 22 Sep 2011, Keerthy wrote:
> >=20
> > > From: Vishwanath BS <vishwanath.bs@ti.com>
> > >=20
> > > OMAP4460 specific clocks are not getting added as the
> > > cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes.
> > > Changing it to add to OMAP4460 specific clocks also.
> > > This is clocks are required of temperature sensor.
> > >=20
> > > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > Cc: paul@pwsan.com=20
> >=20
> > Thanks, this patch has been queued for 3.2.
>=20
> Should this be a fix for the -rc cycle instead?

I don't think it's needed for the -rc series, since we don't have any=20
in-tree users of the 4460 temperature sensor.  The only impact I can see=20
is if the bootloader enables the 4460 temperature sensor clock, and=20
doesn't disable it.  I assume that would probably prevent the L4 WKUP=20
clockdomain from entering clock stop, which would consume a little more=20
power.

But maybe Beno=EEt, Rajendra, or Santosh can correct me if this=20
off-the-cuff analysis is incorrect.

- Paul
--155748971-302427832-1317700276=:4611--
