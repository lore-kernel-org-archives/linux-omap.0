From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Fri, 25 May 2012 11:24:48 +0300
Message-ID: <1337934288.2842.19.camel@deskari>
References: <1336033721.14378.2.camel@deskari>
	   <WC20120503084938.900446@terrafix.co.uk>
	   <1336050442.14378.10.camel@deskari>
	   <WC20120504091902.970499@terrafix.co.uk>
	 <1336139415.2552.4.camel@deskari>   <1336140072.2552.6.camel@deskari>
	 <WC20120504140943.7604D0@terrafix.co.uk>
	   <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	   <1336483598.5761.45.camel@deskari>
	  <WC20120514073642.6306D7@terrafix.co.uk>
	 <1336982138.2532.32.camel@lappyti>
	  <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
	 <1337159300.7692.22.camel@deskari>
	 <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-w9x7ZRJ7uDAifF8JEtVy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:53569 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751698Ab2EYIY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 04:24:59 -0400
Received: by lbbgm6 with SMTP id gm6so466225lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 25 May 2012 01:24:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, jean.pihet@newoldbits.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-w9x7ZRJ7uDAifF8JEtVy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-24 at 18:39 -0600, Paul Walmsley wrote:
> cc Jean
>=20
> Hello Tomi,
>=20
> On Wed, 16 May 2012, Tomi Valkeinen wrote:
>=20
> > I also suspect that this could be just a plain DSS bug. The default FIF=
O
> > low/high thresholds are 960/1023 bytes (i.e. DSS starts refilling the
> > FIFO when there are 960 or less bytes in the fifo, and stops at 1023.
> > The fifo is 1024 bytes). The values are calculated with fifo_size -
> > burst_size and fifo_size - 1.
> >=20
> > We are now using FIFO merge features, which combines multiple fifos int=
o
> > one when possible, making the fifo size 1024*3 =3D 3072. Using the same
> > low threshold and increasing the high threshold to 960/3071 works fine.
> > Changing the high threshold to 3008 causes underflows. Increasing the
> > low threshold to ~1600 makes DSS work again.
>=20
> Just a few thoughts.
>=20
> In terms of the high threshold, it seems really strange to me that=20
> changing the high threshold would make such a difference.  Na=C3=AFvely, =
I'd=20
> assume that you'd want to set it as high as possible?  I suppose in cases=
=20
> where the interconnect is congested, setting it lower might allow lower=
=20
> latency for other interconnect users, but I'd hope we don't have to worry=
=20
> much about that.  So it doesn't seem to me that there would be any=20
> advantage to setting it lower than the maximum.

It's true that the high threshold should be set as high as possible, and
this is what we do. Except for DSI command mode output on OMAP3, where,
for unknown reason, the highest value (fifosize - 1) doesn't work and we
need to program it to fifosize - burstsize. And this was causing the
original problem, fifosize - burstsize was not working for other outputs
properly.

I guess this also hints that there's something wrong with omap3 and the
dss fifo thresholds.

> Probably the low threshold is the more important parameter, from a PM=20
> perspective.  If you know the FIFO's drain rate and the low threshold, it=
=20
> should be possible to calculate the maximum latency that the FIFO can=20
> tolerate to avoid an underflow.  This could be used to specify a device P=
M=20
> QoS constraint to prevent the interconnect latency from exceeding that=
=20
> value.

Yes, this is how the low threshold should be adjusted. I have never
tried to calculate the threshold need, though, as I haven't had all the
information and understanding to properly calculate it.

> I'd guess the calculations would be something like this -- (I hope you ca=
n=20
> correct my relative ignorance of the DSS in the following estimates):
>=20
> Looking at mach-omap2/board-rx51-video.c, let's suppose that the FIFO=20
> drain rate would be 864 x 480 x 32 bits/second.  Since the FIFO width is=
=20
> 32 bits, that's

I think the DSS fifo entries are 8 bit on omap2/3, 128bits on omap4. At
least those are the "units" used with fifo size, threshold sizes, burst
size, etc.

>    864 x 480 =3D 414 780 FIFO entries/second, or
>=20
>    (1 000 000 =C2=B5s/s / 414 780 FIFO entries/s) =3D ~2.411 =C2=B5s/FIFO=
 entry.
>=20
> So if you need a low FIFO threshold at 960 entries, you could call the=
=20
> device PM QoS functions to set a wakeup latency constraint for the=20
> interconnect would be nothing greater than this:
>=20
>    (2.411 =C2=B5s/FIFO entry * 960 FIFO entries) =3D 2 314.96 =C2=B5s
>=20
> (The reality is that it would need to be something less than this, to=20
> account for the time needed for the GFX DMA transfer to start supplying=
=20
> data, etc.)

