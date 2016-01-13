From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 16:32:55 -0600
Message-ID: <5696D097.3040208@gmail.com>
References: <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
 <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com> <20160113194032.GL12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113194032.GL12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 01:40 PM, Tony Lindgren wrote:

> Anyways, considering what's been discussed, after the minimal RTC fix
> we could also add code to allow the TWL driver optionally configure the
> GPIO. This way the TWL driver could also check the GPIO state in case
> some out-of-our-control mystery software goes tweak the msecure pin
> state.

I dont even know how that will work:
If you are using MSECURE as it is intended to be, then you'd mux it to
msecure, which means that GPIO read is just a waste of time - you dont
even mux it to external world. Now, some SoCs like DRA7 has input lines
always connected. even assuming this is for such a case:
a) when you are running linux, you are already in nonsecure - it needs
no read of MSECURE GPIO to figure that out.
b)  when you are in secure world, Linux wont be running either.

Reading from GPIO is just misguided in my opinion. firewalls are not
reconfigured, and muxes are usually done a single time.

 Or the RTC driver could just check that the bits really change
> after= writing them. Then we would at least know things are not working
> right for the TWL related RTC drivers.

that is reasonable to check, but just a overhead - anyways, just
isolated to palmas-rtc.. fail reason maynot always be issues with
MSECURE mux.. it could be very well be 32k clk fail etc.. but yeah -
that might give a hint that there is an issue..

-- 
Regards,
Nishanth Menon
