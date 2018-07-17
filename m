From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v5 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Tue, 17 Jul 2018 08:52:30 +0200
Message-ID: <800297F2-B482-42B2-A9D3-A78184B2C1BA@dominion.thruhere.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-3-git-send-email-koen@dominion.thruhere.net>
 <20180717063631.GZ99251@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717063631.GZ99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



> Op 17 jul. 2018, om 08:36 heeft Tony Lindgren <tony@atomide.com> het =
volgende geschreven:
>=20
> * Koen Kooi <koen@dominion.thruhere.net> [180717 06:28]:
>> +&i2c0 {
>> +	lps331ap: barometer@5c {
>> +		compatible =3D "st,lps331ap-press";
>> +		st,drdy-int-pin =3D <1>;
>> +		reg =3D <0x5c>;
>> +		interrupt-parent =3D <&gpio1>;
>> +		interrupts =3D <26 IRQ_TYPE_EDGE_RISING>;
>> +	};
>> +
>> +	mpu6050: accelerometer@68 {
>> +		compatible =3D "invensense,mpu6050";
>> +		reg =3D <0x68>;
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <2 IRQ_TYPE_EDGE_RISING>;
>> +		orientation =3D <0xff 0 0 0 1 0 0 0 0xff>;
>> +	};
>> +
>> +	usb2512b@2c {
>> +		compatible =3D "microchip,usb2512b";
>> +		reg =3D <0x2c>;
>> +		reset-gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
>> +		/* wifi on port 4 */
>> +	};
>> +};
>=20
> Thanks for updating it, should the last one be usb-hub@2c?

Yes, it should be. Never update patches halfway through your first =
morning coffee :) V6 coming up!

regards,

Koen=
