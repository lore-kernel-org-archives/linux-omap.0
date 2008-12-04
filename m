From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] Add OMAP2 camera driver
Date: Thu, 4 Dec 2008 12:28:52 -0600
Message-ID: <A24693684029E5489D1D202277BE894415C11947@dlee02.ent.ti.com>
References: <49367FD3.6080003@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <49367FD3.6080003@nokia.com>
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
To: Sakari Ailus <sakari.ailus@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> Sakari Ailus wrote:
> ext Hiremath, Vaibhav wrote:
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
> I think that the OMAP 3 stuff could go into a separate directory, say
> omap3 or omap3isp. But for the OMAP 1 or OMAP 2 camera drivers, I'd
> perhaps just prefix those with corresponding OMAP (omap1 etc.).
>=20
> The current OMAP 3 camera driver has few dependencies to OMAP 3 left so
> it seems that it's going to be generic. It's just a question of when th=
e
> OMAP 3 ISP driver can offer a better interface towards the camera drive=
r.
>=20
[Aguirre, Sergio] Hi, I have some comments about this:

IMHO, I think that we can keep same names for OMAP3 camera driver, and ke=
ep it at the same level than omap1 and omap2 cam drivers, but for isp fol=
der, I agree with Sakari that has to be named omap3isp.

Although the end result of making OMAP3 cam driver independent from ISP d=
oesn't make much sense to me, as in OMAP3 the ISP is needed even for the =
minimal handling required for receiving data from the sensors that the ca=
mera driver supports. (Minimal datapath is CCP2->SDRAM or CSI2->SDRAM, an=
d that requires ISP MMU and the corresponding receivers, which are consid=
ered part of the ISP)

About display filenames, if they are compatible with all OMAP versions (1=
, 2, 3), then current name makes sense, if no, then omap3_vout* will look=
 clearer.

What do you think?

Regards,
Sergio


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
