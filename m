From: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Subject: Re: The old omapfb support
Date: Wed, 20 Apr 2011 13:35:23 +0200
Message-ID: <1303299323.12837.6.camel@maggie>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
	 <1303216889.32281.80.camel@deskari>  <1303217114.27432.9.camel@maggie>
	 <1303286810.2102.49.camel@deskari>  <1303298280.12837.2.camel@maggie>
	 <1303299084.2102.61.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:32789 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412Ab1DTLfa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 07:35:30 -0400
In-Reply-To: <1303299084.2102.61.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, lo-ml <linux-omap@vger.kernel.org>

On Wed, 2011-04-20 at 14:31 +0300, Tomi Valkeinen wrote:=20
> On Wed, 2011-04-20 at 13:18 +0200, Michael B=C3=BCsch wrote:
> > On Wed, 2011-04-20 at 11:06 +0300, Tomi Valkeinen wrote:=20
> > > > So if you first port the stuff and then add the depends-on OMAP=
1, I'm
> > > > fine with it.
> > >=20
> > > Does the display even work on N8x0 with mainline kernel? I don't =
see any
> > > code for it in the board file.
> >=20
> > It needs some additional glue code, which can be found here:
> > https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches=
-2.6.38/301-nokia-board-additional.patch
> > But with that code it works fine.
>=20
> Ok, thanks. I found an N810 from my HW stash, but as I don't have a
> serial adapter for it, kernel work will be rather difficult. I'll por=
t
> the display driver, but I'm probably not able to test it at all.

Ok thanks. I'll test it. I have access to the serial console.

Also see the other patches in that SVN directory. If all those
patches are applied, it does boot on 2.6.38. I'm not sure which
ones are really required to make it boot. So you should probably first
try to boot with the old driver to check if your setup works.

--=20
Greetings Michael.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
