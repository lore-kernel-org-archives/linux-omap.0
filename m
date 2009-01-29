From: David Brownell <david-b@pacbell.net>
Subject: Re: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter Card Support
Date: Wed, 28 Jan 2009 23:20:56 -0800
Message-ID: <200901282320.56988.david-b@pacbell.net>
References: <19F8576C6E063C45BE387C64729E739403FA78FFC5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:42875 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751916AbZA2HU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jan 2009 02:20:59 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA78FFC5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>


> > > +config MACH_OMAP3EVM_DC
> > > +=A0=A0=A0=A0=A0=A0=A0bool "OMAP 3530 EVM daughter card board"
> > > +=A0=A0=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX && M=
ACH_OMAP3EVM
> >=20
> > There can be other daughtercards, so the Kconfig text should
> > say which specific card is being configured.  And it should
> > probably use the "zero or one of these choices" syntax, so
> > it's easier to include other options..
> >=20
> [Hiremath, Vaibhav] I do agree with this point, but as of now I
> believe there is only one Daughter card which is available with
> us. And I would prefer to have menu option for the future when
> any new daughter card available and gets added to tree.  =20
>
> Any other opinions would be helpful?

Nothing particular.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
