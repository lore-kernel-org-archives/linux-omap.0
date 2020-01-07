From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arm: dts: am335x-boneblack-common: fix memory size
Date: Tue, 7 Jan 2020 12:32:30 -0600
Message-ID: <CAOCHtYhKUyUwunnWDT1CuRTpzS78d7xKq3qB3Phys7RgUZnM3w@mail.gmail.com>
References: <20200106130909.7697-1-matwey@sai.msu.ru> <CAOCHtYgyN+qXXX1YeEcO+nvRFrAL1HAVVMvjfeJ5nvxVjtFKtg@mail.gmail.com>
 <CAJs94EbUL6o9sM+pwxwpqHVDkFqy7wFRirET-Vq3SNVd3grUsA@mail.gmail.com> <20200106210509.GF5885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106210509.GF5885@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OMAP DEVICE TREE SUPPORT" <linux-omap@vger.kernel.org>, "open list:OMAP DEVICE TREE SUPPORT" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 6, 2020 at 3:05 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Matwey V. Kornilov <matwey@sai.msu.ru> [200106 20:48]:
> > =D0=BF=D0=BD, 6 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3. =D0=B2 23:44, Robert N=
elson <robertcnelson@gmail.com>:
> > >
> > > On Mon, Jan 6, 2020 at 7:10 AM Matwey V. Kornilov <matwey@sai.msu.ru>=
 wrote:
> > > >
> > > > BeagleBone Black series is equipped with 512MB RAM
> > > > whereas only 256MB is included from am335x-bone-common.dtsi
> > >
> > > FYI: While all versions from the factory are 512MB, some 3rd parties
> > > offered 1GB reballing upgrades..
>
> So what's the conclusion, is it safe to bump the default size to
> 512MB then?
>
> The custom ones could use their own dts file if bootloader is not
> setting the RAM.

Yeah this is safe for factory devices. Classic u-boot will update
these for modified boards.

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
