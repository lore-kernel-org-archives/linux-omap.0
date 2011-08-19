From: Tony Lindgren <tony@atomide.com>
Subject: Re: Re: [alsa-devel] [PATCH 0/4] ASoC: OMAP4: McPDM: Fix legacy
 support
Date: Fri, 19 Aug 2011 16:04:20 +0300
Message-ID: <20110819130420.GF4996@atomide.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
 <1454327.U3ERne0amE@barack>
 <2097801.ze7cveM5xx@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43534 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751832Ab1HSNEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 09:04:24 -0400
Content-Disposition: inline
In-Reply-To: <2097801.ze7cveM5xx@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, "Cousson, Benoit" <b-cousson@ti.com>, Brown <broonie@opensource.wolfsonmicro.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [110815 13:56]:
> Hi Tony,
>=20
> On Tuesday 09 August 2011 09:27:17 Ujfalusi, Peter wrote:
> > Hi Tony,
> >=20
> > On Tuesday 02 August 2011 13:34:13 Ujfalusi, Peter wrote:
> > > Hello,
> > >=20
> > > The OMAP4 McPDM driver in upstream has been broken for some time.=
=2E.
> > > This series fixes that, and enables basic audio playback/capture =
over
> > > the
> > > mcpdm interface.
> >=20
> > Would you have time to look at this series?
> > Specially patch 1 (maybe 2 as well).
> > We are planning to send this series through audio for 3.1.
>=20
> Do you have time to look at this series.
> Currently the mcpdm (omap4 audio) is broken in upstream without this =
series,=20
> and I'd like to have it fixed in time for 3.1.

It seems OK to me. But for the -rc cycle it has potential for
"fixes for features that never worked" flame bait. If you guys
are OK to deal with that then go ahead.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
