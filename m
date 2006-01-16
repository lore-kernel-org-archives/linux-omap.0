From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] keypad platform_data and 24xx support refresh
Date: Mon, 16 Jan 2006 09:24:06 -0800 (PST)
Message-ID: <20060116172406.3860.qmail@web32905.mail.mud.yahoo.com>
References: <1137342313.7691.11.camel@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1137342313.7691.11.camel@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:

> Looks good, except:
>=20
> > +#ifdef CONFIG_MACH_OMAP_H4
> > +#define NUM_ROWS 6
> > +#define NUM_COLS 7
>=20
> > +static unsigned int row_gpio_num[NUM_ROWS] =3D { 88, 89, 124, 11, 6,
> 96 };
> > +static unsigned int col_gpio_num[NUM_COLS] =3D { 90, 91, 100, 36,
> 12, 97, 98 };
>=20
> Why not use the platform_data for this information, too?  It's kind
> of
> bad to assume this for all the 2420 boards.

Yes, it is in my TODO.

http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/0058=
89.html


>=20
> >  static int test_keymap[] =3D {
> >         KEY(0, 0, KEY_F4),
> >         KEY(1, 0, KEY_LEFT),
>=20
> This can go away, too.  We'll put it into board-nokia770.c.

Ok.

>=20
> > +#ifdef CONFIG_MACH_OMAP_H4
> > +static void set_col_gpio_val(u8 value)
>=20
> Not H4 but OMAP2.

Why? If 2430 falls into OMAP2 class then it's EVM design for keyboard
is using TWL4030 i2c interface to read the values. Richard can clarify
on this.

>=20
> > +       if (machine_is_omap_h4()) {
>=20
> Ditto.

Let's see, depends upon 2430 design, otherwise h4 looks good to me.

>=20
> There's also a fairly important patch we haven't published yet.  The
> patch provides a work-around to the "ghost key" problem that happens
> when necessary precautions have not been made in the keypad HW
> design.
> If there are three (or more) keys pressed at the same time, and they
> form a triangle on the keypad matrix, the HW thinks there are some
> extra
> keys pressed.
>=20
> Unfortunately I don't have time now to come up with a proper patch,
> but
> I've put our version of the driver here:
> http://jemmari.tky.hut.fi/~jey/omap-keypad.c

Ok, I will try to merge it when I release the new patch. (May be this wee=
kend).

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
