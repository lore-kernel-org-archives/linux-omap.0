From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 11:38:36 -0600
Message-ID: <56968B9C.1060600@ti.com>
References: <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com>
 <20160108190457.GY12777@atomide.com>
 <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <56968596.2070105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56968596.2070105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 11:12 AM, Grygorii Strashko wrote:
> On 01/13/2016 06:48 PM, Tony Lindgren wrote:

[...]

>> Care to dig up some more information on that?
> 
> i can't find this report, sry - as i remember there was difference
> between some OMAP4 HS and GP SoCs. 
> 
> But links on commits for old 3.4 kernel below:
> http://omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=a7a516be9338eabc9a7682e7433fa34d86c1f208
> http://omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=262669aebf4af4044a25e8292f0e27986e18445a
> 
>>
>> I don't have anything against adding GPIO handling to the TWL driver
>> so it can be optionally specified. But that's clearly a separate patch
>> and should be done by somebody who knows more about the issue and has
>> a test case needing the GPIO logic for this pin.
>>
> 
> 
if it helps in anyways
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170707.html


-- 
Regards,
Nishanth Menon
