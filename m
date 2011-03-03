From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu-wdt: Fix bitfield access
Date: Thu, 03 Mar 2011 15:36:04 +0100
Message-ID: <1299162964.31972.5.camel@maggie>
References: <1299082313.13604.13.camel@marge>
	 <20110303094325.GH2644@legolas.emea.dhcp.ti.com>
	 <1299162089.31972.4.camel@maggie>
	 <20110303142718.GS2644@legolas.emea.dhcp.ti.com>
	 (sfid-20110303_152728_057719_FFFFFFFFA4CEECF0)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:40893 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705Ab1CCOgK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 09:36:10 -0500
In-Reply-To: <20110303142718.GS2644@legolas.emea.dhcp.ti.com> (sfid-20110303_152728_057719_FFFFFFFFA4CEECF0)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, 2011-03-03 at 16:27 +0200, Felipe Balbi wrote:=20
> On Thu, Mar 03, 2011 at 03:21:29PM +0100, Michael B=C3=BCsch wrote:
> > On Thu, 2011-03-03 at 11:43 +0200, Felipe Balbi wrote:=20
> > > On Wed, Mar 02, 2011 at 05:11:53PM +0100, Michael Buesch wrote:
> > > > An unsigned int pointer must not be casted to an unsigned
> > > > long pointer before use. Convert the bitfield to unsigned long
> > > > to fix this.
> > > > Also use clear_bit() in the release path.
> > > >=20
> > > > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> > >=20
> > > This looks ok, I'm just wondering if the change on test_and_set_b=
it()
> > > from bit 1 to bit 0 should be on this patch. I guess not.
> >=20
> > Uh, well. If that's worth doing a separate patch, I'll do it.
> > It doesn't actually really matter if we use bit 0, 1 or ... for thi=
s.
> > I just thought it was weird to use the second bit.
>=20
> yeah, I didn't read the whole code before making the comment, if you'=
re
> sure no-one is using bit 0, then go for it. Having it separate, would
> help on bisecting should things go wrong.

All users of the bitfield (two) are visible in the patch ;)

--=20
Greetings Michael.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
