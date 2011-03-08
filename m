From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Tue, 8 Mar 2011 19:07:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C0E63AA@dbde02.ent.ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com>
 <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
 <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
 <4D762512.6060503@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E6385@dbde02.ent.ti.com>
 <AANLkTikaY5kjbFJtUcnwTOoZJjn6BL8oqXN+B6x_fxav@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54721 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754897Ab1CHNhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 08:37:34 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28DbVpJ007258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 07:37:33 -0600
In-Reply-To: <AANLkTikaY5kjbFJtUcnwTOoZJjn6BL8oqXN+B6x_fxav@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Tuesday, March 08, 2011 6:58 PM
> To: Premi, Sanjeev
> Cc: Sripathy, Vishwanath; linux-omap@vger.kernel.org
> Subject: Re: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
>=20
> On Tue, Mar 8, 2011 at 18:48, Premi, Sanjeev <premi@ti.com> wrote:
> [...]
> >> Thinking from a generic soln perspective, lets try and split this =
into
> >> multiple issues:
> >> a) OPP and Voltage layer voltages - these need to be PMIC aware as
> well.
> >> See my comment on http://marc.info/?l=3Dlinux-omap&m=3D12995500361=
1548&w=3D2
> >> -> essentially means that pmic_voltage information should be regis=
tered
> >> earlier to opp init
> >>
> >> b) split up structure information for voltage layer - this should =
be
> >> done in a manner to make PMIC, Board and OMAP SoC information
> independent.
> >>
> >> c) Ability to plug in multiple PMICs in two manners:
> >> =A0 =A0 i) use PMIC with VC/VP/SR combinations.
> >> =A0 =A0 ii) use PMIC which is plugged on regulator frameworks.
> >>
> >> If anyone is attempting cleanups, it might be a good idea to base =
on
> the
> >> accepted cleanups from pm-core branch which is planned for 39-rc1 =
to
> >> prevent any surprises ;)
> >
> > [sp] Without trying to understand much internal details on the prop=
osed
> > =A0 =A0 solution, workaround is necessary to get AM35x platforms to=
 even
> boot
> > =A0 =A0 on current baselines.
> >
> > =A0 =A0 Using regulator framework etc. are long poles; that can eas=
ily be
> > =A0 =A0 avoided; and this RFC was meant for that.
> >
> > =A0 =A0 Knowing that there is already a clean-up effort; simple wor=
karound
> > =A0 =A0 makes even better proposition.
> Personally speaking, it is better we do the cleanup and integrate to
> mainline. since we are in the process of cleaning up, it might be a
> good idea for contributions from you and all interested folks to
> ensure that the final code will support the configurations we all nee=
d
> :)
>=20
> meanwhile, any temp hacks might be better off in private trees is my =
2
> cents..

[sp] There is a "thick" red line between hack and workaround :)
     Subtle... but both have their utility at specific instances.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
