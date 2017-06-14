From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 2/2] regulator: tps65910: Allow supply references to
 the same chip
Date: Wed, 14 Jun 2017 09:56:37 +0200
Message-ID: <CABxcv==FqU7y1dpDC7eausDwu6eGwBm4C_NeupYtzdbYYfkoSw@mail.gmail.com>
References: <f2aee03834d8cdcc7195b9272982617d93f978dc.1497364762.git.mirq-linux@rere.qmqm.pl>
 <053529c206a2afc453b52e2c0f024acd85341a83.1497364762.git.mirq-linux@rere.qmqm.pl>
 <20170613174628.sv4v76s7torrn5jx@sirena.org.uk> <20170613202217.nj23xkahpz3jc4h5@qmqm.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613202217.nj23xkahpz3jc4h5@qmqm.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Mark Brown <broonie@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Michal,

What kernel version are you using?

It shouldn't be necessary anymore to resolve regulators dependencies
during regulator_register(), now that logic to lookup the parent
supply has been moved to regulator_get() instead.

On Tue, Jun 13, 2017 at 10:22 PM, Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:
> On Tue, Jun 13, 2017 at 06:46:28PM +0100, Mark Brown wrote:
>> On Tue, Jun 13, 2017 at 04:41:58PM +0200, Micha=C5=82 Miros=C5=82aw wrot=
e:
>> > This allows for (acyclic) references from tps6591x supplies to
>> > its outputs.
>> This is clearly not something that should be open coded in individual
>> drivers, aside from the code duplication it is obviously possible to
>> have two different chips supplying each other which this wouldn't help
>> at all.  Is this happening for you with current kernels, we have a few
>> mechanisms for deferring bindings of supplies which should help here.
>
> What mechanisms would that be? What I observed is that whenever

The specific commit that adds the mechanism Mark is referring to is:

commit 6261b06de565baafa590e58a531a1a5522cea0b6
Author: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date:   Tue Mar 24 18:56:05 2015 -0700

    regulator: Defer lookup of supply to regulator_get

    Instead of resolving regulator supplies during registration move this t=
o
    the time of a consumer retrieving a handle. The benefit is that it's
    possible for one driver to register regulators with internal
    dependencies out of order.

    Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

> a regulator's supply is not available but described in device-tree,

What do you mean by not available? At some point it the parent supply
should be registered with the regulator core and prevent the client
device to defer its probe when calling regulator_get().

Now, if you don't have a client device that calls regulator_get() to
resolve the parent supply but still need the parent supply to be
enabled, this commit does in the core what you attempt to do in your
driver:

commit 5e3ca2b349b1e2c80b060b51bbf2af37448fad85
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Wed Mar 23 20:59:34 2016 -0300

    regulator: Try to resolve regulators supplies on registration

    Commit 6261b06de565 ("regulator: Defer lookup of supply to regulator_ge=
t")
    moved the regulator supplies lookup logic from the regulators registrat=
ion
    to the regulators get time.

    Unfortunately, that changed the behavior of the regulator core since no=
w a
    parent supply with a child regulator marked as always-on, won't be enab=
led
    unless a client driver attempts to get the child regulator during boot.

    This patch tries to resolve the parent supply for the already registere=
d
    regulators each time that a new regulator is registered. So the regulat=
ors
    that have child regulators marked as always on will be enabled regardle=
ss
    if a driver gets the child regulator or not.

    That was the behavior before the mentioned commit, since parent supplie=
s
    were looked up at regulator registration time instead of during child g=
et.

    Since regulator_resolve_supply() checks for rdev->supply, most of the t=
imes
    it will be a no-op. Errors aren't checked to keep the possible out of o=
rder
    dependencies which was the motivation for the mentioned commit.

    Also, the supply being available will be enforced on regulator get anyw=
ays
    in case the resolve fails on regulators registration.

    Fixes: 6261b06de565 ("regulator: Defer lookup of supply to regulator_ge=
t")
    Suggested-by: Mark Brown <broonie@kernel.org>
    Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>
    Cc: <stable@vger.kernel.org> # 4.1+

> the whole device's registration is deferred.
>
> The device-tree I'm working on contains:
>
> pmic: tps65911@2d {
>     compatible =3D "ti,tps65911";
>     reg =3D <0x2d>;
>     ...
>     vcc3-supply =3D <&vio_reg>; // ldo6, ldo7, ldo8
>     ...
>     regulators {
>         vio_reg: vio {
>             regulator-min-microvolt =3D <1800000>;
>             regulator-max-microvolt =3D <1800000>;
>             regulator-always-on;
>         };
>         ...
>     }
> }

I don't see anything wrong with this DTS, it should work....

I did something similar for the max77802 PMIC in
arch/arm/boot/dts/exynos5800-peach-pi.dts, some regulators have as
input supplies regulators from the same PMIC and may not be
necessarily registered in the order to resolve parent supplies on
child registration.

>
> Best Regards,
> Micha=C5=82 Miros=C5=82aw

Best regards,
Javier
