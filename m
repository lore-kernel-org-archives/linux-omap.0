From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 10/12] omap: mcbsp: Move sidetone clock management to
 mach-omap2/mcbsp.c
Date: Fri, 1 Jul 2011 03:23:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com> <1309510356-27147-11-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2083444869-1309512200=:27025"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33097 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab1GAJXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 05:23:50 -0400
In-Reply-To: <1309510356-27147-11-git-send-email-jhnikula@gmail.com>
Content-ID: <alpine.DEB.2.00.1107010323290.27025@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2083444869-1309512200=:27025
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1107010323291.27025@utopia.booyaka.com>

+ Beno=EEt

Hello Jarkko

On Fri, 1 Jul 2011, Jarkko Nikula wrote:

> Active sidetone requires that McBSP interface clock doesn't idle and ther=
e
> is no mechanism in hwmod to turn autoidling on/off in runtime. McBSP2 and=
 3
> in OMAP34xx share their interface clock with McBSP sidetone module and
> that interface clock must be active when the sidetone is operating.
>=20
> Sidetone has its own autoidle bit which should keep the interface clock
> active but it is broken. Putting the McBSP core to no-idle mode when the
> sidetone is active is no good either since it results to higher power
> consumption when using the threshold based DMA transfers.

In the hwmod code/data, we've got the OCPIF_SWSUP_IDLE flag that can be=20
set on a struct omap_hwmod_ocp_if.  I think this is probably what's needed=
=20
here.  The only problem is that we haven't linked that to the clock code=20
to deny idle on the interface clock yet (see omap_hwmod.c:_setup()). =20
Adding that code in, plus adding that OCPIF_SWSUP_IDLE flag to the=20
McBSP2/3 data, seems like the right approach here.

I guess we also will need some basic usecounting for denying idle in the=20
clock code.

Otherwise these direct register manipulations of clock registers, outside=
=20
the clock code, could turn into a mess :-(

At least it makes sense to move those out of the driver and into the=20
arch/arm/*omap* code...


- Paul
--155748971-2083444869-1309512200=:27025--
