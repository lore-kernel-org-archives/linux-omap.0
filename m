From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Wed, 25 Apr 2012 05:48:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54909 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173Ab2DYFsT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 01:48:19 -0400
In-Reply-To: <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 25, 2012 at 06:33:26, Paul Walmsley wrote:
> Hello Vaibhav, Afzal, Vaibhav,
>=20
> On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:
>=20
> > AM33XX clock implementation is different than any existing OMAP
> > family of devices. Although DPLL module is similar to OMAP4
> > device, but the usage is very much different than OMAP4.
> > AM33XX has different peripheral set and each module gets
> > integrated to the clock framework differently than OMAP
> > family of devices.
> >=20
> > This patch adds full Clock tree data for AM33XX family
> > of devices and also integrates it into existing OMAP framework.
>=20
> What do you think about the possibility of removing all of the leaf c=
locks
> that have AM33XX_MODULEMODE_SWCTRL as their .enable_bit, assuming the=
re=20
> are no .fixed_div or .clksel* fields associated with the clocks?
>=20
> In theory, I don't think they are needed.  The drivers should be usin=
g=20
> runtime PM, and that should enable and disable the module via the hwm=
od=20
> code, rather than the clock code.
>=20
> Of course some clocks would still be needed for the main_clk fields f=
or=20
> the hwmods, but the hwmods should be able to use the leaf clock's par=
ent=20
> clocks for that.
>=20
> That would save quite a few lines of data.  And I think Beno=EEt is p=
lanning=20
> to do that for OMAP4+.
>=20
> What do you think?
>=20

Paul,

Yes, theoretically it is possible to do it. But it will also break some=
 of=20
the existing things, like,

1. DebugFS clock interface

I believe, with this change, you will not have all the leaf nodes as pa=
rt of clock tree, so they will not be populated in /debug/clock/

2. Enable and disable of the module is one part, but what about, changi=
ng=20
   the rate of the clock (followparent_recalc)?=20
   With the proper and complete clock tree, you can traverse the clock =
and=20
   driver code doesn't need to know about parent.=20
   Driver can simply call clk_set_rate() on leaf clock, and clock tree =
will=20
   handle it.

If at all we take this path, we have to build the clk node runtime=20
(on-the-fly), AND/OR add new pm_runtime_set_rate() api.

Are you available on IRC chat anytime? We can discuss on this and align=
=20
quickly.
I am available on linux-omap irc channel (with the name =3D "hvaibhav")

Thanks,
Vaibhav

>=20
> - Paul
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
