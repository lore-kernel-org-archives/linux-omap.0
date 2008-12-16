From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [REVIEW PATCH 13/14] OMAP: CAM: Add Lens Driver
Date: Tue, 16 Dec 2008 14:24:56 -0600
Message-ID: <A24693684029E5489D1D202277BE894415FC92FD@dlee02.ent.ti.com>
References: <208cbae30812112203o6be4974epb87b3810e2de3581@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <208cbae30812112203o6be4974epb87b3810e2de3581@mail.gmail.com>
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
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla,
	Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Alexey Klimov
> Sent: Friday, December 12, 2008 12:03 AM

> On Thu, Dec 11, 2008 at 11:38 PM, Aguirre Rodriguez, Sergio Alberto
> <saaguirre@ti.com> wrote:
> > >From 1341b74f5a90e4aa079a4fcb4fe2127ff344cce7 Mon Sep 17 00:00:00 20=
01
> > From: Sergio Aguirre <saaguirre@ti.com>
> > Date: Thu, 11 Dec 2008 13:35:46 -0600
> > Subject: [PATCH] OMAP: CAM: Add Lens Driver
> >
> > This adds the DW9710 Lens driver
> >
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > ---

> > +#define DRIVER_NAME  "dw9710"
>=20
> Here you define DRIVER_NAME. I saw patch(for another module) that
> remover MODULE_NAME and places VIVI_MODULE_NAME there. Here it is:
> http://linuxtv.org/hg/v4l-dvb/rev/58b95134acb8
>=20
> May be it's better to define something like this: #define
> DW9710_DRIVER_NAME  "dw9710" ?
>=20
> Probably it will help you to avoid possible namespace conflicts and
> code become a bit more readible.
[Aguirre, Sergio] You're right. Thanks.

>=20
> > +static int
> > +dw9710_probe(struct i2c_client *client, const struct i2c_device_id
> *id);
> > +static int __exit dw9710_remove(struct i2c_client *client);
> > +
> > +struct dw9710_device {
> > +       const struct dw9710_platform_data *pdata;
> > +       struct v4l2_int_device *v4l2_int_device;
> > +       struct i2c_client *i2c_client;
> > +       int opened;
> > +       u16 current_lens_posn;
> > +       u16 saved_lens_posn;
> > +       int state;
> > +       int power_state;
> > +};
> > +
> > +static const struct i2c_device_id dw9710_id[] =3D {
> > +       { DW9710_NAME, 0 },
> > +       { }
> > +};
>=20
> Hmmm, looks like you already defined DW9710_NAME in header-file. Why
> didn't you reformat to use _one_ define for this and previous place ?
>=20
> > +MODULE_DEVICE_TABLE(i2c, dw9710_id);
> > +
> > +static struct i2c_driver dw9710_i2c_driver =3D {
> > +       .driver =3D {
> > +               .name =3D DW9710_NAME,
>=20
> Actually, the same thing here.
>=20

[Aguirre, Sergio] Ok, done. Now I use only one define: DW9710_NAME. Thank=
s.

> > +static int
> > +find_vctrl(int id)
> > +{
> > +       int i;
> > +
> > +       if (id < V4L2_CID_BASE)
> > +               return -EDOM;
> > +
> > +       for (i =3D (ARRAY_SIZE(video_control) - 1); i >=3D 0; i--)
> > +               if (video_control[i].qc.id =3D=3D id)
> > +                       break;
> > +       if (i < 0)
> > +               i =3D -EINVAL;
> > +       return i;
> > +}
>=20
> In this function you use return after if, and in second place you set
> i equals to -EINVAL, and then return. Probably, to make it more easily
> to read it's better to do such thing:
>=20
> if (i < 0)
> return -EINVAL;
>=20
[Aguirre, Sergio] Ok, I agree it's a bit confusing... I have rewritten th=
e function to be more simple, is it ok now?:

static int find_vctrl(int id)
{
	int i;

	if (id < V4L2_CID_BASE)
		return -EDOM;

	for (i =3D (ARRAY_SIZE(video_control) - 1); i >=3D 0; i--) {
		if (video_control[i].qc.id =3D=3D id)
			return i;
	}

	return -EINVAL;
}

> > +       if (wposn !=3D rposn) {
> > +               printk(KERN_ERR "W/R MISMATCH!\n");
>=20
> If I were writing it, I'd do the following:
>=20
> printk(KERN_ERR DRIVER_NAME "W/R MISMATCH!\n");
>=20
> And driver-name have to be unique, see above.
> To be onest it's better to provide module name to dmesg if you(or any
> user) want to catch bad behavour.
[Aguirre, Sergio] Ok, point taken. Thanks.

> > +int dw9710_af_getfocus(u16 *value)
> > +{
> > +       int ret =3D -EINVAL;
> > +       u16 posn =3D 0;
>=20
> Why just don't use int ret;
> And later in code use return -EINVAL; ?
> Anyway, you change ret variable with reg_read call.
[Aguirre, Sergio] Ok, Makes sense. Thanks.
>=20
> > +       struct dw9710_device *af_dev =3D &dw9710;
> > +       struct i2c_client *client =3D af_dev->i2c_client;
> > +
> > +       if ((af_dev->power_state =3D=3D V4L2_POWER_OFF) ||
> > +          (af_dev->power_state =3D=3D V4L2_POWER_STANDBY))
> > +               return ret;
> > +
> > +       ret =3D camaf_reg_read(client, &posn);
> > +
> > +       if (ret) {
> > +               printk(KERN_ERR "Read of current Lens position
> failed\n");
> > +               return ret;
> > +       }
> > +       *value =3D CAMAF_DW9710_DATA_R(posn);
> > +       dw9710.current_lens_posn =3D CAMAF_DW9710_DATA_R(posn);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(dw9710_af_getfocus);

> > +       if ((on =3D=3D V4L2_POWER_ON) && (lens->state =3D=3D LENS_NOT=
_DETECTED))
> {
> > +               rval =3D dw9710_detect(c);
> > +               if (rval < 0) {
> > +                       dev_err(&c->dev, "Unable to detect "
> > +                               DRIVER_NAME " lens HW\n");
> > +                       printk(KERN_ERR "Unable to detect "
> > +                               DRIVER_NAME " lens HW\n");
>=20
> Two thing here. As i know it's more preferable to use dev_macro
> instead of printk if possible.
> As i know(may be i'm wrong) it's not good to use DRIVER_NAME in dev_err
> here.
> Why do you print the same text two times here ?
[Aguirre, Sergio] Ok, cleaning this up. Thanks

> > +static int __init dw9710_init(void)
> > +{
> > +       int err =3D -EINVAL;
>=20
> int err =3D something, and then changed with call to i2c..
>=20
> This is all i can suggest, it's not about functionality, it's about
> coding style..
> Please, use dev_macros if possible instead of printk.
>=20
[Aguirre, Sergio] Ok, will do that. Thanks

I really appreciate all your time doing this.


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