Makes sense.

Another reason for underflows we have is the different rotation engines.
VRFB on omap2/3, and TILER on omap4. Both increase the "work" needed to
get pixels, although I'm not sure what the actual causes for the
increased work are.

> The ultimate goal, with Jean's device PM QoS patches, is that these=20
> constraints could change the DPLL autoidle settings or powerdomain states=
=20
> to ensure the constraint was met.  He's got a page here:
>=20
>   http://omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
>=20
> (Unfortunately it's not clear what the DPLL autoidle modes and voltage=
=20
> scaling bits are set to for many of the estimates, and we also know that=
=20
> there are many software optimizations possible for our idle path.)
>=20
> We're still working on getting the OMAP device PM QoS patches merged, but=
=20
> the Linux core support is there, so you should be able to patch your=20
> drivers to use them -- see for example dev_pm_qos_add_request().

Thanks for the pointers, I need to study that.

> Just paging through the DSS TRM section, some other settings that might b=
e=20
> worth checking are:
>=20
> - is DISPC_GFX_ATTRIBUTES.GFXBURSTSIZE set to 16x32?

Yes. (8 x 128 on omap4)

I presume each DMA burst has a small overhead, so maximizing the burst
size minimizes the overhead. Do you see any other effect with the burst
size? I mean, do you see any need to know the burst size value when
trying to calculate optimal thresholds?

> - is DISPC_GFX_ATTRIBUTES.GFXFIFOPRELOAD set to 1?

No. We set it to 0 so that PRELOAD is used. If I've understood right,
the problem with using GFXFIFOPRELOAD=3D1, i.e. high threshold is used for
preload value, is that the high threshold can be quite high, and the
preload needs to happen during vertical blanking. With a small vblank
time and high high threshold there may not be enough time for the
preload.

Then again, I have not verified that. And I'm not sure why it would be a
problem if the FIFO is not loaded up to the preload value during
blanking, presuming we still have enough pixels to proceed normally.

For me it would make more sense to always load the fifo to full, so
there wouldn't be need for any PRELOAD value at all.

> - is DISPC_GFX_PRELOAD.PRELOAD set to the maximum possible value?

No, it's left at the default value. But I have tried adjusting this (and
also changing the GFXFIFOPRELOAD bit), and neither fixed the original
problem.

> - is DISPC_CONFIG.FIFOFILLING set to 1?

No, it's set to 0. With this problem there's only one overlay enabled so
it shouldn't have any effect.

 Tomi


--=-w9x7ZRJ7uDAifF8JEtVy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPv0HQAAoJEPo9qoy8lh71kR8P/09NBBRR8LVxBbkSAE0Sd308
rxbECk64ZgSTpJ957XRgu8/gTQfhR3lEjfj4cjZbJX3/iwpPdd5P/iQwO6RO9zr/
th7gN84xExW9bOo/5juTVO+qnBYPtzF1FQa99v6bVko+ydcncPxDX5sYM03Y00w9
QJagPPfc4HAPXh3Jf9YegySG3Z72XyEle+JhLOKrW2R6rTW/AeWCPVYxVO3lLk7w
5GBCMoe1bjvdBcnPQQIIH5kPXHY+AGeCcRI2u/AEFs1bkt+08XwbSvrfrBtSYh0H
DjOYOFcNHoVMBE9ca+YwyOoAYEw0oJWq7H9Ycifx0J8BQ9oVJX1jTeyQkwvoizyy
OSPGrgeVOHusFAqc/qiGMFUMusJpRcMEkzXkemHYnZTAvjH3mg0Pfrn+LFin56Ox
YOH9tkEcq+q5rcfZVhf/wJhFl6DvM4A5BJk7G9N7cEXqkCgv40+dsTI9Ip1PO3p2
cxjuTseai6snyWEvnl1JvMBK7XR3Q02leoWJksXBNL2S8B8XMrQVnGLqD+/wnA0z
La5IBPH+bnRwupj/KLnVV4IFIYYURrk0rABnifACdoe14Xr6MDhTxe3Aj7XRg67P
YSxs0JMBknMixilnG4BrDNoJTeUiqPydrvepZVaSl8jjZHAj08oNeRISdVvFjGtZ
czWyFR6Aqfjy7AhczYf5
=dcQL
-----END PGP SIGNATURE-----

--=-w9x7ZRJ7uDAifF8JEtVy--

