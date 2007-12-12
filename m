From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP: Add support for TWL4030 USB Transceiver
	on OMAP34xx
Date: Wed, 12 Dec 2007 17:07:44 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804FE7428@dbde01.ent.ti.com>
References: <200712051146.34224.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200712051146.34224.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> > I think this twl4030_usb.c driver should move to new style=20
> I2C. I'm adding
> > David Brownell on the loop as he has moved isp1301 to new=20
> style i2c driver.
> >=20
> > Dave, do you have any comments, here ?
>=20
> Yes, make it a new-style I2C driver.  :)
> And pass the IRQ in from board-specific data.

The twl4030_usb.c is not really an I2C driver. It hooks into the
"drivers/i2c/chips/twl4030_core.c" driver which is the actual driver
for the twl4030.

We merely use this file to setup the USB functionality in the twl4030,
using the twl4030_i2c_{write,read}_u8 interfaces provided in the core =
file.

I'm not quite sure why this file needs to be made a proper new-style =
driver.


> I don't know the twl4030 but I suspect it should be plugging
> itself into an otg_transceiver structure instead of exporting
> global functions like this ...

musb_core.c already uses an otg_transceiver structure which we use in
omap2430.c. How do I introduce another otg_transciever here?

> Also:
>=20
> > =
+#define=A0=A0=A0=A0=A0=A0FUNC_CTRL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0(0x04)
>=20
> is bad style; drop the pointless parenthesis.  Another bit of bad
> style (well, maybe just not-good style) is that the register fields
> aren't associated with the register ... e.g. it looks like
>=20
> > =
+#define=A0=A0=A0=A0=A0=A0FUNC_CTRL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0(0x04)
> > =
+#define=A0=A0=A0=A0=A0=A0FUNC_CTRL_SET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(=
0x05)
> > =
+#define=A0=A0=A0=A0=A0=A0FUNC_CTRL_CLR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(=
0x06)
> > =
+#define=A0=A0=A0=A0=A0=A0SUSPENDM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0(1 << 6)
> > =
+#define=A0=A0=A0=A0=A0=A0RESET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0(1 << 5)
> > =
+#define=A0=A0=A0=A0=A0=A0OPMODE_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0(3 << 3) /* bits 3 and 4 */
> > =
+#define=A0=A0=A0=A0=A0=A0OPMODE_NORMAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(=
0 << 3)

<snip>

> most of these masks are valid for the "control" register, but I
> can't tell.  And if I were to look at a line of code masking those
> together with AUTORESUME, the bug (bitfield from wrong register)
> would be almost impossible to discover.  In those case a better
> convention is to use FN_CTRL_SUSPENDM and IF_CTRL_AUTORESUME,
> or something simmilar.

Ok. Fixed both points.


> (And a minor nit:  "#define<TAB>..." makes trouble reading diffs,
> as lines stretch and sometimes wrap; "#define<SPACE>" doesn't.
> Either is correct, but the former can be a bit annoying.)

Fixed this too.


> > +#define twl4030_i2c_write_u8_verify(module, data, address)=A0

<snip>

> Good example of something too big for a #define.  Make it a function.

Fixed.

Thanks for these comments. I will send the reworked patch separately.

Appreciate the time you've taken on this.

Regards,
Anand
