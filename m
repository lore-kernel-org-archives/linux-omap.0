From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] Input: omap-keypad: dynamically handle register
 offsets
Date: Mon, 19 Mar 2012 10:33:39 +0200
Message-ID: <20120319083338.GB13774@arwen.pp.htv.fi>
References: <1331907989-11891-1-git-send-email-sourav.poddar@ti.com>
 <1331907989-11891-3-git-send-email-sourav.poddar@ti.com>
 <20120317054715.GB20049@core.coreip.homeip.net>
 <CAKdam54CudK-BoeAfOMrcHk51D9QsUbPhh5=Rqw5_ERCu2BpKA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5599608991218972426=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKdam54CudK-BoeAfOMrcHk51D9QsUbPhh5=Rqw5_ERCu2BpKA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============5599608991218972426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 19, 2012 at 01:27:50PM +0530, Poddar, Sourav wrote:
>=20
>=20
> On Sat, Mar 17, 2012 at 11:17 AM, Dmitry Torokhov <dmitry.torokhov@gmail.=
com>
> wrote:
>=20
>     Hi Sourav,
>=20
>     On Fri, Mar 16, 2012 at 07:56:29PM +0530, Sourav Poddar wrote:
>     > From: G, Manjunath Kondaiah <manjugk@ti.com>
>     >
>     > Keypad controller register offsets are different for omap4
>     > and omap5. Handle these offsets through static mapping and
>     > assign these mappings during run time.
>     >
>     > Signed-off-by: Felipe Balbi <balbi@ti.com>
>     > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>     > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>     > ---
>     >  drivers/input/keyboard/Kconfig        |    6 +-
>     >  drivers/input/keyboard/omap4-keypad.c |  122
>     ++++++++++++++++++++++++++------
>     >  2 files changed, 102 insertions(+), 26 deletions(-)
>     >
>     > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboar=
d/
>     Kconfig
>     > index 1379daa..09d7d0b 100644
>     > --- a/drivers/input/keyboard/Kconfig
>     > +++ b/drivers/input/keyboard/Kconfig
>     > @@ -510,10 +510,10 @@ config KEYBOARD_OMAP
>     >         To compile this driver as a module, choose M here: the
>     >         module will be called omap-keypad.
>     >
>     > -config KEYBOARD_OMAP4
>     > -     tristate "TI OMAP4 keypad support"
>     > +config KEYBOARD_OMAP4+
>     > +     tristate "TI OMAP4+ keypad support"
>     >       help
>     > -       Say Y here if you want to use the OMAP4 keypad.
>     > +       Say Y here if you want to use the OMAP4+ keypad.
>     >
>     >         To compile this driver as a module, choose M here: the
>     >         module will be called omap4-keypad.
>     > diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/
>     keyboard/omap4-keypad.c
>     > index e809ac0..6872495 100644
>     > --- a/drivers/input/keyboard/omap4-keypad.c
>     > +++ b/drivers/input/keyboard/omap4-keypad.c
>     > @@ -68,6 +68,11 @@
>     >
>     >  #define OMAP4_MASK_IRQSTATUSDISABLE  0xFFFF
>     >
>     > +enum {
>     > +     KBD_REVISION_OMAP4 =3D 0,
>     > +     KBD_REVISION_OMAP5,
>     > +};
>     > +
>     >  struct omap4_keypad {
>     >       struct input_dev *input;
>     >
>     > @@ -76,11 +81,79 @@ struct omap4_keypad {
>     >
>     >       unsigned int rows;
>     >       unsigned int cols;
>     > +     unsigned int revision;
>     >       unsigned int row_shift;
>     >       unsigned char key_state[8];
>     >       unsigned short keymap[];
>     >  };
>     >
>     > +static int kbd_read_irqstatus(struct omap4_keypad *keypad_data, u32
>     offset)
>     > +{
>     > +     if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>     > +             return __raw_readl(keypad_data->base + offset);
>     > +     else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>     > +             return __raw_readl(keypad_data->base + offset + 0x0c);
>     > +
>=20
>     This is called from ISR and doing comparisons seems quite wasteful. W=
hy
>     don't you stuff register numbers for IRQ manipulations into struct
>     omap4_keypad at probe time and your function would just do:
>=20
>            return __raw_readl(keypad_data->base + keypad_data->irqstatus_=
reg);
>=20
>=20
> Yes, can do that way . Will make necessary changes and post it again.
>=20
>     And do the same for irqstatus. FOr the rest of the register store the
>=20
>      I think you mean "irqenable" here.
>=20
>     common offset (seems to be 0x10).
>=20
>     > +     return -ENODEV;
>     > +}
>     > +
>     > +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
>     > +                                             u32 offset, u32 value)
>     > +{
>     > +     if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>     > +             return __raw_writel(value, keypad_data->base + offset=
);
>     > +     else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>     > +             return __raw_writel(value, keypad_data->base + offset=
 +
>     0x0c);
>     > +
>     > +     return -ENODEV;
>     > +}
>     > +
>     > +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
>     > +                                             u32 offset, u32 value)
>     > +{
>     > +     if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>     > +             return __raw_writel(value, keypad_data->base + offset=
);
>     > +     else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>     > +             return __raw_writel(value, keypad_data->base + offset=
 +
>     0x0c);
>     > +
>     > +     return -ENODEV;
>     > +}
>     > +
>     > +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
>     > +{
>     > +     if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>     > +             return __raw_readl(keypad_data->base + offset);
>     > +     else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>     > +             return __raw_readl(keypad_data->base + offset + 0x10);
>     > +
>     > +     return -ENODEV;
>     > +}
>     > +
>     > +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offse=
t, u32
>     value)
>     > +{
>     > +     if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>     > +             __raw_writel(value, keypad_data->base + offset);
>     > +     else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>     > +             __raw_writel(value, keypad_data->base + offset + 0x10=
);
>     > +}
>     > +
>     > +static int kbd_read_revision(struct omap4_keypad *keypad_data, u32
>     offset)
>     > +{
>     > +     int reg;
>     > +     reg =3D __raw_readl(keypad_data->base + offset);
>     > +     reg &=3D 0x03 << 30;
>     > +     reg >>=3D 30;
>     > +
>     > +     switch (reg) {
>     > +     case 1:
>     > +             return KBD_REVISION_OMAP5;
>     > +     case 0:
>     > +             return KBD_REVISION_OMAP4;
>     > +     default:
>     > +             return -ENODEV;
>     > +     }
>     > +}
>     > +
>     >  /* Interrupt handler */
>     >  static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>     >  {
>     > @@ -91,12 +164,11 @@ static irqreturn_t omap4_keypad_interrupt(int =
irq,
>     void *dev_id)
>     >       u32 *new_state =3D (u32 *) key_state;
>     >
>     >       /* Disable interrupts */
>     > -     __raw_writel(OMAP4_VAL_IRQDISABLE,
>     > -                  keypad_data->base + OMAP4_KBD_IRQENABLE);
>     > +     kbd_write_irqenable(keypad_data, OMAP4_KBD_IRQENABLE,
>     > +                                             OMAP4_VAL_IRQDISABLE);
>     >
>     > -     *new_state =3D __raw_readl(keypad_data->base +
>     OMAP4_KBD_FULLCODE31_0);
>     > -     *(new_state + 1) =3D __raw_readl(keypad_data->base
>     > -                                             + OMAP4_KBD_FULLCODE6=
3_32);
>     > +     *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31_0);
>     > +     *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCOD=
E63_32);
>     >
>     >       for (row =3D 0; row < keypad_data->rows; row++) {
>     >               changed =3D key_state[row] ^ keypad_data->key_state[r=
ow];
>     > @@ -121,12 +193,13 @@ static irqreturn_t omap4_keypad_interrupt(int=
 irq,
>     void *dev_id)
>     >               sizeof(keypad_data->key_state));
>     >
>     >       /* clear pending interrupts */
>     > -     __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTA=
TUS),
>     > -                     keypad_data->base + OMAP4_KBD_IRQSTATUS);
>     > +     kbd_write_irqstatus(keypad_data, OMAP4_KBD_IRQSTATUS,
>     > +                     kbd_read_irqstatus(keypad_data,
>     OMAP4_KBD_IRQSTATUS));
>     >
>     >       /* enable interrupts */
>     > -     __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN |
>     OMAP4_DEF_IRQENABLE_LONGKEY,
>     > -                     keypad_data->base + OMAP4_KBD_IRQENABLE);
>     > +     kbd_write_irqenable(keypad_data, OMAP4_KBD_IRQENABLE,
>     > +                     OMAP4_DEF_IRQENABLE_EVENTEN |
>     > +                             OMAP4_DEF_IRQENABLE_LONGKEY);
>     >
>     >       return IRQ_HANDLED;
>     >  }
>     > @@ -139,16 +212,19 @@ static int omap4_keypad_open(struct input_dev
>     *input)
>     >
>     >       disable_irq(keypad_data->irq);
>     >
>     > -     __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>     > -                     keypad_data->base + OMAP4_KBD_CTRL);
>     > -     __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>     > -                     keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
>     > -     __raw_writel(OMAP4_VAL_IRQDISABLE,
>     > -                     keypad_data->base + OMAP4_KBD_IRQSTATUS);
>     > -     __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN |
>     OMAP4_DEF_IRQENABLE_LONGKEY,
>     > -                     keypad_data->base + OMAP4_KBD_IRQENABLE);
>     > -     __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY=
_ENA,
>     > -                     keypad_data->base + OMAP4_KBD_WAKEUPENABLE);
>     > +     keypad_data->revision =3D kbd_read_revision(keypad_data,
>     > +                     OMAP4_KBD_REVISION);
>=20
>     You want to bail out of kbd_read_revision() returns error here.
>=20
>=20
> Yes, will include a error check.

