From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
Date: Fri, 6 Sep 2019 09:53:01 +0200
Message-ID: <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com> <20190905142734.GV52127@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905142734.GV52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-OMAP <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi,
I am preparing the next PATCH version now. Incl. updating the commit
messages to carry more documentation about the opp-supported-hw bit
definitions.

So please do not merge yet.

> Am 05.09.2019 um 16:27 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> Hi,
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
>> According to omap.txt bindings documentation, matching the ti-cpufreq =
driver needs
>> to specify explicitly if a board uses an omap3430 or omap36xx chip.
>>=20
>> This needs to add ti,omap3430 to most omap34xx boards and replace =
ti,omap3630
>> by ti,omap36xx for some omap36xx boards (most others already have =
done it right).
>>=20
>> We also clean up some instances of missing ti,am3517 so that we can =
rely on
>> seeing either one of:
>>=20
>> ti,am3517
>> ti,omap34xx
>> ti,omap36xx
>>=20
>> in addition to ti,omap3.
>=20
> Please set up things to use ti,omap3630 in addition to ti,omap36xx
> for compatible to avoid churning the same files later.
>=20
>> diff --git a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts =
b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
>> --- a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
>> +++ b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
>> @@ -9,5 +9,5 @@
>>=20
>> / {
>> 	model =3D "LogicPD Zoom DM3730 SOM-LV Development Kit";
>> -	compatible =3D "logicpd,dm3730-som-lv-devkit", "ti,omap3630", =
"ti,omap3";
>> +	compatible =3D "logicpd,dm3730-som-lv-devkit", "ti,omap36xx", =
"ti,omap3";
>> };
>=20
> So just make this:
>=20
> compatible =3D "logicpd,dm3730-som-lv-devkit", "ti,omap3630", =
"ti,omap36xx", "ti,omap3";

Do we really need both? The clock driver already checks for both =
variants and the
ti-cpufreq will as well. So it suffices to have either "ti,omap3630" or =
"ti,omap36xx".

But yes, there may be user-space code that reads sysfs. So we should =
keep the
"ti,omap3630" and add "ti,omap36xx".

>=20
> And so on. It's fine to use ti,omap3630 for 37xx too as they're the =
same.
>=20
>> diff --git a/arch/arm/boot/dts/omap3-ldp.dts =
b/arch/arm/boot/dts/omap3-ldp.dts
>> index 9a5fde2d9bce..9947574bd0f8 100644
>> --- a/arch/arm/boot/dts/omap3-ldp.dts
>> +++ b/arch/arm/boot/dts/omap3-ldp.dts
>> @@ -10,7 +10,7 @@
>>=20
>> / {
>> 	model =3D "TI OMAP3430 LDP (Zoom1 Labrador)";
>> -	compatible =3D "ti,omap3-ldp", "ti,omap3";
>> +	compatible =3D "ti,omap3-ldp", "ti,omap34xx, "ti,omap3";
>=20
> This fails to compile, it's missing a '"' for ti,omap34xx. And here =
too,
> please update to use:

Ah yes. I missed that (and my build script did not build all DTB).

>=20
> compatible =3D "ti,omap3-ldp", "ti,omap3430", "ti,omap34xx", =
"ti,omap3";

After thinking a little about the whole topic the main rule of this =
change must be:

* do not break any existing in-tree DTS
	=3D> only *add* to compatible what we need to distinguish =
between omap34 and omap36

* additions shall only follow new scheme
	=3D> we only add "ti,omap34xx" or "ti,omap36xx"
           but neither "ti,omap3630" nor "ti,omap3430"

* cover some out-of-tree DTS
	=3D> make the ti-cpufreq driver still match "ti,omap3430" or =
"ti,omap3630"
	   even if this duplicates compatibility

This would mean that the logicpd-som-lv-37xx-devkit.dts gets the =
additional "ti,omap36xx"
while the omap3-ldp.dts would only get an "ti,omap34xx" but no =
"ti,omap3430" (since we
do not use it anywhere).

Could you agree on this approach?

>=20
> And again it's fine to add "ti,omap3430" for 3530 variants.

Yes, sure.

BR,
Nikolaus
