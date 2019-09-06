From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
Date: Fri, 6 Sep 2019 19:50:38 +0200
Message-ID: <06661291-1025-4714-99BF-A3CE787E2782@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com> <20190905142734.GV52127@atomide.com> <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com> <20190906154732.GC52127@atomide.com> <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com> <20190906172403.GG52127@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190906172403.GG52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-OMAP <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 06.09.2019 um 19:24 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190906 17:09]:
>> for i in 3430 34xx 3630 36xx; do echo $i $(fgrep '"'ti,omap$i'"' =
arch/arm/boot/dts/*.dts* | wc -l); done
>>=20
>> 3430 12
>> 34xx 28
>> 3630 3
>> 36xx 23
>>=20
>> which would indicate that 34xx and 36xx are more common.
>=20
> Right, but the xx variants are against the device tree naming and
> that's why we should get rid of them in the dts. The compatible
> should be named after the first instance like "ti,omap3430" and
> similar devices can just use that.
>=20
>> BTW there is also some code that does special SoC detection based on
>> soc_device_match(), mainly in omapdrm/dss.
>>=20
>> If we were to use this mechanism in the ti-cpufreq driver we could
>> match it to ti,omap3 and could avoid all these changes.
>>=20
>> But make it less maintainable and code more complex.
>=20
> Hmm right, yeah using soc_device_match() would remove this issue.
> It might be worth doing as these SoC variants do not change
> much and the code should not need updating. Up to you to
> decide.
>=20
>> I'll also take a look at omap.txt bindings since that likely needs
>> an update as well to better describe what the official ones are
>> and which are legacy.
>=20
> OK. Just limit the compatible changes to the ones that
> need to be modified for this series, the rest can be
> done with a separate patches.

Well, with this rule we modify almost all of them.
In total ca. 35 files. But it looks right.

The rest is just one missing ti,am3517.

Here is the script I want to use for bulk conversion:

# add ti,omap3430 if missing
find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap34xx"' {} =
\; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec sed -i '' =
's/"ti,omap34xx"/"ti,omap3430", "ti,omap34xx"/' {} \;
# add ti,omap3630 if missing
find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap36xx"' {} =
\; ! -exec fgrep -q '"ti,omap3630"' {} \; -exec sed -i '' =
's/"ti,omap36xx"/"ti,omap3630", "ti,omap36xx"/' {} \;
# add ti,omap3430 default if missing
find arch/arm/boot/dts -name 'omap*.dts*' -exec fgrep -q '"ti,omap3"' {} =
\; ! -exec fgrep -q '"ti,omap3630"' {} \; ! -exec fgrep -q =
'"ti,omap36xx"' {} \; ! -exec fgrep -q '"ti,am3517"' {} \; ! -exec fgrep =
-q '"ti,omap34xx"' {} \; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec =
sed -i '' 's/"ti,omap3"/"ti,omap3430", "ti,omap3"/' {} \;

+ manually add ti,am3517 to arch/arm/boot/dts/am3517_mt_ventoux.dts

BR,
Nikolaus
