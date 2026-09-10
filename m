Received: from smtpcmd03117.aruba.it (smtpcmd03117.aruba.it [62.149.158.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F424BC010
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056701; cv=none; b=EAtwpF9Rr1fZR3f+ykkWYiXHkGGOhNTNYW+F/ROwZwM3sxVwlHF7BhCk/CIn6Efk7UL4zOfkqiEQk6EjF0lCc+RwGyb7heqzdXoHVw8uUZyOYl0wQGLkux8dxiYjJAZnBjdYYonhxsqm1nEaoT/ffuMGkrgmCosgD5woAdNntEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056701; c=relaxed/simple;
	bh=iDXgxchB8TYh+FnP7dzJIawOFJjBV39fnBJKzCpj7Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO9UIKRWoT1eo/hCDzSmFTpf1JsLQNR4nnO/uLXF6abmN86mqopUqTwpvB9tzQ6G48JZQp6QgoUVdY9uqZnOMXZPCIEgi5lA6kyFYpUgB/QTsi+J5wwz4sFuax+LWMLb0VEWfQluAVOdlHJyFJHhUKdJcAg2kBkZ3iic7eQy4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=HiA5HbGx; arc=none smtp.client-ip=62.149.158.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="HiA5HbGx"
Received: from [192.168.50.197] ([84.33.84.190])
	by Aruba SMTP with ESMTPSA
	id 4hK5x55sfwNy24hK5xnjY8; Thu, 10 Sep 2026 18:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1789056508; bh=iDXgxchB8TYh+FnP7dzJIawOFJjBV39fnBJKzCpj7Z8=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=HiA5HbGxAw14LZr7gwc9EMiAgewqgLP5Gpqfh3nZ2bQQPSzOsNH7ezAaxCa+FQlAP
	 MS7BYBaS0fLpuNOsDujSDvAUyO6R3XyK2iHhr/IoIm5vRLwdup8TTtmM5yas38mtmW
	 3HBiZqu6f3BwROsmS/pHfcH444I88B5rDk4Mf/Vcg6OU25vq5C9shonmw+6F+NQytv
	 F8FhHYTokK/+vYJmVdn79o8+RAg9v5a+Ga+4h7hjvMwtxwHDTSw6sSpzkZ5I1J01Ac
	 EXPY1vZxJQZdon/d1ZxmdTIOk3NwSAgwGNC8wbMJRIm+P8fhFyA1AuT9Ru3E8bEnxI
	 O+zHjl+4JRH/g==
Message-ID: <f0c3d321-b1de-45f0-b126-a7e3ff381001@benettiengineering.com>
Date: Thu, 10 Sep 2026 18:08:25 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] ARM: imx: remove nommu support
To: Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
 Jesse Taube <mr.bossman075@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-9-arnd@kernel.org>
 <CAOMZO5Bw72SkBChbRLg+FaYZ34ENAW95-0+LrgcrESu_YtNXFQ@mail.gmail.com>
Content-Language: en-US
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <CAOMZO5Bw72SkBChbRLg+FaYZ34ENAW95-0+LrgcrESu_YtNXFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFMBAVhokiHzs+9aOHLUhkqEKrkdLt3VcC599Pt8KJC50kaml/IaBOBq/Ohw5Gg7rNvCqnB//PcQlphuhph1gxDIUTFmEUvKU2YjZZfwqJJ1+BqDe3OH
 oP7PKgIjhL1ZDEbpE2K//JBm18QD96jH5jY6dRO5oK4L576dgJr5m1siUNT3Lx5k/o/o/szFBxb9WP38SRtSyCSdwKpkl+Xc6IZbaG1i7D+wcLIcsBnyKGDr
 MOOAyaZA3gbz8r1iKuls411peL8Z88rxOv+O0sKWGt6GVo15tJXCcq6ovO0BpMNY1DbOgln2ampSRot098eLXSnFH7kh2vP/36oQ6cNrxCOAOzpKCl3P3nAz
 7886fCdr6n0892TQ04taWf6bIN23JtlzWX1r69UM87k0hijYJGAyOTF+vwh9tgU9hsS7R3gA1J5CjrUNpIwN/p3ijHzkOo0ov+vV3FqNb2/zHdPZmjD1kmYk
 Yr/wEiKg8IiuS6jMz6uxOpOmlAS6wzpT0D55UW8j1ClAGOVRwkp/2pWtVU0EoEV+FC3TmEDUPcvfKLYQmZjXmqWQCJXhMkVJ+cyJ1Y1ZN1tClKG3giEM/ZWb
 S8wAFLqRjQGx5XZBW+YDZacimTlNW6MjlZLOtPcJs+2glopjBEVyuAlaaBeynpINagnpnqx5Z+10m3snZssrElDa7lZLH4WgG9Lfvzz7gm2vyYR6SsaYtoYO
 NCQtOrmKT7fo+f0jjhjSLESsDemVT6cFqs4ftFHJIQ/Z1FxY2YWr70zngepdvAipv+Xel8CJDxSw1D1kYTz5l3d6kx+th5dfTr6N048I6T78fmMm2bbVaU/F
 s2sHj9z0oDsHSUHlTpneKUDTdZdyNqBTGxCRWtA7Ry9JByTBc2K6BCIQ1WJWJgNL5AHpRpTkczTr06ShwUENYvD+dvXidS2WbMIVs8sLGPpg4PvuGe1DNBkC
 5/pQa3lkVPVf1fvjedm+C9SlmFhStfBq4oIEUR5GIb1CUPS9xeJCvpI9t8unfO2So6XXbUBHv/xO+RU2YwIcGOFCOUfJMMVfP4lzz/boG6MD1Z+Aq4nLAp1E
 A5KK0IiJnjpsgaTD9Q8zHUt64pGQRNXWQmSF7I3BS043zUHukC6Ulu9HeLgQeeLclSn2DwiQPqbs1TmkyVCnD4Di2VmzpUNg4znZcumujj8EHhuuXB7MCO1P
 LjngNtXLKQr3rcul0mFQ1E10u08rKRuiGr8D4aHtM1chJ4T/eQI3r5iQwk6bskReLqwlilzV3TpiALQeVazxMQaeUnlCyJdFQKF+mVfoaxI+K6bk3+btXYaA
 8l3xEqdA7/pa1DFkcPmYzBzRGaLdIL8YCEsa47qLXABM3G5A9uR0TFpR7zIP1Z5ssOpIqgA80MzdK2gRls0zdKteLuC0qtE7d/yH7QFyJ4ZvdCkoxbRyJI4U
 zLjfNIQBS7QoFLB5qdsCibABaszNRMHHEy/HEX2XXHr4vRKvsXhba7LnVj/wEg6u57VFwVTrWyE2xNStm9vTay1/51JDgny1wy8bnD6XMqywikeffC2RMmEY
 0tkjqoO7CPyAb7WyQwX2DX6UWAqxGTn81Q5FLJ5Xs+iy2+jzO8/YVGg541LypTMv3prSvujdXac1b3Zt9Fspv74PNfyBKbklmhJ++Scjm8l5Vz3DFD0h+b2C
 /x0ajejCkeITuy7cMykwQpmrPW0an0MKc6nXL2EbD6DuqAAS770tyPwjUcIYo0/WXzco6fKilDtWtbtslZ4u7aho4xchWdDt80z1zlIGan7JmdImmrELzbXB
 3bVf8r2dhUbDfSSV4/NUn7BKHnLUf1s3X5MLcbnI

Hi Fabio, Arnd and Jesse,

On 9/9/26 10:21 PM, Fabio Estevam wrote:
> On Tue, Sep 8, 2026 at 12:29 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The i.MX platform has grown support for three separate product
>> lines using Cortex-M based microcontrollers over the years:
>>
>>   - i.MX RT1050, a high-end microcontroller
>>   - Vybrid vf610 suppors running Linux on either the Cortex-A5
>>     CPU or the Cortex-M4 MCU
>>   - i.MX7D similarly can run Linux on the Cortex-A7 or the
>>     Cortex-M4
>>
>> There are no known upstream users of any of those three, so
>> drop support and simplify the platform to assume that an MMU
>> is present.
>>
>> Cc: Frank Li <Frank.Li@nxp.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Stefan Agner <stefan@agner.ch>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Vladimir Zapolskiy <vz@mleia.com>
>> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: imx@lists.linux.dev
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   arch/arm/boot/dts/nxp/imx/Makefile            |    2 -
>>   arch/arm/boot/dts/nxp/imx/imxrt1050-evk.dts   |   72 -
>>   arch/arm/boot/dts/nxp/imx/imxrt1050-pinfunc.h |  993 -----------
>>   arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi      |  160 --
>>   arch/arm/boot/dts/nxp/imx/imxrt1170-pinfunc.h | 1561 -----------------
>>   arch/arm/boot/dts/nxp/vf/Makefile             |    2 -
>>   arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dts  |   61 -
>>   arch/arm/boot/dts/nxp/vf/vf610m4-cosmic.dts   |   88 -
>>   arch/arm/boot/dts/nxp/vf/vf610m4.dtsi         |   61 -
>>   arch/arm/configs/imxrt_defconfig              |   35 -
>>   arch/arm/configs/vf610m4_defconfig            |   39 -
>>   arch/arm/mach-imx/Kconfig                     |   27 +-
>>   arch/arm/mach-imx/Makefile                    |    3 -
>>   arch/arm/mach-imx/mach-imx7d-cm4.c            |   18 -
>>   arch/arm/mach-imx/mach-imxrt.c                |   19 -
> 
> The imxrt1050-evk dts is used in U-Boot.
> 
> Adding Jesse and Giulio, who use this platform in U-Boot.

MMU-less architecture never had a complete support, I agree that it's
time to drop it so:
Acked-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Best regards
Giulio Benetti
