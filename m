From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 21:32:37 +0200
Message-ID: <20130219193237.GA8978@arwen.pp.htv.fi>
References: <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com>
 <87ppzww1ux.fsf@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53146 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933341Ab3BSTco (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Feb 2013 14:32:44 -0500
Content-Disposition: inline
In-Reply-To: <87ppzww1ux.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 11:16:38AM -0800, Kevin Hilman wrote:

[ ... ]

> The other problem is the where reset is need during runtime.  Again,
> what are the specific examples here?  The one I can think of off the top
> of my head is I2C, where it's needed in certain error recovery
> scenarios.

right, I still have a theory that it's not needed in that case either,
though I haven't had time to try that out.

> Here, we need a way for the driver itself to initiate a full reset.
> Maybe a new runtime PM hook like ->runtime_reset() as Felipe has
> suggested (though I'm not yet sure runtime PM is the right place for
> this, since it's not strictly related to runtime PM).  Or, if these are

right, I agree with you but I couldn't think of a better place. Maybe we
need a reset hook in struct device itself (as I suggested on another
mail) but I'm not sure Greg would take it, unless we have a damn good
reason.

> mostly corner-case, error recovery scenarios, maybe a a way force the
> driver to remove itself and re-probe (which would trigger the
> bus-notifier based reset) as Tony has suggested is the better approach.

I don't think so. We certainly don't need to go through all memory
allocations again. That will just cause unnecessary memory
fragmentation.

> The OMAP I2C driver is doing a reset and fully re-initializing itself,
> so it seems the forced remove/probe is the right approach there.  Any

I must disagree here. Doing a reprobe of I2C every time there's an error
condition is overkill. It means freeing struct omap_i2c_dev, freeing its
IRQ, freeing the ioremapped area, changing mux configuration (due to
pinctrl calls) just to do it all over again. Besides omap_i2c_probe()
calls omap_i2c_init() which will do the full IP reset anyway.

The difference is that calling omap_i2c_init() directly doesn't force us
to free and reallocate all resources all over again.

> one have the other use cases handy?

dwc3 gets reset during probe() too, but that has an IP specific reset
which doesn't need SYSCONFIG register for that.

--=20
balbi

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI9NVAAoJEIaOsuA1yqREzXYQALORNc6FSEViXdGtAUD8HZnx
SB46/JOvAIumn75M2CliZOneuugKvWXWOUQFD/Gmydx4dn5nPIgH1IChukXt/mn0
U1zB5FEngOtUyppFdapEiQdbmRaBrU3Lpc0LCgI36WlD+wIu+gRmBX6LXCE5WAJt
Teeheq1QqdCj6ZS4gshKu0AdV28k23h00JImLnlq2Yd/XUfVOP5vhd2C8KVBeqJ5
cxE0Ve6n888v+h693Gi4dmkhI3UtAQF73KvtKTheKqqwopfsKIsnhfbfYATL/E+K
cBTctUqBc6lzpKvpNaxcngyydi4u1qvZpsJH7pMWMlyO7uDBBL8pdUJzjLzWlVxt
1esDyk/ojIjSCPOQFXacKEXFXYU2TJonhtQ3pPizBjBSkjZPXLaSWw3ohNjAv8uf
ms5mkzuMVE0amBd9W/hLGaoc/tIN18Z5iopMNJHKmS3qP9Db+SkaDRz7Y+nBwGT0
ZIKwQN8QtPIB9kG+130FiwvMMax1SXsHUvxFzQfATxO5ibNFVbH0//hGRKfKEw6x
aEnXhEWD+bDW/VPYv1fhrN/97iK4ykiWx2SAVO8gycDAONu8zXo1yf7PszgvFzs1
9iW3f14+V5QYyY7vZuKafHvW0608wwRk6AYOuS9VF23vXvPY9+caI2LLmDA2oweL
3BGuTn12uJBnvrdB0bdf
=rctM
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
