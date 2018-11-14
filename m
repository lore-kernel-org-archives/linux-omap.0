From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device is
 not found
Date: Wed, 14 Nov 2018 12:20:04 +0200
Message-ID: <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
 <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
 <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
 <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com> <5BEBEF7C.7060003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5BEBEF7C.7060003@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 14, 2018 at 11:48 AM Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>
> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 18:36, Andy Shevchenko wrote:
> > On Wed, Nov 14, 2018 at 06:13:37PM +0900, Chanwoo Choi wrote:
> >> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 17:35, Andy Shevchenko wrote:
> >>> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> =
wrote:
> >>>
> >>>> I was thinking about again to change from NULL to EPROBE_DEFER.
> >>>>
> >>>> extcon_get_extcon_dev() function was almost called in the probe func=
tion.
> >>>> But, this function might be called on other position instead of prob=
e.
> >>>
> >>> *Might be* sounds like a theoretical thing, care to share what is in =
you mind?
> >>> Current users and more important the new coming one are *all* doing t=
he same.
> >>>
> >>>> ENODEV is more correct error instead of EPROBE_DEFER.
> >>>
> >>> So, you are proposing to continue duplicating conversion from ENODEV
> >>> to EPROBE_DEFER in *each* caller?
> >>
> >> The extcon core don't know the caller situation is in either probe() o=
r other position
> >> in the caller driver. The caller driver should decide the kind of erro=
r value
> >> by using the return value of extcon_get_extcon_dev().
> >>
> >> extcon_get_extcon_dev() function cannot be modified for only one case.
> >> If some device driver call extcon_get_extcon_dev() out of probe() fuct=
ion,
> >> EPROBE_DEFER is not always correct.
> >
> > I agree with this, but look at the current state of affairs. All users =
do the same.
> > If we need to have another case we may consider this later.
>
> Because we know the potential wrong case of this change, I can't agree th=
is change.
> If extcon_get_extcon_dev() returns ENODEV instead of EPROBE_DEFER,
> it is clear and then there are no problem on both current and future.

Changing NULL to -ENODEV is a trading bad to worse.
I would not go that way, so, it's your call.

> > API inside the kernel are not carved in the stone.

Only can repeat myself (see above). While I see *theoretical*
rationale on your side, mine has *practical* proofs.
So, I'm giving up on this and will duplicate same what it's done in 4
current callers.

--=20
With Best Regards,
Andy Shevchenko
