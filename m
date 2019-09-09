From: Adam Ford <aford173@gmail.com>
Subject: Re: [Letux-kernel] [RFC PATCH 0/3] Enable 1GHz support on omap36xx
Date: Mon, 9 Sep 2019 11:38:47 -0500
Message-ID: <CAHCN7xLyeSFCMn=qhmYa0ZsqsQheHDz8zyBz38giECK9wixbuw@mail.gmail.com>
References: <C04F49BA-1229-4E96-9FCF-4FC662D1DB11@goldelico.com>
 <CAHCN7x+Ye6sB_YqO0sAX1OJDw64B-qGS3pL545v3Xk5z914cwQ@mail.gmail.com>
 <0C1EF64E-B33C-4BFA-A7D3-471DD1B9EE86@goldelico.com> <515048DE-138D-4400-8168-F2B7D61F1005@goldelico.com>
 <CAHCN7xLPCX9rZ0+7KVBiA_bgZ6tg6VeCXqD-UXu+6iwpFMPVrA@mail.gmail.com>
 <7B3D1D77-3E8C-444F-90B9-6DF2641178B8@goldelico.com> <CAHCN7xLW58ggx3CpVL=HdCVHWo6D-MCTB91A_9rtSRoZQ+xJuQ@mail.gmail.com>
 <FA2920FE-B76A-4D44-A264-862A1CCBF7FC@goldelico.com> <CAHCN7xJsPa0i+Z+qpCkWcdAh9+udmGT0RPNchdDsfB=8ptd3Nw@mail.gmail.com>
 <87420DBD-770F-4C32-9499-A3AEA5876E8A@goldelico.com> <20190909163236.GP52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909163236.GP52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 9, 2019 at 11:32 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * H. Nikolaus Schaller <hns@goldelico.com> [190909 14:57]:
> > Another question that came up by private mail from Andr=C3=A9 was if we
> > should better disable the turbo OPPs of omap34xx and 36xx by default
> > (status =3D "disabled";) because there are concerns about overheating
> > the chips and we have no thermal regulation like for omap4 & 5.

I thought there was a thermal sensor?

cpu_thermal: cpu_thermal {
        polling-delay-passive =3D <250>; /* milliseconds */
        polling-delay =3D <1000>; /* milliseconds */
        coefficients =3D <0 20000>;

                        /* sensor       ID */
        thermal-sensors =3D <&bandgap     0>;
};

Can this driver somehow notify the cpufreq that we've hit some limit?
I know it's not as accurate as one would like, but even for non-1GHz
versions, having it downclock would be a good thing when running at
extreme temps.

adam
> >
> > But this would mean that every board DTS would have to set it explicitl=
y
> > to "enabled".
>
> Yes I started thinking about that too. I think there is a requirement
> to do the scaling via the voltage processor for the higher modes.
> And there needs to be some way to automatically change to a lower
> OPP in some cases.
>
> For normal OPPs, using the twl regulator directly should be OK.
>
> For the higher modes, maybe we could pass the callback functions
> from arch/arm/mach-omap2/voltage.c for the twl regulator so the
> voltage processor hardware can handle them directly. Or add a
> separate regulator driver operating the voltages like Nishanth
> posted patches for earlier.
>
> Regards,
>
> Tony
