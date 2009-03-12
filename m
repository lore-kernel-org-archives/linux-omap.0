From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Thu, 12 Mar 2009 01:22:02 -0800
Message-ID: <200903120222.02972.david-b@pacbell.net>
References: <200903110518.34945.david-b@pacbell.net> <200903110524.16644.david-b@pacbell.net> <49B8CE89.2000608@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:45737 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750845AbZCLJWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2009 05:22:06 -0400
In-Reply-To: <49B8CE89.2000608@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: OMAP <linux-omap@vger.kernel.org>

On Thursday 12 March 2009, Adrian Hunter wrote:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 } else {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_mmc_set_voltage(c, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c->vcc_aux)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_ena=
ble(c->vcc_aux);
>=20
> Sorry for slow reply. =A0Shouldn't that be regulator_disable() ?

Indeed it should be.  In fact I think this probably explains
the failure I saw the other day, trying to go from 3.3V on one
chip down to 1.8V, where it failed (reasons unknown so far)
but the cleanup left vcc_aux active.  Got patch?  :)

I meant this one to be a patch/RFC ... so you could see how I
thought those issues should be addressed, vs the less general
patches you sent the other day.  Actually merging this one
runs into that annoying regulator framework isssue on most
systems.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
