From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 17:14:13 +0200
Message-ID: <569669C5.2070200@ti.com>
References: <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com>
 <20160106164136.GI12777@atomide.com>
 <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com>
 <20160106170925.GK12777@atomide.com>
 <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com>
 <20160108181551.GX12777@atomide.com>
 <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com>
 <20160108190457.GY12777@atomide.com>
 <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56966558.1070608-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 04:55 PM, Nishanth Menon wrote:
> On 01/13/2016 04:25 AM, H. Nikolaus Schaller wrote:
> [...]
> 
>>>>>
>>>>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>>>
>>>>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>>>>> @@ -213,6 +213,12 @@
>>>>> 		>;
>>>>> 	};
>>>>>
>>>>> +	palmas_msecure_pins: palmas_msecure_pins {
>>>>> +		pinctrl-single,pins = <
>>>>> +			OMAP5_IOPAD(0x180, PIN_OUTPUT | MUX_MODE1) /* gpio8_234.sys_drm_msecure */
>>
>> I wonder now what MODE1 is.
>>
>> In my OMAP5 TRM (Version "Y" - may be too old) the MODE1 is tagged as "reserved".
>>
>> Maybe "reserved" happens to output a "1" on OMAP5 and a "0" on the X15?
>>
>> And as far as I am aware there is no "driver" for some MSECURE module (but I don't know the details of MSECURE control by software).
> 
> 
> Good catch. This one is interesting. If my memory serves me right,
> MSECURE signal from SoC is triggered in secure mode (trustzone) - the
> requirement was that certain PMIC modifications should only be done in
> secure mode for certain product applications. What this means is that
> certain functions of the PMIC will be unavailable when the SoC is
> running in "untrusted" mode.
> 
> Instead, the usual mode of operation is to set it up as GPIO (as Nikolas
> pointed below) and either use GPIO HOG or default weak pull to keep it
> in the required state.
> 
> I think it is better to set it as GPIO than as DRM_MSECURE.
> 
> This is probably also the reason why this mode is NOT in public TRM -
> all security related topics are probably in the NDA only secure TRM
> addendum.
> 
> 
> I'd suggest setting up a GPIO hog and a mux to GPIO for board-common (we
> are not doing any HS OMAP5 at least in public domain :) ).

Yeah. As I remember the same issue was with OMAP4 (twl6030_omap4.dtsi)
and, again if i remember correctly, someone reported that sys_drm_msecure might have different values
on different SoCs. Also I'd like to note that on Old non-DT kernel such functionality
was always modeled using GPIO.
 

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
