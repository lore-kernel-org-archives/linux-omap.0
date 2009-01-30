From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Fri, 30 Jan 2009 12:13:48 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A53D4@mi8nycmail19.Mi8.com>
References: <200901211613.06427.david-b@pacbell.net> <BD79186B4FD85F4B8E60E381CAEE1909011A527A@mi8nycmail19.Mi8.com> <200901291657.50008.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <200901291657.50008.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday, January 29, 2009 5:58 PM, David Brownell wrote:
> On Thursday 29 January 2009, hartleys wrote:
> > > +/* Boards have uniqe mappings of {col, row} --> keycode.
> > > + * Column and row are 4 bits, but range only from 0..7;
> > > + * a PERSISTENT_KEY is "always on" and never reported.
> > > + */
> > > +#define KEY_PERSISTENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A00x00800000 #define KEY(col,=20
> > > +row, keycode)=A0=A0=A0=A0=A0=A0=A0(((col) << 28) | ((row) << 24)=
 |
> > (keycode))
> >=20
> > The same KEY macro is defined in:
> >=20
> > arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> > arch/arm/plat-omap/include/mach/keypad.h
>=20
> I copied it from the OMAP version as part of removing needless OMAP
> dependencies from this driver.

Makes sense.
=20
> > I also have a keypad driver for the ep93xx that uses the same macro=
=2E
> >=20
> > Shouldn't/couldn't this be generalized and added to the=20
> > include/linux/input.h file? =A0Allowing 4-bits for row/col gives a=20
> > maximum key matrix of 16x16 keys which should be enough for just
> > about anything.
>=20
> Makes sense.  But that's not what this patch is about, and I also
> think the KEY prefix is probably too generic.
=20
Understand.  Just noticed the common macro and wondered if something sh=
ould be done to generalize it.

> I'd support an overall cleanup patch that fixes all those things at o=
nce.

How's this for a starting point?  I'm willing to create a cleanup patch=
 for all the mach-omap1, mach-omap2, and mach-pxa users. =20

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/include/linux/input.h b/include/linux/input.h
index 1249a0c..0879493 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -598,6 +598,14 @@ struct input_absinfo {
 #define KEY_CNT			(KEY_MAX+1)
=20
 /*
+ * Macro to pack the row/col of a key on a matrix keypad and it's asso=
ciated
+ * KEY_* code into into an array.  4 bits are used for both the row an=
d column
+ * allowing for up to a 16x16 keypad.  The row (_r) and column (_c) ar=
e
+ * interchangable depending on a keypad drivers usage.
+ */
+#define MATRIX_KEY(_r, _c, _v)	(((_r) << 28) | ((_c) << 24) | (_v))
+
+/*
  * Relative axes
  */
 =20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
