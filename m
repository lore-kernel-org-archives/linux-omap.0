From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
Date: Wed, 25 Mar 2009 10:03:29 -0700
Message-ID: <200903251003.29340.david-b@pacbell.net>
References: <49B11EB0.30809@nokia.com> <1237290190.6781.313.camel@vega.slimlogic.co.uk> <49C9EB17.2020408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n20.bullet.mail.mud.yahoo.com ([68.142.206.147]:43845 "HELO
	n20.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751907AbZCYRDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2009 13:03:33 -0400
In-Reply-To: <49C9EB17.2020408@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Wednesday 25 March 2009, Adrian Hunter wrote:
> >> http://community.ti.com/forums/p/3777/14574.aspx
> >>
> >> So how do we do it?
> >=20
> > I'd prefer seeing the reply from Ghandar to David's last question b=
efore
> > accepting this patch again. It's still not 100% clear from TI, thin=
gs
> > seem a little bit muddled as to whether 3V will be guaranteed to wo=
rk on
> > *all* shipped devices.
>=20
> Ghandar has responded. =A0What would you like to do?

Update the patch to include a comment (by the table def)
that TI says they're revising the twl5030/tps659x0 specs
to support that 3.0V setting, then merge it.

(Umm, though I'd be sure to find out specifically which
selectors they're supporting that way, first...)

I don't think they'll be revising specs on chips they've
shipped already ... but this isn't likely to matter on
those older systems, anyway; example, the 3430 SDP uses
VAUX3, but at the always-supported 2.8V setting.



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
