From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: [PATCH 3/5] staging: tidspbridge: Lindent to drv_interface.c
Date: Mon, 30 Jan 2012 21:33:12 +0100
Message-ID: <20120130203312.GA3296@lit.local.igalia.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
 <7103a353d393f9b8366b141a608a4370e4392c7b.1327348286.git.vjaquez@igalia.com>
 <CAB-zwWjKfakESHw4Cw8JvJ6WpELz51E_9zVtjR0bF84yhMRfMQ@mail.gmail.com>
 <20120130192907.GX3294@mwanda>
 <1327953180.25132.39.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327953180.25132.39.camel@joe2Laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@suse.de>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2012 at 11:53:00AM -0800, Joe Perches wrote:
> On Mon, 2012-01-30 at 22:29 +0300, Dan Carpenter wrote:
> > On Mon, Jan 30, 2012 at 11:25:34AM -0600, Ramirez Luna, Omar wrote:
> > > > +                       pr_info("%s:%d handle(s) still opened\n=
", __func__,
> > > > +                               atomic_read(&bridge_cref));
> > > I remember the rule was to break lines as far to the right as
> > > possible, no? Chapter 2 CodingStyle, same for the other similar
> > > changes.
> > It doesn't mean you have to right justify things, it just means
> > indented.  The original code is fine here and the new code is fine
> > here.  It's up to whoever writes the code to decide.
>=20
> I concur.
>=20
> My personal preference is to use a new line after the format
> string if necessary.
>=20
> ie:
> 	pr_<level>("fmt\n"[, args to 80 columns if all fit])
> or
> 	pr_<level>("fmt\n",
> 		   args when single line exceeds 80 columns);
>=20
> So for this case:
> 			pr_info("%s:%d handle(s) still opened\n",
> 				__func__, atomic_read(&bridge_cref));
>=20
> I've done a patch here to tidspbridge that standardizes
> printk output.
>=20
> Basically, the patch adds
> #define pr_fmt(fmt) KBUILD_MODNAME "%s: ", __func__
> to prefix "tidspbridge:%s:", removes the leading
> "%s:...",  __func__ from the uses, coalesces
> formats and does argument alignment.
>=20
> It cleans up the DBC_ASSERT, DBC_REQUIRE and DBC_ENSURE
> macros too.

hehehe... I also have one for this... But I prefer yours: I'm a newbie =
:)

vmjl

>=20
> I'm waiting for the Makefile change and whatever
> patches V=EDctor produces to be applied.  I'll then
> redo my patch and submit it.
>=20
>=20
>=20
