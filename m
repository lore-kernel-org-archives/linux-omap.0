From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
Date: Fri, 29 Jun 2012 14:57:18 +0200
Message-ID: <20120629145718.697b6955@endymion.delvare>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
	<1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
	<20120629144002.3b4a31ee@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120629144002.3b4a31ee-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jun 2012 14:40:02 +0200, Jean Delvare wrote:
> On Fri, 29 Jun 2012 16:35:27 +0530, Shubhrajyoti D wrote:
> > In i2c_smbus_xfer_emulated initialise the actual bytes
> > to zero.
> >=20
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index a6ad32b..fa7f799 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1949,8 +1949,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c=
_adapter *adapter, u16 addr,
> >  	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
> >  	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
> >  	int num =3D read_write =3D=3D I2C_SMBUS_READ ? 2 : 1;
> > -	struct i2c_msg msg[2] =3D { { addr, flags, 1, msgbuf0 },
> > -	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
> > +	struct i2c_msg msg[2] =3D { { addr, flags, 1, 0, msgbuf0 },
> > +				  { addr, flags | I2C_M_RD, 0, 0, msgbuf1 }
> >  	                        };
> >  	int i;
> >  	u8 partial_pec =3D 0;
>=20
> Please convert to C99-style initialization while you're there. And th=
is
> should be done first. Initializing i2c_msg.actual maybe rather belong
> to i2c_transfer though, so that all callers don't have to care.
>=20
> Are you sure there are no other places that need the same fix in the
> kernel tree?

Actually I'm sure there are. At least:

drivers/video/matrox/matroxfb_maven.c: In function =E2=80=98maven_get_r=
eg=E2=80=99:
drivers/video/matrox/matroxfb_maven.c:140:9: warning: initialization ma=
kes integer from pointer without a cast [enabled by default]
drivers/video/matrox/matroxfb_maven.c:140:9: warning: (near initializat=
ion for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/video/matrox/matroxfb_maven.c:141:6: warning: initialization ma=
kes integer from pointer without a cast [enabled by default]
drivers/video/matrox/matroxfb_maven.c:141:6: warning: (near initializat=
ion for =E2=80=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/media/video/ks0127.c: In function =E2=80=98ks0127_read=E2=80=99=
:
drivers/media/video/ks0127.c:322:3: warning: initialization makes integ=
er from pointer without a cast [enabled by default]
drivers/media/video/ks0127.c:322:3: warning: (near initialization for =E2=
=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/media/video/ks0127.c:323:3: warning: initialization makes integ=
er from pointer without a cast [enabled by default]
drivers/media/video/ks0127.c:323:3: warning: (near initialization for =E2=
=80=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/media/video/tvaudio.c: In function =E2=80=98chip_read2=E2=80=99=
:
drivers/media/video/tvaudio.c:221:3: warning: initialization makes inte=
ger from pointer without a cast [enabled by default]
drivers/media/video/tvaudio.c:221:3: warning: (near initialization for =
=E2=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/media/video/tvaudio.c:222:3: warning: initialization makes inte=
ger from pointer without a cast [enabled by default]
drivers/media/video/tvaudio.c:222:3: warning: (near initialization for =
=E2=80=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-x1205.c: In function =E2=80=98x1205_get_datetime=E2=80=99=
:
drivers/rtc/rtc-x1205.c:100:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:100:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:101:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:101:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c: In function =E2=80=98x1205_get_status=E2=80=99=
:
drivers/rtc/rtc-x1205.c:145:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:145:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:146:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:146:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c: In function =E2=80=98x1205_get_dtrim=E2=80=99:
drivers/rtc/rtc-x1205.c:282:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:282:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:283:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:283:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c: In function =E2=80=98x1205_get_atrim=E2=80=99:
drivers/rtc/rtc-x1205.c:314:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:314:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:315:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:315:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c: In function =E2=80=98x1205_validate_client=E2=80=
=99:
drivers/rtc/rtc-x1205.c:384:4: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:384:4: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:385:4: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:385:4: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:412:4: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:412:4: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:413:4: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:413:4: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c: In function =E2=80=98x1205_rtc_read_alarm=E2=80=
=99:
drivers/rtc/rtc-x1205.c:447:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:447:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-x1205.c:448:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:448:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-s35390a.c: In function =E2=80=98s35390a_set_reg=E2=80=99=
:
drivers/rtc/rtc-s35390a.c:53:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-s35390a.c:53:3: warning: (near initialization for =E2=80=
=98msg[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-s35390a.c: In function =E2=80=98s35390a_get_reg=E2=80=99=
:
drivers/rtc/rtc-s35390a.c:66:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-s35390a.c:66:3: warning: (near initialization for =E2=80=
=98msg[0].actual=E2=80=99) [enabled by default]

  CC [M]  drivers/media/video/msp3400-kthreads.o
drivers/media/video/msp3400-driver.c: In function =E2=80=98msp_reset=E2=
=80=99:
drivers/media/video/msp3400-driver.c:122:3: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:122:3: warning: (near initializati=
on for =E2=80=98reset[0].actual=E2=80=99) [enabled by default]
drivers/media/video/msp3400-driver.c:123:3: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:123:3: warning: (near initializati=
on for =E2=80=98reset[1].actual=E2=80=99) [enabled by default]
drivers/media/video/msp3400-driver.c:126:3: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:126:3: warning: (near initializati=
on for =E2=80=98test[0].actual=E2=80=99) [enabled by default]
drivers/media/video/msp3400-driver.c:127:3: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:127:3: warning: (near initializati=
on for =E2=80=98test[1].actual=E2=80=99) [enabled by default]
drivers/media/video/msp3400-driver.c: In function =E2=80=98msp_read=E2=80=
=99:
drivers/media/video/msp3400-driver.c:146:3: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:146:3: warning: (near initializati=
on for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/media/video/msp3400-driver.c:147:3: warning: initialization mak=
es integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:147:3: warning: (near initializati=
on for =E2=80=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-rs5c372.c: In function =E2=80=98rs5c_get_regs=E2=80=99:
drivers/rtc/rtc-rs5c372.c:107:3: warning: initialization makes integer =
from pointer without a cast [enabled by default]
drivers/rtc/rtc-rs5c372.c:107:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-pcf8563.c: In function =E2=80=98pcf8563_get_datetime=E2=
=80=99:
drivers/rtc/rtc-pcf8563.c:80:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-pcf8563.c:80:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-pcf8563.c:81:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-pcf8563.c:81:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-isl1208.c: In function =E2=80=98isl1208_i2c_read_regs=E2=
=80=99:
drivers/rtc/rtc-isl1208.c:71:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-isl1208.c:71:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-isl1208.c:73:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-isl1208.c:73:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-isl1208.c: In function =E2=80=98isl1208_i2c_set_regs=E2=
=80=99:
drivers/rtc/rtc-isl1208.c:93:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-isl1208.c:93:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-em3027.c: In function =E2=80=98em3027_get_time=E2=80=99=
:
drivers/rtc/rtc-em3027.c:52:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-em3027.c:52:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-em3027.c:53:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-em3027.c:53:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-em3027.c: In function =E2=80=98em3027_set_time=E2=80=99=
:
drivers/rtc/rtc-em3027.c:79:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-em3027.c:79:3: warning: (near initialization for =E2=80=
=98msg.actual=E2=80=99) [enabled by default]

drivers/rtc/rtc-ds1672.c: In function =E2=80=98ds1672_get_datetime=E2=80=
=99:
drivers/rtc/rtc-ds1672.c:40:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:40:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-ds1672.c:41:3: warning: initialization makes integer fr=
om pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:41:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-ds1672.c: In function =E2=80=98ds1672_get_control=E2=80=
=99:
drivers/rtc/rtc-ds1672.c:102:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:102:3: warning: (near initialization for =E2=80=
=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/rtc/rtc-ds1672.c:103:3: warning: initialization makes integer f=
rom pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:103:3: warning: (near initialization for =E2=80=
=98msgs[1].actual=E2=80=99) [enabled by default]

drivers/media/radio/saa7706h.c: In function =E2=80=98saa7706h_get_reg16=
=E2=80=99:
drivers/media/radio/saa7706h.c:202:9: warning: initialization makes int=
eger from pointer without a cast [enabled by default]
drivers/media/radio/saa7706h.c:202:9: warning: (near initialization for=
 =E2=80=98msg[0].actual=E2=80=99) [enabled by default]
drivers/media/radio/saa7706h.c:203:5: warning: initialization makes int=
eger from pointer without a cast [enabled by default]
drivers/media/radio/saa7706h.c:203:5: warning: (near initialization for=
 =E2=80=98msg[1].actual=E2=80=99) [enabled by default]

drivers/media/radio/radio-tea5764.c: In function =E2=80=98tea5764_i2c_r=
ead=E2=80=99:
drivers/media/radio/radio-tea5764.c:155:4: warning: initialization make=
s integer from pointer without a cast [enabled by default]
drivers/media/radio/radio-tea5764.c:155:4: warning: (near initializatio=
n for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/media/radio/radio-tea5764.c: In function =E2=80=98tea5764_i2c_w=
rite=E2=80=99:
drivers/media/radio/radio-tea5764.c:170:3: warning: initialization make=
s integer from pointer without a cast [enabled by default]
drivers/media/radio/radio-tea5764.c:170:3: warning: (near initializatio=
n for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]

drivers/media/radio/si470x/radio-si470x-i2c.c: In function =E2=80=98si4=
70x_get_register=E2=80=99:
drivers/media/radio/si470x/radio-si470x-i2c.c:102:4: warning: initializ=
ation makes integer from pointer without a cast [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c:102:4: warning: (near ini=
tialization for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c: In function =E2=80=98si4=
70x_set_register=E2=80=99:
drivers/media/radio/si470x/radio-si470x-i2c.c:123:4: warning: initializ=
ation makes integer from pointer without a cast [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c:123:4: warning: (near ini=
tialization for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c: In function =E2=80=98si4=
70x_get_all_registers=E2=80=99:
drivers/media/radio/si470x/radio-si470x-i2c.c:150:4: warning: initializ=
ation makes integer from pointer without a cast [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c:150:4: warning: (near ini=
tialization for =E2=80=98msgs[0].actual=E2=80=99) [enabled by default]

drivers/gpu/drm/nouveau/nouveau_bios.c: In function =E2=80=98init_i2c_l=
ong_if=E2=80=99:
drivers/gpu/drm/nouveau/nouveau_bios.c:3534:3: warning: initialization =
makes integer from pointer without a cast [enabled by default]
drivers/gpu/drm/nouveau/nouveau_bios.c:3534:3: warning: (near initializ=
ation for =E2=80=98msg[0].actual=E2=80=99) [enabled by default]
drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: initialization =
makes integer from pointer without a cast [enabled by default]
drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initializ=
ation for =E2=80=98msg[1].actual=E2=80=99) [enabled by default]

This needs to be all fixed (converted to C99-style struct
initialization) before your patch is considered for inclusion. And
there may be more that my config did not spot.

--=20
Jean Delvare
