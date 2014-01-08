From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/4] ARM: dts: OMAP5: Add 60MHz clock reference to
 USB Host module
Date: Wed, 8 Jan 2014 11:15:01 +0530
Message-ID: <52CCE5DD.4040301@ti.com>
References: <1389096889-22179-1-git-send-email-rogerq@ti.com> <1389096889-22179-2-git-send-email-rogerq@ti.com> <201401071613.39245.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401071613.39245.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/07/2014 08:43 PM, Arnd Bergmann wrote:
> On Tuesday 07 January 2014, Roger Quadros wrote:
>> USB Host driver (drivers/mfd/omap-usb-host.c) expects the 60MHz
>> reference clock to be named "init_60m_fclk". Provide this
>> information.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/omap5.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 2f12a47..e0ab379 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -765,6 +765,8 @@
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>                         ranges;
>> +                       clocks = <&l3init_60m_fclk>;
>> +                       clock-names = "init_60m_fclk";
>>  
>>                         usbhsohci: ohci@4a064800 {
>>                                 compatible = "ti,ohci-omap3", "usb-ohci";
> 
> The bindings/mfd/omap-usb-host.txt file doesn't document any clocks.
> Please create another patch to document the clock names in this binding
> before you start putting them into the dtsi file. So far the clock
> names are an implementation detail of Linux as they are not part
> of the binding, and with your patch it becomes part of the ABI.
> 
Right. I'll re-post the series.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
