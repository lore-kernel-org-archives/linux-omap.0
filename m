From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Patch series in Tarball submitted (RE: [REVIEW PATCH 00/14]
 OMAP3 camera + ISP + MT9P012 sensor driver v2)
Date: Wed, 14 Jan 2009 08:55:08 -0600
Message-ID: <A24693684029E5489D1D202277BE8944164DFC34@dlee02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739403ECF70CEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CEB@dbde02.ent.ti.com>
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
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Nagalla,
	Hari" <hnagalla@ti.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Wednesday, January 14, 2009 8:51 AM

<snip>

> [Hiremath, Vaibhav] I tried to build camera driver as module and got
> following error -
>=20
> ERROR: "ispmmu_get_mapeable_space" [drivers/media/video/omap34xxcam.ko]
> undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>=20
> You have missed to export this symbol, please correct in next version o=
f
> patches.
>=20

Oops, good catch. Thanks, I'll correct that. No problem.

Regards,
Sergio

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
