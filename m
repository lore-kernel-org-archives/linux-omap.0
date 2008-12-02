From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Tue, 2 Dec 2008 00:34:52 -0800
Message-ID: <200812020034.53544.david-b@pacbell.net>
References: <19F8576C6E063C45BE387C64729E739403E904F156@dbde02.ent.ti.com> <200812012238.54240.david-b@pacbell.net>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:44760 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751289AbYLBIe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 03:34:56 -0500
In-Reply-To: <200812012238.54240.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>

On Monday 01 December 2008, David Brownell wrote:
> > =A0=A0=A0=A0=A0=A0=A0=A0- Pointer to init_reg_seq, which is pointer=
 to array of structure
> > =A0 =A0=A0=A0=A0=A0=A0=A0=A0for tvp514x_regs. This is little bit ug=
ly, since will have to=20
> > =A0 =A0=A0=A0=A0=A0=A0=A0=A0export tvp514x_regs structure.
>=20
> The platform_data should not hold such stuff; it's not board-specific=
=2E
> I'd expect platform_data to hold regulator_init_data as needed to
> instantiate the regulator; and maybe other stuff needed on this board
> too. =A0Floor and ceiling parameters, maybe, unless they change at ru=
ntime.

Apologies, I was confusing this driver with another.  For a video
codec, the platform_data should say things like which of the dozen
or so input channels are wired up, and how; and how the outputs
are encoded (8 bits, 2x 8 bits, 10 bits, 2x 10 bits, etc).  Nothing
to do with regulators or DVFS.

And the id parameter to probe() is enough to tell whether this is
a '46 device, with extra registers and input channels, or a '47
that's less capable (but lower power, etc).

=20
> The init sequence wouldn't matter at all for i2c_get_clientdata(),
> since it should only kick in during probe().


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
