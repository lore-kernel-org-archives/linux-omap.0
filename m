From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 06:07:03 -0500
Message-ID: <CAHCN7xK100mR=fNns3qdDKpOyWsTWXgDnnngQfQ_j8cB_SFfuA@mail.gmail.com>
References: <20190912183037.18449-1-aford173@gmail.com> <D4F7E03C-1880-45AC-8F7C-6C8A336E2A01@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D4F7E03C-1880-45AC-8F7C-6C8A336E2A01@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 13, 2019 at 1:56 AM H. Nikolaus Schaller <hns@goldelico.com> wr=
ote:
>
> Hi Adam,
>
> > Am 12.09.2019 um 20:30 schrieb Adam Ford <aford173@gmail.com>:
> >
> > The thermal sensor in the omap3 family isn't accurate, but it's
> > better than nothing.  The various OPP's enabled for the omap3630
> > support up to OPP1G, however the datasheet for the DM3730 states
> > that OPP130 and OPP1G are not available above TJ of 90C.
>
> We may have to add similar things for omap34xx as well. See
> data sheet 3.3 Recommended Operating Conditions
>
> But when reading them they do not limit temperature but
> number of operation hours of each OPP depending on temperature...
> That is clearly beyond what a kernel can do (we would have to
> have access to some NVRAM in the kernel counting hours).
>
> >
> > This patch configures the thermal throttling to limit the
> > operating points of the omap3630 to Only OPP50 and OPP100 if
>
> s/Only/only/

I will fix when I do V2
>
> > the thermal sensor reads a value above 90C.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36=
xx.dtsi
> > index 4bb4f534afe2..58b9d347019f 100644
> > --- a/arch/arm/boot/dts/omap36xx.dtsi
> > +++ b/arch/arm/boot/dts/omap36xx.dtsi
> > @@ -25,6 +25,7 @@
> >
> >                       vbb-supply =3D <&abb_mpu_iva>;
> >                       clock-latency =3D <300000>; /* From omap-cpufreq =
driver */
> > +                     #cooling-cells =3D <2>;
> >               };
> >       };
> >
> > @@ -195,6 +196,31 @@
> >       };
> > };
> >
> > +&cpu_thermal {
> > +     cpu_trips: trips {
>
> Yes, that is comparable to what I have seen in omap5 DT where I know
> that thermal throttling works.
>
> > +             /* OPP130 and OPP1G are not available above TJ of 90C. */
> > +             cpu_alert0: cpu_alert {
> > +                     temperature =3D <90000>; /* millicelsius */
> > +                     hysteresis =3D <2000>; /* millicelsius */
> > +                     type =3D "passive";
> > +             };
> > +
> > +             cpu_crit: cpu_crit {
> > +                     temperature =3D <125000>; /* millicelsius */
>
> Shouldn't this be 105=C2=B0C for all omap3 chips (industrial temperature =
range)?

You are correct.  I forgot to change this when I did my copy-paste.
>
> > +                     hysteresis =3D <2000>; /* millicelsius */
> > +                     type =3D "critical";
> > +             };
> > +     };
> > +
> > +     cpu_cooling_maps: cooling-maps {
> > +             map0 {
> > +                     trip =3D <&cpu_alert0>;
> > +                     /* Only allow OPP50 and OPP100 */
> > +                     cooling-device =3D <&cpu 0 1>;
>
> omap4-cpu-thermal.dtsi uses THERMAL_NO_LIMIT constants but I do not
> understand their meaning (and how it relates to the opp list).

I read through the documentation, but it wasn't completely clear to
me. AFAICT, the numbers after &cpu represent the min and max index in
the OPP table when the condition is hit.
>
> > +             };
> > +     };
>
> Seems to make sense when comparing to omap4-cpu-thermal.dtsi...
>
> Maybe we can add the trip points to omap3-cpu-thermal.dtsi
> because they seem to be the same for all omap3 variants and
> just have a SoC variant specific cooling map for omap36xx.dtsi.

The OPP's for OMAP3530 show that OPP5 and OPP6 are capable of
operating at 105C.  AM3517 is a little different also, so I didn't
want to make a generic omap3 throttling table.  Since my goal was to
try to remove the need for the turbo option from the newly supported
1GHz omap3630/3730, I was hoping to get this pushed first.  From
there, we can tweak the 34xx.dtsi and 3517.dtsi for their respective
thermal information.

>
> > +};
> > +
> > /* OMAP3630 needs dss_96m_fck for VENC */
> > &venc {
> >       clocks =3D <&dss_tv_fck>, <&dss_96m_fck>;
> > --
> > 2.17.1
> >
>
> The question is how we can test that. Heating up the omap36xx to 90=C2=B0=
C
> or even 105=C2=B0C isn't that easy like with omap5...
>
> Maybe we can modify the millicelsius values for testing purposes to
> something in reachable range, e.g. 60=C2=B0C and 70=C2=B0C and watch what=
 happens?

I have access to a thermal chamber at work, but the guy who knows how
to use it is out for the rest of the week.  My plan was do as you
suggested and change the milicelsius values, but I wanted to get some
buy-in from TI people and/or Tony.  This also means enabling the omap3
thermal stuff which clearly throws a message that it's inaccurate.  I
don't know how much it's inaccurate, so we may have to make the 90C
value lower to compensate.

adam
>
> BR,
> Nikolaus
>
>
>
