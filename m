From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 14:53:44 +0200
Message-ID: <a109cf80-24cc-dc72-d0ab-265034c0bd4f@ti.com>
References: <201701012054.54505@pali> <20170101223639.GA13868@amd>
 <b80636f3-add3-9edf-009d-a938f1e9ebf9@ti.com> <20170102085150.GB6728@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170102085150.GB6728@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 01/02/2017 10:51 AM, Pali Rohár wrote:
> On Monday 02 January 2017 10:34:34 Peter Ujfalusi wrote:
>> On 01/02/2017 12:36 AM, Pavel Machek wrote:
>>> Are there multi-button headsets compatible with N900?
>>
>> Not sure if n900 is capable of handling ECI communication, n9 was. In n9
>> the PMIC/Audio chip had an ECI core integrated afaik
> 
> In N9 it is handled by twl5030 chip? Is there documentation for that
> ECI/ACI part? N900 has twl4030 so we need some chip documentation for
> adding support for N900...

n9 has twl5031 and the documentation is not public. But the kernel
source from Nokia have the driver under drivers/mfd/twl5031-aci.c It is
using the ECI stack to report the changes.
twl4030 and twl5030 does not have support for ECI, only twl5031.


-- 
Péter
