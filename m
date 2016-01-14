From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Thu, 14 Jan 2016 11:39:24 -0600
Message-ID: <5697DD4C.8010701@ti.com>
References: <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
 <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com> <20160113194032.GL12777@atomide.com>
 <5696D097.3040208@gmail.com> <56977211.8070206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56977211.8070206-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/14/2016 04:01 AM, Keerthy wrote:
> 
> 
> On Thursday 14 January 2016 04:02 AM, Nishanth Menon wrote:
>> On 01/13/2016 01:40 PM, Tony Lindgren wrote:
>>
>>> Anyways, considering what's been discussed, after the minimal RTC fix
>>> we could also add code to allow the TWL driver optionally configure the
>>> GPIO. This way the TWL driver could also check the GPIO state in case
>>> some out-of-our-control mystery software goes tweak the msecure pin
>>> state.
>>
>> I dont even know how that will work:
>> If you are using MSECURE as it is intended to be, then you'd mux it to
>> msecure, which means that GPIO read is just a waste of time - you dont
>> even mux it to external world. Now, some SoCs like DRA7 has input lines
>> always connected. even assuming this is for such a case:
>> a) when you are running linux, you are already in nonsecure - it needs
>> no read of MSECURE GPIO to figure that out.
>> b)  when you are in secure world, Linux wont be running either.
>>
>> Reading from GPIO is just misguided in my opinion. firewalls are not
>> reconfigured, and muxes are usually done a single time.
>>
>>   Or the RTC driver could just check that the bits really change
>>> after= writing them. Then we would at least know things are not working
>>> right for the TWL related RTC drivers.
>>
>> that is reasonable to check, but just a overhead - anyways, just
>> isolated to palmas-rtc.. fail reason maynot always be issues with
>> MSECURE mux.. it could be very well be 32k clk fail etc.. but yeah -
>> that might give a hint that there is an issue..
>>
> 
> IIRC without configuring the mux mode of gpio234 to msecure mode we were 
> unable to write to the rtc registers. Hence configured it one time at boot.
> 
Looks like you missed the code section that shows that the u-boot
configuration was overridden by kernel as GPIO for the very same reason.!

http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5panda.c;h=6113bc0e04625a1bd794b3f169581c67ad3b42ff;hb=refs/heads/p-linux-omap-3.4#l816

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
