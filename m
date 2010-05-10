From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 on 36xx with 2.6.34-rc6
Date: Mon, 10 May 2010 22:56:49 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E4049DE@dbde02.ent.ti.com>
References: <AANLkTiljBOjnB4QZ6Df2IRu3Tw79rIZaGX3pkZ3X91cB@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044E4049C6@dbde02.ent.ti.com>
 <AANLkTilqVb-gc6TEyuS3pKuDEIzSJ9X6oRO-GR0YRAKJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51286 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab0EJR1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 13:27:04 -0400
In-Reply-To: <AANLkTilqVb-gc6TEyuS3pKuDEIzSJ9X6oRO-GR0YRAKJ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Steve Sakoman [mailto:sakoman@gmail.com]
> Sent: Monday, May 10, 2010 10:13 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: DSS2 on 36xx with 2.6.34-rc6
>=20
> On Mon, May 10, 2010 at 9:24 AM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
>=20
> >> The image works as expected on a 35xx based Beagle, but when run o=
n
> >> the Beagle xM results in a "HDMI: Out of Range" error from my moni=
tor.
> >> =A0Sadly the monitor won't give me the erroneous timing parameters=
=2E
> >>
> > [Hiremath, Vaibhav] For me it looks like Timing related issue only.=
 And if
> I understand correctly I have seen some mail-threads which were talki=
ng
> about successful bring-up on Beagle-XM board.
> <snip>
> > [Hiremath, Vaibhav] Steve,
> >
> > The AM/DM3730, which is exactly same as OMAP3630 has been supported=
 with
> PSP releases. I would suggest you to refer to the Arago repo -
> >
> > http://arago-project.org/git/people/?p=3Dsriram/ti-psp-omap.git;a=3D=
summary
> >
> > Please note that similar kind of testing/validation has been done o=
n
> AM/DM3730 platform.
>=20
> The Arago PSP kernel does indeed have functional DSS2 on the xM.  But
> it is a 2.6.32 kernel with many, many patches that have not been
> submitted to this list.  For many reasons I prefer to work with the
> linux-omap branch.
>=20
[Hiremath, Vaibhav] Yeah, I can understand.

> Yes, I agree that it is a timing issue.  But it may be due to issues
> in clock setup that are related to detecting the revision of the CPU.
> In particular I notice that there are sections of clock setup code
> that compare to ESX_X without checking for the CPU type.  So there ar=
e
> likely ES1_0 workarounds intended for 34XX that are being done for
> 36XX ES1_0 CPU's.
>=20
[Hiremath, Vaibhav] yes, exactly. This could be DPLL configuration issu=
e also which may be causing due to cpu_is_x() macros.


> In looking at the Arago PSP repo for 2.6.32 I see that there are
> indeed patches for this issue, this one for example:
>=20
> http://arago-project.org/git/projects/?p=3Dlinux-
> omap3.git;a=3Dcommitdiff;h=3D9b6bdff1c68a42614bb1e06315d5c4be99c5c078
>=20
[Hiremath, Vaibhav] Sanjeev has submitted this patch couple of times an=
d is already under review. I am expecting this to get merged soon, Sanj=
eev is following up on this.

The DSS related changes are dependent on this and blocked due to this. =
I will submit them once this patch goes in.

> Obviously this patch needs to be updated for the current tree.  Does
> TI intend to re-base and submit the patches in the arago repo to this
> list?
>=20
[Hiremath, Vaibhav] We are submitting all the patches to the linux-omap=
, we do have list of patches and also following up regularly.=20

I hope you understand the business need also here, sometime due to some=
 high priority issues we could not able to follow up that aggressively.

So you can expect patches anytime in the near future.

Thanks,
Vaibhav
=20
> Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
