From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Tue, 20 Jan 2009 20:28:10 +0000
Message-ID: <20090120202810.GB6864@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <200901131619.28700.david-b@pacbell.net> <200901201106.00914.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2958 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbZATU2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 15:28:22 -0500
Content-Disposition: inline
In-Reply-To: <200901201106.00914.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Manikandan Pillai <mani.pillai@ti.com>, linux-omap@vger.kernel.org

On Tue, Jan 20, 2009 at 11:06:00AM -0800, David Brownell wrote:
> On Tuesday 13 January 2009, David Brownell wrote:

> > +=A0=A0=A0=A0=A0=A0=A0/* adjust to match supported range, fail if o=
ut of range */
> > +=A0=A0=A0=A0=A0=A0=A0if (min_uV < info->min_uV)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0min_uV =3D info->min_=
uV;
> > +=A0=A0=A0=A0=A0=A0=A0if (max_uV > info->max_uV)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0max_uV =3D info->min_=
uV;

> On second thought, those particular checks would be better
> handled by updating the board-level constraints in probe().

If doing this you should complain loudy - it may be better to just
refuse to run rather than fixing them up in case something else is
noticably wrong with them and they might be risky.

> That will let this driver not worry about the chip's hard
> limits in set_voltage(), and will ensure that the constraints
> listed in sysfs are accurate ... in the sense of not lying
> about what the actual system capabilities are.

Indeed - if the constraints are accurate there should be no need to
validate them at all.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
