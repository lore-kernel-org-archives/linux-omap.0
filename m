From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 04:57:01 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83ECC9548@DBDE04.ent.ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab3FZE5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 00:57:32 -0400
In-Reply-To: <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rini, Tom" <trini@ti.com>, "khilman@ti.com" <khilman@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, June 25, 2013 11:51 PM
> To: Balbi, Felipe
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Rini, Tom; Hiremath, Vaibhav; khilman@ti.com
> Subject: Re: OMAP baseline test results for v3.10-rc6
>=20
> + Vaibhav and Kevin
>=20
> Hi,
>=20
> On Tue, 25 Jun 2013, Felipe Balbi wrote:
>=20
> > On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
> > > Boot to userspace:
> > >     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt
> >
> > Paul, we have at least 2 different folks who can't reproduce your
> bone
> > and bone black boot to userspace failures. I wonder how you're tryi=
ng
> to
> > boot them.
> >
> > Care to share your test scripts ?
>=20
> Sure... the methodology is completely open and has been posted in the
> online logs since the first test cycle.  (For some reason, almost no
> one
> clicks through the test directory trees that I post online.  Is this =
a
> documentation issue?  What can we do to make it easier for people to
> explore this?)
>=20


That=92s not quite true, I remember going through your log in detail mu=
ltiple
Times.

The issue is, for appended DTB you must enable 2 config options,

CONFIG_ARM_APPENDED_DTB =3D y
CONFIG_ARM_ATAG_DTB_COMPAT =3D y

OR

If you don=92t want to change/modify default config (omap2plus_defconfi=
g),=20
Use separate DTB and zImage, which is standard way of booting kernel.

Same applies to BeagleBone Black. Infact same DTB and zImage boots up f=
ine
On both boards without any issues.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
