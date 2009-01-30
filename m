From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Thu, 29 Jan 2009 16:57:49 -0800
Message-ID: <200901291657.50008.david-b@pacbell.net>
References: <200901211613.06427.david-b@pacbell.net> <BD79186B4FD85F4B8E60E381CAEE1909011A527A@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909011A527A@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 29 January 2009, hartleys wrote:
> > +/* Boards have uniqe mappings of {col, row} --> keycode.
> > + * Column and row are 4 bits, but range only from 0..7;
> > + * a PERSISTENT_KEY is "always on" and never reported.
> > + */
> > +#define KEY_PERSISTENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
0x00800000
> > +#define KEY(col, row, keycode)=A0=A0=A0=A0=A0=A0=A0(((col) << 28) =
| ((row) << 24) |
> (keycode))
>=20
> The same KEY macro is defined in:
>=20
> arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> arch/arm/plat-omap/include/mach/keypad.h

I copied it from the OMAP version as part of removing
needless OMAP dependencies from this driver.

=20
> I also have a keypad driver for the ep93xx that uses the same macro.
>=20
> Shouldn't/couldn't this be generalized and added to the
> include/linux/input.h file? =A0Allowing 4-bits for row/col gives a ma=
ximum
> key matrix of 16x16 keys which should be enough for just about anythi=
ng.

Makes sense.  But that's not what this patch is
about, and I also think the KEY prefix is probably
too generic.

I'd support an overall cleanup patch that fixes
all those things at once.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