Please send text/plain emails. You're currently sending multipart:

Content-Type: multipart/alternative;

--=20
balbi

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZu9iAAoJEIaOsuA1yqRE6qAP/jDBoVhCjiIgYObVuew/V56n
sWRj2twriHZI5vzkdEQoe/afvMp1UtTUva6Zx6ug0cYzf8EOXfsyVxj0UIfL0NUK
zz6PZgse/GhXn/5cI0+knFO0i2Amja1YZGcBRBdNkjPP8sDQb694bUdj00v0CRdS
S5Ww/NcZ2ozYVzcvYS6+ED8bWHH8WF1efGnXg4aWBu2BcJWsTpLo+vIXNBmDY3L4
NP1fC+RGXELxiNA9w0XEcaCgIU7ZCtcs0Fct/Zqj8UNvuVCHtqDV3VlwZhx6hEA2
YlUHoEOBeSCNO+k/5IJUomlAL2eKrBSwF60DrxwG4LNynWUgHYyD8IxMHZDxcJOb
r7JPNJrfHIn5IKXxtnw5uB3ziz1K1dHW4s+R4GT5g+G1s2n+kT/kVaRPmp32bLmy
uB0uWveWE/OH6BItCwDU83df0TXNqCOHR3fqw3cIvaOPUaINWJ/E+380yKqtryy8
mmVYWrtJud5Po6bieK1eh4xpaRwz7PIXl5+Oqs8aJg8pmfGoeUL9Xj16TxcGF03Y
y+fo86GdmNAL9d1qiVToOfsIxXlby2mA1gcP1uLDd0bu+E7EgIFVfn9IHRvXt480
tJvUoUOtqhSJjwv6YvC3KU64hy6PeeRybKuQVr5piIYKQ1AcPJ2iEk6gWM4XJCNX
qvlQIcpPaybCWAIPTrWt
=447f
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


--===============5599608991218972426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5599608991218972426==--
