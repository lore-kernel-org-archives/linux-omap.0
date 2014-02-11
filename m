From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-n9 family: mark proper OMAP version
Date: Tue, 11 Feb 2014 14:10:07 -0600
Message-ID: <52FA839F.5090304@ti.com>
References: <1392132541-25340-1-git-send-email-nm@ti.com> <20140211185136.GG573@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140211185136.GG573@drone.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Aaro,
On 02/11/2014 12:51 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Feb 11, 2014 at 09:29:01AM -0600, Nishanth Menon wrote:
>> Nokia N900 uses OMAP3430 and N9/N950 uses OMAP3630. Mark SoC compatibilty
>> as per Documentation/devicetree/bindings/arm/omap/omap.txt else
>> N9/N950 will be probed as a OMAP3430 type device, since default ti,omap3
>> maps to OMAP3430 compatibility.
> 
> I already sent & tested patches for this:
> 
> http://marc.info/?l=linux-omap&m=139194800711362&w=2
> http://marc.info/?l=linux-omap&m=139194800011360&w=2
> 
> The N9/N950 is mandatory for 3.14, as the boot hangs without it.

Thanks. Apologies on missing these, I caught these based on a git grep
on an unrelated thing.. I will ack your patches - they are obvious
regressions.


-- 
Regards,
Nishanth Menon
