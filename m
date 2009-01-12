From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [REVIEW PATCH 08/14] OMAP: CAM: Add ISP Core
Date: Mon, 12 Jan 2009 14:16:28 -0600
Message-ID: <A24693684029E5489D1D202277BE894416429BCC@dlee02.ent.ti.com>
References: <200812161807.37601.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200812161807.37601.hverkuil@xs4all.nl>
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
To: Hans Verkuil <hverkuil@xs4all.nl>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla,
	Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Hans Verkuil [mailto:hverkuil@xs4all.nl]

<snip>

> > +               {
> > +                       .id =3D V4L2_CID_PRIVATE_ISP_COLOR_FX,
> > +                       .type =3D V4L2_CTRL_TYPE_INTEGER,
> > +                       .name =3D "Color Effects",
>=20
> What does this do? It definitely looks like this should be a menu, not
> an integer control. Forcing color to B&W is something that other hardwa=
re
> can do as well, so I think this is a very good candidate for a generic
> user control, rather than driver specific.

This basically enables some common color effects on image processing:
- Default colors (i.e. original captured colors)
- Sepia colored images
- B&W colored images.

I think its generic enough to propose for a new generic user CID.

Ok, so, should I keep the Private CID as a menu type ctrl by now?

>=20
> > +                       .minimum =3D PREV_DEFAULT_COLOR,
> > +                       .maximum =3D PREV_BW_COLOR,
> > +                       .step =3D 1,
> > +                       .default_value =3D PREV_DEFAULT_COLOR,
> > +               },
> > +               .current_value =3D PREV_DEFAULT_COLOR,
> > +       }
> > +};
> > +

<snip>

> > +
> > +       if (((isp_obj.if_status =3D=3D ISP_PARLL) && (if_t =3D=3D ISP=
_CSIA)) ||
> > +                               ((isp_obj.if_status =3D=3D ISP_CSIA) =
&&
> > +                               (if_t =3D=3D ISP_PARLL)) ||
> > +                               ((isp_obj.if_status =3D=3D ISP_CSIA) =
&&
> > +                               (if_t =3D=3D ISP_CSIB)) ||
> > +                               ((isp_obj.if_status =3D=3D ISP_CSIB) =
&&
> > +                               (if_t =3D=3D ISP_CSIA)) ||
> > +                               (isp_obj.if_status =3D=3D 0)) {
>=20
> Hard to understand. Why not:
>=20
>        if ((isp_obj.if_status =3D=3D ISP_PARLL && if_t =3D=3D ISP_CSIA)=
 ||
>            (isp_obj.if_status =3D=3D ISP_CSIA && if_t =3D=3D ISP_PARLL)=
 ||
>            (isp_obj.if_status =3D=3D ISP_CSIA && if_t =3D=3D ISP_CSIB) =
||
>            (isp_obj.if_status =3D=3D ISP_CSIB && if_t =3D=3D ISP_CSIA) =
||
>            isp_obj.if_status =3D=3D 0) {
>=20

Done

> > +               isp_obj.if_status |=3D if_t;
> > +               return 0;
> > +       } else {
> > +               DPRINTK_ISPCTRL("ISP_ERR : Invalid Combination Serial=
- \
> > +                       Parallel interface\n");
> > +               return -EINVAL;
> > +       }
> > +}
> > +EXPORT_SYMBOL(isp_request_interface);

<snip>

> > +       /* CONTROL_ */
> > +       omap_writel(
> > +               /* CSIb receiver data/clock or data/strobe mode */
> > +               (config->u.csi.signalling << 10)
> > +               | BIT(12)       /* Enable differential transceiver */
> > +               | BIT(13)       /* Disable reset */
> > +#ifdef TERM_RESISTOR
>=20
> What is this define? It doesn't seem to be documented.

This define is to enable/disable an OMAP34xx internal resistor for CSIb (=
CCP2) camera port.

A comment along its declaration should be enough?

Thanks for your time.

Regards,
Sergio

>=20
> Regards,
>=20
> 	Hans
>=20

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
