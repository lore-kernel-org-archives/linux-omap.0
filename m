From: Bin Liu <b-liu@ti.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 9 Jun 2016 16:09:48 -0500
Message-ID: <20160609210920.GD2167@uda0271908>
References: <201601091616.04193@pali>
 <3690314.8jDXSUDcRZ@saturn>
 <20160121192113.GM19432@atomide.com>
 <201601231357.32629@pali>
 <20160529103824.GM29844@pali>
 <20160607125044.GI29844@pali>
 <20160608095321.GH22406@atomide.com>
 <87h9d49exz.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h9d49exz.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, Felipe Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Jun 08, 2016 at 01:02:00PM +0300, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Tony Lindgren <tony@atomide.com> writes:
> > * Pali Roh=E1r <pali.rohar@gmail.com> [160607 05:53]:
> >> > Tony, what do you think about that patch?
> >> >=20
> >>=20
> >> Tony, PING
> >
> > Yeah I don't know, AFAIK we don't have a generic way to
> > force MUSB to change mode without ID pin. If you have figured
> > something generic for that which does not actually tinker with
> > the PHY registers directly, that should be the generic
> > musb_set_mode() that we've been wondering about for years.
>=20
> #define MUSB_TEST_FORCE_HOST	0x80
>=20
> Can someone confirm on MUSB's docs (and actual running system) that t=
his
> does what's supposed to do?

I don't know what to expect while setting this bit. I am never able to =
get musb
to enumerate anything or does anything which a host suppose to do.

Regards,
-Bin.
