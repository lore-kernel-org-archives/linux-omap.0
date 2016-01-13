From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Wed, 13 Jan 2016 19:00:35 +0100
Message-ID: <3F9F2BA4-65FB-421F-A1BB-37F7CC59A519@goldelico.com>
References: <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com> <20160108190457.GY12777@atomide.com> <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com> <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com> <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com> <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com> <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com> <56966558.1070608@ti.com> <569669C5.2070200@ti.com> <20160113164856.GF12777@atomide.com> <56968596.2070105@ti.com> <56968B9C.1060600@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56968B9C.1060600@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org


Am 13.01.2016 um 18:38 schrieb Nishanth Menon <nm@ti.com>:

> On 01/13/2016 11:12 AM, Grygorii Strashko wrote:
>> On 01/13/2016 06:48 PM, Tony Lindgren wrote:
> 
> [...]
> 
>>> Care to dig up some more information on that?
>> 
>> i can't find this report, sry - as i remember there was difference
>> between some OMAP4 HS and GP SoCs. 
>> 
>> But links on commits for old 3.4 kernel below:
>> http://omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=a7a516be9338eabc9a7682e7433fa34d86c1f208
>> http://omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=262669aebf4af4044a25e8292f0e27986e18445a
>> 
>>> 
>>> I don't have anything against adding GPIO handling to the TWL driver
>>> so it can be optionally specified. But that's clearly a separate patch
>>> and should be done by somebody who knows more about the issue and has
>>> a test case needing the GPIO logic for this pin.
>>> 
>> 
>> 
> if it helps in anyways
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170707.html

>> Yes, the TRM has some mode bits marked as reserved, but that doesn't
>> mean they don't work.  It just means the documentation is squirreled
>> away in the secure TRM addendum.

Ok, now I understand why the "reserved" MUX_MODE1 could still be correct
for OMAP5. And that I just have a "squirreled away" version of the TRM which
made me wonder what is going on.

>From this discussion I read that for X15 there is a different PMIC
(Palmas derived, but not a twl6037) so that it needs something different.

So my proposal would be to keep the MUX_MODE1 (because it works
on OMAP5+TWL6037) as proposed by Tony. Maybe after adding a comment
that MUX_MODE1 is a weakly documented feature.

And the X15 board can "patch" it after using the omap5-board-common.dtsi
to whatever it needs to fix it.

BR,
Nikolaus
