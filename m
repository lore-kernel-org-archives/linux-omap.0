From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/8] OMAP2+: hwmod: find MPU initiator hwmod during in
 _register()
Date: Thu, 24 Feb 2011 02:16:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102240208160.6198@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071146.5874.15334.stgit@twilight.localdomain> <4D651BDC.8040700@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-885077513-1298539017=:6198"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38718 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab1BXJQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 04:16:58 -0500
In-Reply-To: <4D651BDC.8040700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-885077513-1298539017=:6198
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Beno=C3=AEt,

On Wed, 23 Feb 2011, Cousson, Benoit wrote:
> On 2/23/2011 8:11 AM, Paul Walmsley wrote:
> > +=09/*
> > +=09 * XXX Rather than doing a strcmp(), this should test a flag
> > +=09 * set in the hwmod data, inserted by the autogenerator code.
>=20
> What do you mean exactly? Something like a "is_mpu" field set to true=20
> for the mpu? Since we are enforcing a consistent naming for every=20
> hwmods, that looks like a duplication of the name. We will always named=
=20
> this hwmod "mpu", so the strcmp() should be enough.
>=20
> But, maybe I'm missing your point.

I had in mind adding a new flag bit for struct omap_hwmod.flags for this=20
purpose, mostly for these reasons:

1. Russell indicated a preference to avoid strcmp() for this type of
   situation during the clock code merge a few years ago

2. Testing a single bit is much more efficient than calling strcmp(),=20
   which will hopefully make life a little easier when running on an=20
   FPGA emulator

A separate field would of course work as well, but seems more heavyweight=
=20
if there's only one special case.

> > +=09 */
> > +=09if (!strcmp(oh->name, MPU_INITIATOR_NAME))
> > +=09=09mpu_oh =3D oh;
> >=20
> > -=09return ret;
> > +=09return 0;
> >   }


- Paul
--155748971-885077513-1298539017=:6198--
