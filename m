From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v3 07/10] arm: omap4430sdp: Add support for omap4iss
 camera
Date: Mon, 14 May 2012 03:24:30 +0300
Message-ID: <20120514002430.GH3373@valkosipuli.retiisi.org.uk>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
 <1335971749-21258-8-git-send-email-saaguirre@ti.com>
 <20120502194700.GF852@valkosipuli.localdomain>
 <CAKnK67S5zZW0HAUYrg4ZqudiQqcOY+kbZeDeQ1OGU+s+cShBDQ@mail.gmail.com>
 <CAKnK67SZGES33T02Ki3imZi20OKRSRe+u9nONsq2KoEGVz4_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKnK67SZGES33T02Ki3imZi20OKRSRe+u9nONsq2KoEGVz4_0w@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sergio,

On Thu, May 03, 2012 at 10:20:47PM -0500, Aguirre, Sergio wrote:
> Hi Sakari,
>=20
> On Thu, May 3, 2012 at 7:03 AM, Aguirre, Sergio <saaguirre@ti.com> wr=
ote:
> > Hi Sakari,
> >
> > Thanks for reviewing.
> >
> > On Wed, May 2, 2012 at 2:47 PM, Sakari Ailus <sakari.ailus@iki.fi> =
wrote:
> >>
> >> Hi Sergio,
> >>
> >> Thanks for the patches!!
> >>
> >> On Wed, May 02, 2012 at 10:15:46AM -0500, Sergio Aguirre wrote:
> >> ...
> >>> +static int sdp4430_ov_cam1_power(struct v4l2_subdev *subdev, int=
 on)
> >>> +{
> >>> + =A0 =A0 struct device *dev =3D subdev->v4l2_dev->dev;
> >>> + =A0 =A0 int ret;
> >>> +
> >>> + =A0 =A0 if (on) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!regulator_is_enabled(sdp4430_cam2p=
wr_reg)) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_enabl=
e(sdp4430_cam2pwr_reg);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(dev,
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "Error in enabling sensor power regulator 'cam2pwr'\n");
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ret;
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> +
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(50);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> +
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP4430SDP_GPIO_CAM_PDN=
_B, 1);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_enable(sdp4430_cam1_aux_clk=
); /* Enable XCLK */
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Error =
in clk_enable() in %s(%d)\n",
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, on);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP4430=
SDP_GPIO_CAM_PDN_B, 0);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> >>> + =A0 =A0 } else {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(sdp4430_cam1_aux_clk);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP4430SDP_GPIO_CAM_PDN=
_B, 0);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (regulator_is_enabled(sdp4430_cam2pw=
r_reg)) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_disab=
le(sdp4430_cam2pwr_reg);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(dev,
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "Error in disabling sensor power regulator 'cam2pwr'\n");
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ret;
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> + =A0 =A0 }
> >>> +
> >>> + =A0 =A0 return 0;
> >>> +}
> >>
> >> Isn't this something that should be part of the sensor driver? The=
re's
> >> nothing in the above code that would be board specific, except the=
 names of
> >> the clocks, regulators and GPIOs. The sensor driver could hold the=
 names
> >> instead; this would be also compatible with the device tree.
> >
> > Agreed. I see what you mean...
> >
> > I'll take care of that.
>=20
> Can you please check out these patches?
>=20
> 1. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/cb=
6c10d58053180364461e6bc8d30d1ec87e6e22

Ideally we should really get rid of the board code callbacks. What do y=
ou
need to do there?

> 2. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/67=
32e0db25c6647b34ef8f01c244a49a1fd6b45d

Isn't reset voltage level (high or low) a property of the sensor rather=
 than
the board?

Well, I know sometimes the people who typically design the hardware can=
 be
quite inventive. ;)

> 3. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/d6=
1c4e3142dc9cae972f9128fe73d986838c0ca1

> 4. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/e8=
3f36001c7f7cbe184ad094d9b0c95c39e5028f

Cheers,

--=20
Sakari Ailus
e-mail: sakari.ailus@iki.fi	jabber/XMPP/Gmail: sailus@retiisi.org.uk
