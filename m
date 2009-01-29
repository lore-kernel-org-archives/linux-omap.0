From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter Card
 Support
Date: Thu, 29 Jan 2009 12:24:10 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA78FFC5@dbde02.ent.ti.com>
References: <200901111554.10469.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <200901111554.10469.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Monday, January 12, 2009 5:24 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-media@vger.kernel.org;
> video4linux-list@redhat.com; Jadav, Brijesh R; Shah, Hardik; Hadli,
> Manjunath; R, Sivaraj
> Subject: Re: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter
> Card Support
>=20
> On Tuesday 06 January 2009, hvaibhav@ti.com wrote:
> > +config MACH_OMAP3EVM_DC
> > +=A0=A0=A0=A0=A0=A0=A0bool "OMAP 3530 EVM daughter card board"
> > +=A0=A0=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX && MAC=
H_OMAP3EVM
>=20
> There can be other daughtercards, so the Kconfig text should
> say which specific card is being configured.  And it should
> probably use the "zero or one of these choices" syntax, so
> it's easier to include other options..
>=20
[Hiremath, Vaibhav] I do agree with this point, but as of now I believe=
 there is only one Daughter card which is available with us. And I woul=
d prefer to have menu option for the future when any new daughter card =
available and gets added to tree.

Any other opinions would be helpful?

> - Dave
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
