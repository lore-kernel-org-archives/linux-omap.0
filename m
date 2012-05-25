From: Paul Walmsley <paul@pwsan.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Thu, 24 May 2012 18:39:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com>
References: <1336033721.14378.2.camel@deskari>   <WC20120503084938.900446@terrafix.co.uk>   <1336050442.14378.10.camel@deskari>   <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>   <1336140072.2552.6.camel@deskari>
 <WC20120504140943.7604D0@terrafix.co.uk>   <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>   <1336483598.5761.45.camel@deskari>  <WC20120514073642.6306D7@terrafix.co.uk> <1336982138.2532.32.camel@lappyti>
 <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com> <1337159300.7692.22.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-169897561-1337903222=:25520"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60884 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab2EYAjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 20:39:04 -0400
In-Reply-To: <1337159300.7692.22.camel@deskari>
Content-ID: <alpine.DEB.2.00.1205241747150.25520@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, jean.pihet@newoldbits.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-169897561-1337903222=:25520
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1205241747151.25520@utopia.booyaka.com>

cc Jean

Hello Tomi,

On Wed, 16 May 2012, Tomi Valkeinen wrote:

> I also suspect that this could be just a plain DSS bug. The default FIFO
> low/high thresholds are 960/1023 bytes (i.e. DSS starts refilling the
> FIFO when there are 960 or less bytes in the fifo, and stops at 1023.
> The fifo is 1024 bytes). The values are calculated with fifo_size -
> burst_size and fifo_size - 1.
>=20
> We are now using FIFO merge features, which combines multiple fifos into
> one when possible, making the fifo size 1024*3 =3D 3072. Using the same
> low threshold and increasing the high threshold to 960/3071 works fine.
> Changing the high threshold to 3008 causes underflows. Increasing the
> low threshold to ~1600 makes DSS work again.

Just a few thoughts.

In terms of the high threshold, it seems really strange to me that=20
changing the high threshold would make such a difference.  Na=EFvely, I'd=
=20
assume that you'd want to set it as high as possible?  I suppose in cases=
=20
where the interconnect is congested, setting it lower might allow lower=20
latency for other interconnect users, but I'd hope we don't have to worry=
=20
much about that.  So it doesn't seem to me that there would be any=20
advantage to setting it lower than the maximum.

Probably the low threshold is the more important parameter, from a PM=20
perspective.  If you know the FIFO's drain rate and the low threshold, it=
=20
should be possible to calculate the maximum latency that the FIFO can=20
tolerate to avoid an underflow.  This could be used to specify a device PM=
=20
QoS constraint to prevent the interconnect latency from exceeding that=20
value.
 =20
I'd guess the calculations would be something like this -- (I hope you can=
=20
correct my relative ignorance of the DSS in the following estimates):

Looking at mach-omap2/board-rx51-video.c, let's suppose that the FIFO=20
drain rate would be 864 x 480 x 32 bits/second.  Since the FIFO width is=20
32 bits, that's

   864 x 480 =3D 414 780 FIFO entries/second, or

   (1 000 000 =B5s/s / 414 780 FIFO entries/s) =3D ~2.411 =B5s/FIFO entry.

So if you need a low FIFO threshold at 960 entries, you could call the=20
device PM QoS functions to set a wakeup latency constraint for the=20
interconnect would be nothing greater than this:

   (2.411 =B5s/FIFO entry * 960 FIFO entries) =3D 2 314.96 =B5s

(The reality is that it would need to be something less than this, to=20
account for the time needed for the GFX DMA transfer to start supplying=20
data, etc.)

The ultimate goal, with Jean's device PM QoS patches, is that these=20
constraints could change the DPLL autoidle settings or powerdomain states=
=20
to ensure the constraint was met.  He's got a page here:

  http://omappedia.org/wiki/Power_Management_Device_Latencies_Measurement

(Unfortunately it's not clear what the DPLL autoidle modes and voltage=20
scaling bits are set to for many of the estimates, and we also know that=20
there are many software optimizations possible for our idle path.)

We're still working on getting the OMAP device PM QoS patches merged, but=
=20
the Linux core support is there, so you should be able to patch your=20
drivers to use them -- see for example dev_pm_qos_add_request().

=2E..

Similarly, for the low-power refresh case, if you know the GFX FIFO drain=
=20
rate and the various latencies, it should be possible to estimate the=20
minimum low threshold value needed in order to avoid a FIFO underflow.

(By "various latencies," I mean the DPLL relock latency, the GFX DMA=20
latency between initiating a transfer and receiving the first result data,=
=20
etc.  Some of these latencies may be difficult to estimate accurately. =20
But if the major sources of variation can be identified, such as DPLL=20
relock time or GFX DMA FIFO refill time, I'd hope we can just use trial=20
and error to find some worst-case constant for the rest.)

The goal in this ase would be to allow DPLL3 to stay unlocked for as long=
=20
as possible, to save energy.  This would imply finding the lowest possible=
=20
FIFO low threshold that doesn't generate underflows.  Using the lowest=20
possible low threshold should leave as much room as possible in the FIFO=20
for data, and thus maximize the amount of time that DPLL3 can stay=20
unlocked after the high threshold is reached.

Since the DPLL relock latency figures are known from the TRM section=20
4.7.6.7 "Latencies," we can estimate the DPLL's contribution to the low=20
threshold setting.  The DPLL relock latency depends on the DPLL's input=20
rate and some DPLL settings, so it can vary.  (We probably need a=20
function for the interconnect device that can estimate the worst-case=20
wakeup latency for the DSS to use, based on the rest of the system=20
settings.)

Let's reuse the 2.411 =B5s/FIFO entry estimate from above.  For convenience=
,=20
let's suppose that the DPLL relock latency from DPLL-OFF is 1.5 ms =3D 1500=
=20
=B5s.  So we know that the number of FIFO slots needed simply to endure the=
=20
DPLL relock process is

   CEIL(1500 =B5s/relock / 2.411 =B5s/FIFO entry) =3D CEIL(622.14 ...) =3D=
=20
       623 FIFO entries/relock

This of course doesn't account for the time needed for the GFX DMA=20
transfer to start delivering useful data, any voltage scaling needed, etc.

=2E..

Just paging through the DSS TRM section, some other settings that might be=
=20
worth checking are:

- is DISPC_GFX_ATTRIBUTES.GFXBURSTSIZE set to 16x32?

- is DISPC_GFX_ATTRIBUTES.GFXFIFOPRELOAD set to 1?

- is DISPC_GFX_PRELOAD.PRELOAD set to the maximum possible value?

- is DISPC_CONFIG.FIFOFILLING set to 1?

> So I think that the high thresholds of 3071 and 3008 are so close to
> each other that there shouldn't be any real difference in practice,
> presuming everything works. But, for whatever reason, fetching of the
> pixels becomes much more inefficient or with much higher start latency,
> causing the underflows.

That's really weird.


- Paul
--155748971-169897561-1337903222=:25520--
