From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Wed, 25 Feb 2009 17:02:03 -0800
Message-ID: <200902251702.03230.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902241617.22643.david-b@pacbell.net> <20090225151721.GA31637@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:44684 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753059AbZBZBCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2009 20:02:06 -0500
In-Reply-To: <20090225151721.GA31637@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wednesday 25 February 2009, Mark Brown wrote:
> > Fixable in an update. =A0I still think it's better to require less
> > manual configuration, not more ... manual configuration is by
> > definition error prone; requiring more manual configuration makes
>=20
> This whole interface is structured around the idea that the consequen=
ces
> of getting this wrong include things like lasting hardware damage.

Oh, one more comment.  Requiring manual configuration
of fixed-voltage regulators is pure time-wastage.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
