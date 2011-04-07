From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Thu, 7 Apr 2011 13:27:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
 <1301900022.2715.12.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-431074259-1302201240=:29552"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40182 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635Ab1DGT1z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 15:27:55 -0400
In-Reply-To: <1301900022.2715.12.camel@deskari>
Content-ID: <alpine.DEB.2.00.1104071241001.531@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-431074259-1302201240=:29552
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1104071241002.531@utopia.booyaka.com>

Hello Tomi, Beno=EEt,

On Mon, 4 Apr 2011, Tomi Valkeinen wrote:

> On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:
>=20
> > Based on the E-mail thread so far, I'd say that changing the clock alia=
ses=20
> > is the way to go for right now.  The clock aliases are not hardware dat=
a;=20
> > they just control how the clock hardware is mapped to the drivers.
>=20
> I'd very much prefer this option. Below is a patch for this.
>=20
> If Benoit doesn't complain too much about this, I'd like to get this
> merged as soon as possible, as OMAP4 DSS is currently crashing in the
> mainline kernel.

I will queue your clock aliases patch and attempt to merge it upstream for=
=20
the -rc series.  I am not happy to be disagreeing with Beno=EEt here, but=
=20
this is the rationale that I am using.  (Beno=EEt, Tomi, please feel free t=
o=20
correct if there is something blatantly false below.)

1. The integration of the DSS module is an unusual case.  The
   MODULEMODE bits for the DSS bits do not control the DSS "main"
   functional clock (the clock that is needed to access device
   registers); instead, they only control the DSS interface clock.
   (This is because the DSS can use a functional clock that is not
   provided by the OMAP core.)  So calling the DSS MODULEMODE struct
   clk "dss_fck" is not really correct, since it is really controlling
   the interface clock.

2. This patch does not create a precedent for hacking around general
   driver clocking problems in the clock or clock data.  This is only
   needed because the MODULEMODE bits don't control the module
   functional clock in this case.  As I understand it, the only other
   device that this problem could occur with is McBSP, due to
   mcbsp_clks.

3. The existing DSS2 driver clock design apparently works fine when
   this change is implemented[1], so no driver changes will be needed.

4. The proposed DSS driver patch to work around this uses a nasty hack
   that really should be NACK'ed[2].

All this said, we may not be able to merge this change upstream, due to=20
the recent unhappiness about the clock data changes.  If Linus rejects it,=
=20
you'll need a "Plan B."

=2E..

Also, I hope you and the other DSS hackers can finish the PM runtime
conversion of the DSS driver soon.  Ideally before any new DSS
features are added.  We really need to be able to separate the OMAP
integration details from the drivers, and right now, hwmod and PM
runtime are the best way we have to do that.

Comments welcome.


- Paul


1. Valkeinen, Tomi.  _Re: OMAP4 DSS clock setup_.  E-mail to=20
linux-omap@vger.kernel.org mailing list dated Wed, 30 Mar 2011 05:59:06=20
-0700.=20
<http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47665.html>

2. ibid.

--155748971-431074259-1302201240=:29552--
