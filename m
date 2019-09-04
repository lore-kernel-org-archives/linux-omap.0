From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 5/5] ARM: dts: omap3-beagle: make explicitly compatible to ti,omap34xx
Date: Wed, 4 Sep 2019 10:47:07 +0200
Message-ID: <4C3C8BEA-F03E-42CE-8E5C-397A025CB684@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com> <20190903134000.GM52127@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903134000.GM52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 03.09.2019 um 15:40 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190902 10:56]:
>> Matching the ti-cpufreq driver needs to specify explicitly if
>> a board uses an omap34xx or omap36xx chip.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-beagle.dts | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts =
b/arch/arm/boot/dts/omap3-beagle.dts
>> index e3df3c166902..d47213c7a4d0 100644
>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>> @@ -8,7 +8,7 @@
>>=20
>> / {
>> 	model =3D "TI OMAP3 BeagleBoard";
>> -	compatible =3D "ti,omap3-beagle", "ti,omap3";
>> +	compatible =3D "ti,omap3-beagle", "ti,omap34xx", "ti,omap3";
>>=20
>> 	cpus {
>> 		cpu@0 {
>=20
> For a clean-up patch, we should just use the following compatibles
> in general for omap3:
>=20
> ti,omap3	omap3
> ti,omap34	omap34xx and omap35xx
> ti,omap36	omap36xx and dm37xx
> ti,am35		am35xx
>=20
> So we should just leave out the "xx" part. But we still need parse
> also the legacy binding with "xx" in drivers.

Yes, getting rid of the xx in the device trees would be nice.

But I have looked through the kernel tree and that makes more problems
than it solves...

There is code that explicitly checks for "ti,omap36xx" in =
drivers/clk/ti/dpll.c

Maybe that should be replaced by a check for a "ti,dpll5" property
which is only defined in omap36xx.dtsi to make the code depend
on a feature rather than SoC family string. Although such a change
may break other things or we have to keep even more legacy code around.

And there is a binding document omap.txt that does not describe
it the way you propose. IMHO that should be changed first.

Next is that omap.txt explicitly says that ti,omap3 defauls to OMAP3430.
And OMAP3430 should be specified as compatible =3D "ti,omap3430", =
"ti,omap3"
while OMAP3630 should have compatible =3D "ti,omap36xx", "ti,omap3".
AM3517 is compatible =3D "ti,am3517", "ti,omap3" which seems to ignore
the AM3505 (maybe there was never a board using it).

So this clean up is much more than what we need for moving from
opp-v1 to opp-v2 and it should therefore be addressed separately.

Therefore I'd prefer if we can keep all these problems isolated
into a separate set of patches. And because of this I have prepared
an RFC-V2 which only adds the "ti,omap3430" to those boards which
do not yet have it (in accordance to existing omap.txt).

AM3517 does not seem to have any opp table and therefore I also
exclude it at the moment.

BR and thanks,
Nikolaus
