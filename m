From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] Add OMAP2 camera driver
Date: Wed, 3 Dec 2008 15:07:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E90E6EBA@dbde02.ent.ti.com>
References: <C8A6D84C-B0DE-4169-B9B0-744285908E42@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <C8A6D84C-B0DE-4169-B9B0-744285908E42@student.utwente.nl>
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
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing
	List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> Sent: Wednesday, December 03, 2008 3:04 PM
> To: Hiremath, Vaibhav
> Cc: Trilok Soni; Hans Verkuil; Sakari Ailus; linux-
> omap@vger.kernel.org Mailing List; video4linux-list@redhat.com
> Subject: Re: [PATCH] Add OMAP2 camera driver
>=20
>=20
> Op 3 dec 2008, om 08:05 heeft Hiremath, Vaibhav het volgende
> geschreven:
> > OMAP3 -
> > 	Display - (Posted twice with old DSS library)
> > 		- omap_vout.c
> > 		- omap_voutlib.c
> > 		- omap_voutlib.h
> > 		- omap_voutdef.h
> > 	Camera - (Will come soon)
> > 		- omap34xxcam.c
> > 		- omap34xxcam.h
> > 	ISP - (Will come soon)
> > 		- Here definitely we will plenty number of files.
>=20
> Isn't DSS2 supposed to work on omap2 (and perhaps omap1) as well?
>=20
[Hiremath, Vaibhav] yes, but the DSS2 library goes under arch/arm/plat-om=
ap/dss/. The above files are belongs to the driver underneath.
=20
> regards,
>=20
> Koen


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
