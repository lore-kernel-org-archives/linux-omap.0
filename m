From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 12/15] ARM: dts: omap5: add ocp2scp1 address resource
Date: Fri, 20 Sep 2013 12:22:04 +0300
Message-ID: <523C13BC.10400@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379597019-15294-1-git-send-email-rogerq@ti.com> <523B0782.7050501@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523B0782.7050501-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/19/2013 05:17 PM, Sergei Shtylyov wrote:
> On 09/19/2013 05:23 PM, Roger Quadros wrote:
> 
>> Add OCP2SCP1 module address space.
> 
>> CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/omap5.dtsi |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
> 
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 06aa665..8a88a94 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -663,6 +663,7 @@
>>               #size-cells = <1>;
>>               ranges;
>>               ti,hwmods = "ocp2scp1";
>> +            reg = <0x4a080000 0x1f>;
> 
>    Are you sure length is not 0x20?

Actually there are just 4 of 32-bit registers with the last one
starting at 0x18, so I think length should be 0x1c.

I copied 0x1f from omap4.dtsi. Looks like that is wrong as well.
But it is harmless as nobody else is using that address.

I'll fix this to 0x1c in next rev.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
