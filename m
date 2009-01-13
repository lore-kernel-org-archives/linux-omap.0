From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012 sensor	driver
 v2
Date: Mon, 12 Jan 2009 20:35:07 -0600
Message-ID: <A24693684029E5489D1D202277BE894416429FAD@dlee02.ent.ti.com>
References: <1231813843.29324.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <1231813843.29324.2.camel@localhost>
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
To: "stanley.miao@windriver.com" <stanley.miao@windriver.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Stanley,

I'm currently have that patch on hold, along with the ISP wrapper because=
 I'm reworking them, and also I wanted first to be sure the OMAP3 camera =
core gets pushed (that's why I included only one sensor driver, to be abl=
e to test at least the camera core), and that way I feel it'll be more ea=
sier that the OV3640 sensor gets accepted after that.

Thanks for the interest.

Regards,
Sergio

> -----Original Message-----
> From: stanley.miao [mailto:stanley.miao@windriver.com]
> Sent: Monday, January 12, 2009 8:31 PM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org; video4linux-list@redhat.com; Nagalla,
> Hari; Sakari Ailus; Tuukka.O Toivonen; linux-media@vger.kernel.org
> Subject: Re: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012 sensor
> driver v2
>=20
> Hi,Sergio,
>=20
> I saw you had a ov3640 patch in omapzoom tree. Why don't you submit it
> together ?
>=20
> Stanley.
>=20
> On Mon, 2009-01-12 at 20:03 -0600, Aguirre Rodriguez, Sergio Alberto
> wrote:
> > Hi,
> >
> > I'm sending the following patchset for review to the relevant lists
> (linux-omap, v4l, linux-media).
> >
> > Includes:
> >  - Omap3 camera core + ISP drivers.
> >  - MT9P012 sensor driver (adapted to 3430SDP)
> >  - DW9710 lens driver (adapted to work with MT9P012 for SDP)
> >  - Necessary v4l2-int-device changes to make above drivers work
> >  - Redefine OMAP3 ISP platform device.
> >  - Review comments fixed from: (Thanks a lot for their time and help)
> >    - Hans Verkuil
> >    - Tony Lindgreen
> >    - Felipe Balbi
> >    - Vaibhav Hiremath
> >    - David Brownell
> >
> > Some notes:
> >  - Uses v4l2-int-device solution.
> >  - Tested with 3430SDP ES3.0 VG5.0.1 with Camkit v3.0.1
> >  - Applies cleanly on top of commit
> 0ec95b96fd77036a13398c66901e11cd301190d0 by Jouni Hogander (OMAP3: PM:
> Emu_pwrdm is switched off by hardware even when sdti is in use)
> >  - ISP wrappers dropped from the patchset, as a rework is going on
> currently.
> >
> >
> > I appreciate in advance your time.
> >
> > Regards,
> > Sergio
> >
> > --
> > video4linux-list mailing list
> > Unsubscribe mailto:video4linux-list-
> request@redhat.com?subject=3Dunsubscribe
> > https://www.redhat.com/mailman/listinfo/video4linux-list


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
