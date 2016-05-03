From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
Date: Tue, 3 May 2016 20:32:44 +0300
Message-ID: <5728E0BC.3080509@ti.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
 <1462209123-7332-3-git-send-email-Linux.HWI@garmin.com>
 <57285E66.2000708@ti.com> <5728A81F.4050906@garmin.com>
 <20160503164323.GN5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160503164323.GN5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "J.D. Schroeder" <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/05/16 19:43, Tony Lindgren wrote:
> * J.D. Schroeder <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org> [160503 06:32]:
>> On 05/03/2016 03:16 AM, Tero Kristo wrote:
>>> On 02/05/16 20:12, J.D. Schroeder wrote:
>>>> From: "J.D. Schroeder" <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> This commit updates the OSC_32K_CLK (secure_32k_clk_src_ck) frequency
>>>> from the precise 32kHz frequency (i.e., 32.768 kHz) to a more
>>>> accurate frequency of ~34.6 kHz. Actual measured frequencies of the
>>>> clock vary from processor to processor anywhere from 34.4 kHz up to
>>>> 34.8 kHz. Note that the ~34 kHz frequency clock is generated
>>>> internally by the processor, not an input to the processor. This
>>>> change makes it more clear that the consumer of the
>>>> secure_32k_clk_src_ck will not get a precise 32.768 kHz frequency
>>>> output.
>>>>
>>>> Signed-off-by: J.D. Schroeder <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
>>>> Reviewed-by: Trenton Andres <trenton.andres-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>    arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>>>> b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>>>> index 3f0c61d..f7ec976 100644
>>>> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>>>> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>>>> @@ -95,7 +95,7 @@
>>>>        secure_32k_clk_src_ck: secure_32k_clk_src_ck {
>>>>            #clock-cells = <0>;
>>>>            compatible = "fixed-clock";
>>>> -        clock-frequency = <32768>;
>>>> +        clock-frequency = <34600>; /* approximate frequency */
>>>>        };
>>>>
>>>>        sys_clk32_crystal_ck: sys_clk32_crystal_ck {
>>>>
>>>
>>> I still don't agree with this patch. The actual frequency can drift much more,
>>> you are just seeing this number at your setup.
>>
>> Yes, it can drift significantly from processor to processor. Do you agree that
>> this frequency is closer to what can be expected than 32768 Hz?
>>
>> Like I said, I would have renamed the clock also but I opted to go the less
>> obtrusive route while still helping others that might think they can
>> reasonably use this clock in their design as a 32768 Hz clock source. Perhaps
>> my comment and selection of the approximate frequency is not the best (I'm
>> open for suggestions). However, I do think this change is an improvement and
>> clarifying change to what is currently present in the clock description.
>
> Does a fixed divider calculation of input * (32768 / 0x27e6) make sense
> here too as pointed out earlier by Matthijs for the ti81xx?

Not really, the hardware setup for this clock is not like that. Also, as 
it is security related, this is kind of sensitive area to discuss 
publicly. Personally I would not recommend using this clock for any 
timing sensitive applications. May I ask why you are interested in the 
exact clock rate of this clock anyway?

-Tero

>
> Regards,
>
> Tony
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
