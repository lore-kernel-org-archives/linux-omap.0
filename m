From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/11] ARM: omap: move omapfb_reserve_sdram() to
	.init.text
Date: Sat, 24 Jul 2010 10:51:12 +0200
Message-ID: <20100724085112.GA694@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de> <1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de> <20100723211535.GD750@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100723211535.GD750@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 23, 2010 at 10:15:35PM +0100, Russell King - ARM Linux wrot=
e:
> On Fri, Jul 23, 2010 at 09:58:29PM +0200, Uwe Kleine-K=F6nig wrote:
> > omapfb_reserve_sdram() is only called by omap1_map_common_io() and
> > _omap2_map_common_io() that both live in .init.text.  So this is sa=
ve
> > for omapfb_reserve_sdram(), too.
>=20
> NAK.  This clashes with the memblock stuff.
OK, I will recheck after .36-rc1.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
