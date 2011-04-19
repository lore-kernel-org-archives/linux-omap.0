From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: The old omapfb support
Date: Tue, 19 Apr 2011 15:41:29 +0300
Message-ID: <1303216889.32281.80.camel@deskari>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41987 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545Ab1DSMlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 08:41:40 -0400
Received: by ewy9 with SMTP id 9so2463669ewy.14
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 05:41:36 -0700 (PDT)
In-Reply-To: <1303216485.27432.7.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Tony Lindgren <tony@atomide.com>, lo-ml <linux-omap@vger.kernel.org>

On Tue, 2011-04-19 at 14:34 +0200, Michael B=C3=BCsch wrote:
> On Tue, 2011-04-19 at 15:30 +0300, Tony Lindgren wrote:=20
> > > But this again reminded me of the mess of having two display driv=
ers,
> > > the old omapfb and the new DSS2. Many of the OMAP2 boards using t=
he old
> > > driver should be quite easy to port to DSS2, with the exception o=
f N800.
> > > DSS2 doesn't support OMAP1, so there's not much that can be done =
with
> > > those boards currently.
>=20
> > Yeh we can just make old omapfb depends on ARCH_OMAP1.
>=20
> As he said, the old omapfb code is used on n8x0, which is OMAP2.

But as I also said, the old OMAP2 panel drivers can be ported to the ne=
w
DSS driver. I just mentioned N800 because the panel driver for N800 is
rather difficult to port and will require more work than the other OMAP=
2
panel drivers.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
