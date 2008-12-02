From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Tue, 2 Dec 2008 14:10:49 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904F1E7@dbde02.ent.ti.com>
References: <200812020034.53544.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200812020034.53544.david-b@pacbell.net>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, December 02, 2008 2:05 PM
> To: Hiremath, Vaibhav
> Cc: dbrownell@users.sourceforge.net; video4linux-list@redhat.com;
> davinci-linux-open-source-bounces@linux.davincidsp.com; linux-
> omap@vger.kernel.org; Jadav, Brijesh R; Shah, Hardik; Hadli,
> Manjunath; R, Sivaraj; Karicheri, Muralidharan
> Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
>=20
> On Monday 01 December 2008, David Brownell wrote:
> > > =A0=A0=A0=A0=A0=A0=A0=A0- Pointer to init_reg_seq, which is pointer=
 to array of
> structure
> > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0for tvp514x_regs. This is little bit ug=
ly, since will
> have to
> > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0export tvp514x_regs structure.
> >
> > The platform_data should not hold such stuff; it's not board-
> specific.
> > I'd expect platform_data to hold regulator_init_data as needed to
> > instantiate the regulator; and maybe other stuff needed on this
> board
> > too. =A0Floor and ceiling parameters, maybe, unless they change at
> runtime.
>=20
> Apologies, I was confusing this driver with another.  For a video
> codec, the platform_data should say things like which of the dozen
> or so input channels are wired up, and how; and how the outputs
> are encoded (8 bits, 2x 8 bits, 10 bits, 2x 10 bits, etc).  Nothing
> to do with regulators or DVFS.
>=20
> And the id parameter to probe() is enough to tell whether this is
> a '46 device, with extra registers and input channels, or a '47
> that's less capable (but lower power, etc).
>=20
>=20
[Hiremath, Vaibhav] To avoid any more confusion, I will post the patch ag=
ain for review, which will give you clear picture.

> > The init sequence wouldn't matter at all for i2c_get_clientdata(),
> > since it should only kick in during probe().
>=20
>=20


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
