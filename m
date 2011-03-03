From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu-wdt: Fix bitfield access
Date: Thu, 3 Mar 2011 16:27:18 +0200
Message-ID: <20110303142718.GS2644@legolas.emea.dhcp.ti.com>
References: <1299082313.13604.13.camel@marge>
 <20110303094325.GH2644@legolas.emea.dhcp.ti.com>
 <1299162089.31972.4.camel@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58579 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909Ab1CCO1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 09:27:22 -0500
Received: by mail-bw0-f52.google.com with SMTP id 24so1465656bwj.39
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 06:27:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299162089.31972.4.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Mar 03, 2011 at 03:21:29PM +0100, Michael B=FCsch wrote:
> On Thu, 2011-03-03 at 11:43 +0200, Felipe Balbi wrote:=20
> > On Wed, Mar 02, 2011 at 05:11:53PM +0100, Michael Buesch wrote:
> > > An unsigned int pointer must not be casted to an unsigned
> > > long pointer before use. Convert the bitfield to unsigned long
> > > to fix this.
> > > Also use clear_bit() in the release path.
> > >=20
> > > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> >=20
> > This looks ok, I'm just wondering if the change on test_and_set_bit=
()
> > from bit 1 to bit 0 should be on this patch. I guess not.
>=20
> Uh, well. If that's worth doing a separate patch, I'll do it.
> It doesn't actually really matter if we use bit 0, 1 or ... for this.
> I just thought it was weird to use the second bit.

yeah, I didn't read the whole code before making the comment, if you're
sure no-one is using bit 0, then go for it. Having it separate, would
help on bisecting should things go wrong.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
