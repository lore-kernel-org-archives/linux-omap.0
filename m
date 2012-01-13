From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 06:23:41 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201130623230.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <CAAL8m4yW-FSYa0-A2FLzwd+0JmRZx25g7jknc7a2BdvZMZFPUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1763111561-1326461021=:3659"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39021 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2AMNXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 08:23:42 -0500
In-Reply-To: <CAAL8m4yW-FSYa0-A2FLzwd+0JmRZx25g7jknc7a2BdvZMZFPUA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1763111561-1326461021=:3659
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 Jan 2012, Govindraj wrote:

> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cp=
uidle34xx.c
> > index 942bb4f..4ef32d4 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -183,6 +183,9 @@ static int next_valid_state(struct cpuidle_device *=
dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0core_deepest_state =3D P=
WRDM_POWER_OFF;
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 if (!omap_uart_can_sleep())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D PWRDM_POWER_ON;
> > +
>=20
> omap_uart_can_sleep is removed part of uart runtime conversion,
> and is no more available on latest mainline, looks like uart runtime
> patches got merged after 3.2 tagging.

Great, so sounds like this patch is not needed...

- Paul
--155748971-1763111561-1326461021=:3659--
