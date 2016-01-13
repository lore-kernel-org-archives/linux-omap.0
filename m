From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 12:23:35 -0600
Message-ID: <56969627.8070802@ti.com>
References: <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com>
 <20160108190457.GY12777@atomide.com>
 <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <56968596.2070105@ti.com>
 <56968B9C.1060600@ti.com>
 <3F9F2BA4-65FB-421F-A1BB-37F7CC59A519@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3F9F2BA4-65FB-421F-A1BB-37F7CC59A519@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 12:00 PM, H. Nikolaus Schaller wrote:
[...]
> And the X15 board can "patch" it after using the omap5-board-common.dtsi
> to whatever it needs to fix it.
> 

There is nothing to patch on X15[1]. there is no MSECURE pin on X15.
there are three RTCs on X15: MCP, TPS and DRA7-RTC. TPS has no use for
RTC, in fact has no capability of having a backup battery - which pretty
much (at least IMHO) removes real world use of TPS as a RTC in a
non-networked world.. but anyways, lets keep X15 and uevm seperate -
they dont share much in this context.

[1]
https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf

-- 
Regards,
Nishanth Menon
