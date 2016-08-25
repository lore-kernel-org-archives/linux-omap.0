From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Thu, 25 Aug 2016 04:43:40 +0200
Message-ID: <CAALWOA_JStjvXv3u46bq91Dz0sR6HwAoL8Y6t2MzPVMw5zz=Tw@mail.gmail.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com> <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com> <56966558.1070608@ti.com>
 <569669C5.2070200@ti.com> <20160113164856.GF12777@atomide.com>
 <5696896F.4090309@ti.com> <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com> <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com> <5696A002.6050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5696A002.6050402@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 13 January 2016 at 19:18, Nishanth Menon <nm@ti.com> wrote:
> As you already see it is ridiculously round about way of protecting RTC
> time.. but anyways, for what ever reason, that was mandatory function to
> support on certain product lines.

Having secure date/time is probably necessary for some digital rights
management schemes; e.g. you rent a movie for limited time, but it may
not always be acceptable to require working internet connectivity to
be able to hit the play button hence the need to rely on a secure RTC.

There wouldn't even be an SMC for setting the RTC, probably it would
synchronize when the secure-world shizzle contacts the Big Server
O'Secrety Bits. :P

Protecting pinmux through the L4 firewall sounds hilarious: the whole
ctrl_core module (0x4a002000 - 0x4a002fff) is a single firewall
region. All permitted access to it by linux would have to be
redirected to an SMC or similar.

On 13 January 2016 at 20:05, Nishanth Menon <nm@ti.com> wrote:
> An internal feedback I got some time back on AM57 (not OMAP5) - context
> was that we were discussing if an external pull up resistor was needed
> for a GPIO button:
> "Internal pull-ups are relatively weak (ranging to 100kOhm or higher)

Unlike the OMAP5, AM57xx uses 1.8V/3.3V drivers for its generic IOs,
which have to do magic to not get fried by such high voltages.
Crappier specs result, especially for pulling up to 3.3V:
1.8V mode, pull-down current while pin is held high: 50-210 uA
3.3V mode, pull-down current while pin is held high: 40-200 uA
1.8V mode, pull-up current while pin is held low: 60-200 uA
3.3V mode, pull-up current while pin is held low: 10-290 uA

Note the worst-case equivalent pull-up resistance in 3.3V mode is 330
kOhm, eleven times higher than in 1.8V mode.

Matthijs
