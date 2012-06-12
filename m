From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 12 Jun 2012 11:15:10 +0100
Message-ID: <WC20120612101510.1001B1@terrafix.co.uk>
References: <1336483598.5761.45.camel@deskari> <WC20120514073642.6306D7@terrafix.co.uk> <1336982138.2532.32.camel@lappyti> <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com> <1337159300.7692.22.camel@deskari> <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com> <1337934288.2842.19.camel@deskari> <CAORVsuWrWXFR7cnBGD+R4omKRjCCvkhHhOVhR_tj=gjA0tUyVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:52607 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750905Ab2FLKPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 06:15:34 -0400
In-Reply-To: <CAORVsuWrWXFR7cnBGD+R4omKRjCCvkhHhOVhR_tj=gjA0tUyVA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Was there ever a conclussion to this discussion?

I'm assuming this is unlikely to be fixed in 3.5?

Cheers,
Joe

-----Original Message-----
=46rom: Jean Pihet <jean.pihet@newoldbits.com>
To: Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.c=
om>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0=
393947@ti.com>, linux-omap@vger.kernel.org
Date: Fri, 25 May 2012 14:55:27 +0200
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)

> Hi Tomi, Paul!
>=20
> On Fri, May 25, 2012 at 10:24 AM, Tomi Valkeinen
> <tomi.valkeinen@ti.com> wrote:
> > On Thu, 2012-05-24 at 18:39 -0600, Paul Walmsley wrote:
> >> cc Jean
> >>
> >> Hello Tomi,
> >>
> >> On Wed, 16 May 2012, Tomi Valkeinen wrote:
> >>
> >> > I also suspect that this could be just a plain DSS bug. The
> default FIFO
> >> > low/high thresholds are 960/1023 bytes (i.e. DSS starts refillin=
g
> the
> >> > FIFO when there are 960 or less bytes in the fifo, and stops at
> 1023.
> >> > The fifo is 1024 bytes). The values are calculated with fifo_siz=
e
> -
> >> > burst_size and fifo_size - 1.
> >> >
> >> > We are now using FIFO merge features, which combines multiple
> fifos into
> >> > one when possible, making the fifo size 1024*3 =3D 3072. Using t=
he
> same
> >> > low threshold and increasing the high threshold to 960/3071 work=
s
> fine.
> >> > Changing the high threshold to 3008 causes underflows. Increasin=
g
> the
> >> > low threshold to ~1600 makes DSS work again.
> >>
> >> Just a few thoughts.
> >>
> >> In terms of the high threshold, it seems really strange to me that
> >> changing the high threshold would make such a difference.
> =A0Na=EFvely, I'd
> >> assume that you'd want to set it as high as possible? =A0I suppose=
 in
