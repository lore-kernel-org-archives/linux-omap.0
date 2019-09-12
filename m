From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Thu, 12 Sep 2019 16:19:33 -0500
Message-ID: <CAHCN7xKjwkJHysSkNymF=sw6KuS=FqbapuRFZODuj6E_hmRG1A@mail.gmail.com>
References: <20190912183037.18449-1-aford173@gmail.com> <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 12, 2019 at 4:12 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/09/2019 20:30, Adam Ford wrote:
> > The thermal sensor in the omap3 family isn't accurate, but it's
> > better than nothing.  The various OPP's enabled for the omap3630
> > support up to OPP1G, however the datasheet for the DM3730 states
> > that OPP130 and OPP1G are not available above TJ of 90C.
> >
> > This patch configures the thermal throttling to limit the
> > operating points of the omap3630 to Only OPP50 and OPP100 if
> > the thermal sensor reads a value above 90C.
>
> Out of curiosity, what are the OPP50 and OPP100 mentioned above? and
> what does mean "OPP130 and OPP1G are not available above TJ of 90C"?
>
OPP130 is the 800 MHz and OPP1G is 1GHz operating point.
The 90C is the max junction temperature.  When the temperature exceeds
90C, the processor is not designed to operate at 800+ MHz.  The
statement itself is a direct quote from the public datasheet for the
dm3730, Table 4-19.

The datasheet is: http://www.ti.com/lit/ds/symlink/dm3730.pdf

The operating points were updated in [1], but they haven't yet been
fully applied yet, but during the discussion, the question came about
regarding how to limit the speed at high temp, so that's why this
patch was done.

[1] - https://patchwork.kernel.org/patch/11141643/


adam

> I don't see the connection between these OPP names and the definition in
> the DT.
>
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
> >  };
> >
> > +&cpu_thermal {
> > +     cpu_trips: trips {
> > +             /* OPP130 and OPP1G are not available above TJ of 90C. */
> > +             cpu_alert0: cpu_alert {
> > +                     temperature =3D <90000>; /* millicelsius */
> > +                     hysteresis =3D <2000>; /* millicelsius */
> > +                     type =3D "passive";
> > +             };
> > +
> > +             cpu_crit: cpu_crit {
> > +                     temperature =3D <125000>; /* millicelsius */
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
> > +             };
> > +     };
> > +};
> > +
> >  /* OMAP3630 needs dss_96m_fck for VENC */
> >  &venc {
> >       clocks =3D <&dss_tv_fck>, <&dss_96m_fck>;
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
