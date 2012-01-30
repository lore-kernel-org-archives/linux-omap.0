From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/5] staging: tidspbridge: Lindent to drv_interface.c
Date: Mon, 30 Jan 2012 12:40:28 -0800
Message-ID: <1327956028.25132.53.camel@joe2Laptop>
References: <cover.1327348286.git.vjaquez@igalia.com>
	 <7103a353d393f9b8366b141a608a4370e4392c7b.1327348286.git.vjaquez@igalia.com>
	 <CAB-zwWjKfakESHw4Cw8JvJ6WpELz51E_9zVtjR0bF84yhMRfMQ@mail.gmail.com>
	 <20120130192907.GX3294@mwanda> <1327953180.25132.39.camel@joe2Laptop>
	 <20120130203312.GA3296@lit.local.igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120130203312.GA3296@lit.local.igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "=?ISO-8859-1?Q?V=EDctor?= M. =?ISO-8859-1?Q?J=E1quez?= L." <vjaquez@igalia.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@suse.de>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2012-01-30 at 21:33 +0100, V=C3=ADctor M. J=C3=A1quez L. wrote:
> On Mon, Jan 30, 2012 at 11:53:00AM -0800, Joe Perches wrote:
> > I've done a patch here to tidspbridge that standardizes
> > printk output.
> >=20
> > Basically, the patch adds
> > #define pr_fmt(fmt) KBUILD_MODNAME "%s: ", __func__
> > to prefix "tidspbridge:%s:", removes the leading
> > "%s:...",  __func__ from the uses, coalesces
> > formats and does argument alignment.
> >=20
> > It cleans up the DBC_ASSERT, DBC_REQUIRE and DBC_ENSURE
> > macros too.
>=20
> hehehe... I also have one for this... But I prefer yours: I'm a newbi=
e :)

Well, given that you haven't done many of these, I prefer yours.
