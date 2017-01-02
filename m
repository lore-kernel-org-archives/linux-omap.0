From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 09:51:50 +0100
Message-ID: <20170102085150.GB6728@pali>
References: <201701012054.54505@pali>
 <20170101223639.GA13868@amd>
 <b80636f3-add3-9edf-009d-a938f1e9ebf9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b80636f3-add3-9edf-009d-a938f1e9ebf9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 02 January 2017 10:34:34 Peter Ujfalusi wrote:
> On 01/02/2017 12:36 AM, Pavel Machek wrote:
> > Are there multi-button headsets compatible with N900?
> 
> Not sure if n900 is capable of handling ECI communication, n9 was. In n9
> the PMIC/Audio chip had an ECI core integrated afaik

In N9 it is handled by twl5030 chip? Is there documentation for that
ECI/ACI part? N900 has twl4030 so we need some chip documentation for
adding support for N900...

-- 
Pali Rohár
pali.rohar@gmail.com
