From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: rdhi, rdlo and rm must all be different:  say what??
Date: Thu, 13 Mar 2008 10:54:37 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903BE6FE9@dlee13.ent.ti.com>
References: <200803121758.41024.david-b@pacbell.net> <c3756a11e4164ac843d68e9be0d6112a@felipebalbi.com> <200803130320.46227.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55858 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbYCMPy7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:54:59 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200803130320.46227.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Hi Dave,

> Subject: Re: rdhi, rdlo and rm must all be different: say what??
>=20
> On Thursday 13 March 2008, Felipe Balbi wrote:
> > > =A0 sched_clock:
> > > =A0 16: =A0 =A0 umull =A0 r0, r1, r0, r3 =A0@ tmp136, jiffies.371=
, tmp137
> > >
> > > =A0 sched_slice:
> > > =A0 =A0 =A0 =A0 =A0 ...
> > > =A0 1243: =A0 umull =A0 r0, r1, r0, r2 =A0@ slice.2262, slice,
> > > <variable>.load.weight

Thanks for digging into that.  I noticed it recently also on some build=
s. =20

Maybe this umull comes from do_div() which has some inline assembly for=
 this.  I recall that in used in sched_clock.  The inline asm might nee=
d a tweak.

Regards,
Richard W.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
