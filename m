From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Tue, 2 Sep 2008 18:55:24 -0700
Message-ID: <200809021855.25118.david-b@pacbell.net>
References: <1220276228.2680.9.camel@localhost> <200809020751.48357.david-b@pacbell.net> <1220406796.7042.34.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:31411 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755257AbYICDmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 23:42:08 -0400
In-Reply-To: <1220406796.7042.34.camel@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stanley.miao@windriver.com
Cc: linux-omap@vger.kernel.org

On Tuesday 02 September 2008, stanley.miao wrote:
> >=20
> > If that file is, oddly, being shared between two boards ...
> > then put that code in the "if (machine_is_omap_3430sdp())"
> > block. =A0And someone should consider renaming the file if
> > it's not specific to the 2430 SDP.
>=20
> OMAP3430_ES1 doesn't have this problem.

Not the point.  Why have 2430 chips run code that only makes
sense on 3430 silicion?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
