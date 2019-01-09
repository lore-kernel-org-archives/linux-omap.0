From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
Date: Wed, 9 Jan 2019 19:05:05 +0100
Message-ID: <209232E2-690B-4805-9F09-79B7EEB1EEDB@goldelico.com>
References: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com> <20190109185751.3268420b@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109185751.3268420b@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi Andreas,

> Am 09.01.2019 um 18:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Hi,
>=20
> On Wed,  9 Jan 2019 18:47:52 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> From: Andreas Kemnade <andreas@kemnade.info>
>>=20
>> gta04a[34] have bluetooth chips which simply understand
>> h4 protocol.
>>=20
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>=20
> what about upstreaming the full patch based on mainline and not your
> on-top-of-other-stuff rebased version of this patch?

What do you mean? This patch is basically based on mainline (v5.0-rc1),
but I did not want to push it now, but a different one in the same patch
stack and this happened due to an still unknown error in my send-mail =
tool
which picked the wrong one after doing a test.

So please simply ignore the noise and don't worry about this patch.

BR,
Nikolaus

>=20
> Regards,
> Andreas
>=20
>> ---
>> arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>> index 499e3b0e920b..ec7b1e31c07e 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -722,6 +722,8 @@
>>=20
>> 	bluetooth: bluetooth {
>> 		compatible =3D "wi2wi,w2cbw003-bluetooth";
>> +		speed =3D <3000000>;
>> +		flow;
>> 		vdd-supply =3D <&vaux4>;
>> 	};
>> };
>=20
