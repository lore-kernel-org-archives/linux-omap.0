From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/5] arm: dts: complete dm816x device tree
Date: Fri, 13 Nov 2015 10:29:17 +0100
Message-ID: <5645AD6D.8010706@baylibre.com>
References: <56449D1D.4030803@baylibre.com>
 <20151112174706.GN3218@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151112174706.GN3218-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/12/2015 06:47 PM, Tony Lindgren wrote:
> * Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [151112 06:08]:
>> In order to fix support for the dm816x platform, add missing bits in
>> the dm816x dtsi and cleanup OCP.
> 
> Which ones are needed as fixes for the v4.4-rc kernel?
> 
> Regards,
> 
> Tony
> 
>> The last patch adds support for the omap4-hwspinlock.
>>
>> v2: add ocp hwmod cleanup
>>
>> Neil Armstrong (5):
>>   arm: dts: add dm816x missing #mbox-cells
>>   arm: dts: add dm816x missing spi DT dma handles
Tony,

The two first are fixes for v4.4-rc.

>>   arm: dts: add dm816x pwm property to timers
>>   arm: dts: remove dm816x invalid DT l3_main hwmod
>>   arm: dts: Add omap4-hwspinlock support in dm816x

the 3 following can wait.

>>
>>  arch/arm/boot/dts/dm816x.dtsi | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> -- 
>> 1.9.1

Thanks,
Neil
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
