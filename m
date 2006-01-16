From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] keypad platform_data and 24xx support refresh
Date: Mon, 16 Jan 2006 11:29:54 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A503E44125@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, =?iso-8859-1?Q?Juha_=22Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > > +#ifdef CONFIG_MACH_OMAP_H4
> > > +static void set_col_gpio_val(u8 value)
> >
> > Not H4 but OMAP2.
>=20
> Why? If 2430 falls into OMAP2 class then it's EVM design for keyboard
> is using TWL4030 i2c interface to read the values. Richard can clarify
> on this.

That is correct the GPIO key implementation is not used on the =
OMAP2-2430SDP.  It uses the keypad decoder found in the companion chip.

Regards,
Richard W.
