From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH v2 2/6] OMAP1: Add support for SoC camera
 interface
Date: Thu, 23 Sep 2010 16:54:45 -0700
Message-ID: <20100923235444.GX4211@atomide.com>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl>
 <201009110334.03905.jkrzyszt@tis.icnet.pl>
 <20100923232309.GV4211@atomide.com>
 <201009240144.47422.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53749 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0IWXys (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 19:54:48 -0400
Content-Disposition: inline
In-Reply-To: <201009240144.47422.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100923 16:37]:
> Friday 24 September 2010 01:23:10 Tony Lindgren napisa=C5=82(a):
> >
> > I think you can just move the OMAP1_CAMERA_IOSIZE to the devices.c =
or
> > someplace like that?
>=20
> Tony,
> Not exactly. I use the OMAP1_CAMERA_IOSIZE inside the driver when res=
erving=20
> space for register cache.
>=20
> I think that I could just duplicate its definition in the devices.c f=
or now,=20
> than clean things up with a folloup patch when both parts already get=
 merged.=20
> Would this be acceptable?

Yeah, that sounds good to me.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
