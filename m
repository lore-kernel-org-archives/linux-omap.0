From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2 output
 on SoC pad
Date: Wed, 29 May 2013 19:06:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1305291902450.9052@utopia.booyaka.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com> <79CD15C6BA57404B839C016229A409A83EC8C081@DBDE04.ent.ti.com> <alpine.DEB.2.00.1305200246080.2656@utopia.booyaka.com> <51A35123.6040600@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1398783849-1369854194=:9052"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33754 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759607Ab3E2TGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 15:06:14 -0400
In-Reply-To: <51A35123.6040600@ti.com>
Content-ID: <alpine.DEB.2.02.1305291903290.9052@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1398783849-1369854194=:9052
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1305291903291.9052@utopia.booyaka.com>

Salut Beno=EEt,

On Mon, 27 May 2013, Benoit Cousson wrote:

> On 05/20/2013 04:47 AM, Paul Walmsley wrote:
> > On Fri, 17 May 2013, Hiremath, Vaibhav wrote:
> >=20
> >> Tony, Paul and Benoit,
> >>
> >> Any update on this series?
> >=20
> > Most of the changes are DT-related, so it should probably go in via=20
> > Beno=EEt.  I'll ack the clock side, but have a comment on patch 2, to b=
e=20
> > sent shortly.
>=20
> I've tried to apply that patch, but unfortunately, it does depend on
> that one:
>=20
> https://patchwork.kernel.org/patch/2212081/
>
> If you did not already pulled the first one I can take both with your
> acked-by.
> Otherwise, I can take only the DTS ones.
>=20
> Is that OK?

Will ack that first patch now. =20

Vaibhav, looks like that first series is still in RFC form; you might want=
=20
to repost it as a non-RFC series.


- Paul
--843723315-1398783849-1369854194=:9052--
