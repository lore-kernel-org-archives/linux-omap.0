From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v4 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Tue, 17 Jul 2018 08:26:21 +0200
Message-ID: <5CF84BA0-DF94-4692-A76C-B7A5CE74A226@dominion.thruhere.net>
References: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
 <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
 <20180717061640.GX99251@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717061640.GX99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



> Op 17 jul. 2018, om 08:16 heeft Tony Lindgren <tony@atomide.com> het =
volgende geschreven:
>=20
> Hi Koen,
>=20
> Just noticed there should be generic node names here too, see below.
>=20
> * Koen Kooi <koen@dominion.thruhere.net> [180713 06:28]:
>> The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone =
Black,
>> but with the following differences:
>>=20
>> * Gigabit capable PHY
>> * Extra USB hub, optional i2c control
>> * lps3331ap barometer connected over i2c
>> * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
>> * 1GiB DDR3 RAM
>> * RTL8723 Wifi/Bluetooth connected over USB
>=20
>> +&i2c0 {
>> +	lps331ap: lps331ap@5C {
>> +		compatible =3D "st,lps331ap-press";
>> +		st,drdy-int-pin =3D <1>;
>> +		reg =3D <0x5C>;
>> +		interrupt-parent =3D <&gpio1>;
>> +		interrupts =3D <26 IRQ_TYPE_EDGE_RISING>;
>> +	};
>=20
> lps33lap: barometer@5c
>=20
>> +	mpu6050: mpu6050@68 {
>> +		compatible =3D "invensense,mpu6050";
>> +		reg =3D <0x68>;
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <2 IRQ_TYPE_EDGE_RISING>;
>> +		orientation =3D <0xff 0 0 0 1 0 0 0 0xff>;
>> +	};
>=20
> mpu6050: accelerometer@2c
>=20
> And so on. Please check the lower case hex numbers too as
> that=E2=80=99s what Linux typically uses.

Thanks for the feedback! Fixed both issues, v5 sent out.=20

regards,

Koen

>=20
> Thanks,
>=20
> Tony
