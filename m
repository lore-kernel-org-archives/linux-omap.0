From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 1/2] Documentation: devicetree: mfd: twl4030-power:
 Use the standard 'ti,system-power-controller' to mark power control
Date: Wed, 17 Sep 2014 14:39:58 -0700
Message-ID: <20140917213958.GU30918@lee--X1>
References: <1410957252-764-1-git-send-email-nm@ti.com>
 <1410957252-764-2-git-send-email-nm@ti.com>
 <20140917154400.GE30918@lee--X1>
 <20140917165529.GA24699@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140917165529.GA24699@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 17 Sep 2014, Sebastian Reichel wrote:

> On Wed, Sep 17, 2014 at 08:44:00AM -0700, Lee Jones wrote:
> > On Wed, 17 Sep 2014, Nishanth Menon wrote:
> > > ti,system-power-controller is more or less the standard way of
> > > indicating that the PMIC is the system wide power controller and =
hence
> > > may be used to switch off the system. Almost ALL TI PMIC drivers =
and
> > > many Maxim PMIC drivers follow the same style.
> > >=20
> > > So support 'ti,system-power-controller' in addition to the usual
> > > 'ti,use_poweroff' to indicate that the PMIC instance has control =
for
> > > switching off the system.
> > >=20
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > >=20
> > > V2: picked up documentation suggestion from Sebastien
> >=20
> > It would be good to get Sebastian's Ack.
>=20
> Acked-By: Sebastian Reichel <sre@kernel.org>
>=20
> [...]
>=20
> > > +- ti,system-power-controller: This indicates that TWL4030 is the
> > > +  power supply master of the system. With this flag, the chip wi=
ll
> > > +  initiates an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
> > > +  system poweroffs.
>=20
> One minor thing: While the documentation is updated you may want to
> fix the typo "will initiates" to "will initiate" (or just drop the
> "will").

Applied with Sebastian's Ack and I fixed this up too.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