> cases
> >> where the interconnect is congested, setting it lower might allow
> lower
> >> latency for other interconnect users, but I'd hope we don't have t=
o
> worry
> >> much about that. =A0So it doesn't seem to me that there would be a=
ny
> >> advantage to setting it lower than the maximum.
> >
> > It's true that the high threshold should be set as high as possible=
,
> and
> > this is what we do. Except for DSI command mode output on OMAP3,
> where,
> > for unknown reason, the highest value (fifosize - 1) doesn't work a=
nd
> we
> > need to program it to fifosize - burstsize. And this was causing th=
e
> > original problem, fifosize - burstsize was not working for other
> outputs
> > properly.
> >
> > I guess this also hints that there's something wrong with omap3 and
> the
> > dss fifo thresholds.
> >
> >> Probably the low threshold is the more important parameter, from a
> PM
> >> perspective. =A0If you know the FIFO's drain rate and the low
> threshold, it
> >> should be possible to calculate the maximum latency that the FIFO
> can
> >> tolerate to avoid an underflow. =A0This could be used to specify a
> device PM
> >> QoS constraint to prevent the interconnect latency from exceeding
> that
> >> value.
> >
> > Yes, this is how the low threshold should be adjusted. I have never
> > tried to calculate the threshold need, though, as I haven't had all
> the
> > information and understanding to properly calculate it.
> >
> >> I'd guess the calculations would be something like this -- (I hope
> you can
> >> correct my relative ignorance of the DSS in the following
> estimates):
> >>
> >> Looking at mach-omap2/board-rx51-video.c, let's suppose that the
> FIFO
> >> drain rate would be 864 x 480 x 32 bits/second. =A0Since the FIFO
> width is
> >> 32 bits, that's
> >
> > I think the DSS fifo entries are 8 bit on omap2/3, 128bits on omap4=
=2E
> At
> > least those are the "units" used with fifo size, threshold sizes,
> burst
> > size, etc.
> >
> >> =A0 =A0864 x 480 =3D 414 780 FIFO entries/second, or
> >>
> >> =A0 =A0(1 000 000 =B5s/s / 414 780 FIFO entries/s) =3D ~2.411 =B5s=
/FIFO
> entry.
> >>
> >> So if you need a low FIFO threshold at 960 entries, you could call
> the
> >> device PM QoS functions to set a wakeup latency constraint for the
> >> interconnect would be nothing greater than this:
> >>
> >> =A0 =A0(2.411 =B5s/FIFO entry * 960 FIFO entries) =3D 2 314.96 =B5=
s
> >>
> >> (The reality is that it would need to be something less than this,
> to
> >> account for the time needed for the GFX DMA transfer to start
> supplying
> >> data, etc.)
> >
> > Makes sense.
> >
> > Another reason for underflows we have is the different rotation
> engines.
> > VRFB on omap2/3, and TILER on omap4. Both increase the "work" neede=
d
> to
> > get pixels, although I'm not sure what the actual causes for the
> > increased work are.
> >
> >> The ultimate goal, with Jean's device PM QoS patches, is that thes=
e
> >> constraints could change the DPLL autoidle settings or powerdomain
> states
> >> to ensure the constraint was met. =A0He's got a page here:
> Indeed! The core code is ready and the OMAP power domains code is
> under review for the moment. The ultimate goal is to split the overal=
l
> latency of a device into the contributors (SW, HW SoC, HW external
> etc.), so the DPLL relock time would be taken into account. However
> without the submitted code in place there is no way to build the
> feature in incremental steps.
>=20
> >>
> >> =A0
> http://omappedia.org/wiki/Power_Management_Device_Latencies_Measureme=
nt
> In the wiki page there is a link to the ELC/Fosdem presentation [1]
> about the new model for the latency.
> [1]
> http://omappedia.org/wiki/File:ELC-2012-jpihet-DeviceLatencyModel.pdf
>=20
> >>
> >> (Unfortunately it's not clear what the DPLL autoidle modes and
> voltage
> >> scaling bits are set to for many of the estimates, and we also kno=
w
> that
> The code is from an l-o tree + the measurement code in, so the DPLL
> are allowed to auto-idle. In the new model the DPLL relock latency
> contribution should be split from the power domains latency.
>=20
> >> there are many software optimizations possible for our idle path.)
> Sure! Recently we have had the case with the C1 cpuidle state.
> Hopefully some simple experimental optimizations did fix the issue.
>=20
> Regards,
> Jean
>=20
> >>
> >> We're still working on getting the OMAP device PM QoS patches
> merged, but
> >> the Linux core support is there, so you should be able to patch yo=
ur
> >> drivers to use them -- see for example dev_pm_qos_add_request().
> >
> > Thanks for the pointers, I need to study that.
> >
> >> Just paging through the DSS TRM section, some other settings that
> might be
> >> worth checking are:
> >>
> >> - is DISPC_GFX_ATTRIBUTES.GFXBURSTSIZE set to 16x32?
> >
> > Yes. (8 x 128 on omap4)
> >
> > I presume each DMA burst has a small overhead, so maximizing the
> burst
> > size minimizes the overhead. Do you see any other effect with the
> burst
> > size? I mean, do you see any need to know the burst size value when
> > trying to calculate optimal thresholds?
> >
> >> - is DISPC_GFX_ATTRIBUTES.GFXFIFOPRELOAD set to 1?
> >
> > No. We set it to 0 so that PRELOAD is used. If I've understood righ=
t,
> > the problem with using GFXFIFOPRELOAD=3D1, i.e. high threshold is u=
sed
> for
> > preload value, is that the high threshold can be quite high, and th=
e
> > preload needs to happen during vertical blanking. With a small vbla=
nk
> > time and high high threshold there may not be enough time for the
> > preload.
> >
> > Then again, I have not verified that. And I'm not sure why it would
> be a
> > problem if the FIFO is not loaded up to the preload value during
> > blanking, presuming we still have enough pixels to proceed normally=
=2E
> >
> > For me it would make more sense to always load the fifo to full, so
> > there wouldn't be need for any PRELOAD value at all.
> >
> >> - is DISPC_GFX_PRELOAD.PRELOAD set to the maximum possible value?
> >
> > No, it's left at the default value. But I have tried adjusting this
> (and
> > also changing the GFXFIFOPRELOAD bit), and neither fixed the origin=
al
> > problem.
> >
> >> - is DISPC_CONFIG.FIFOFILLING set to 1?
> >
> > No, it's set to 0. With this problem there's only one overlay enabl=
ed
> so
> > it shouldn't have any effect.
> >
> > =A0Tomi
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
