From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/17] ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible
 string for USB2 PHY2
Date: Wed, 24 Jun 2015 18:40:31 +0530
Message-ID: <558AAC47.2070305@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>	<1435060743-5511-12-git-send-email-kishon@ti.com> <20150624150750.9435096c85253cfe528ebbc3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150624150750.9435096c85253cfe528ebbc3-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 24 June 2015 05:37 PM, Roger Quadros wrote:
> On Tue, 23 Jun 2015 17:28:56 +0530
> Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> 
>> The USB2 PHY2 has a different register map compared to USB2 PHY1
>> to power on/off the PHY. In order to handle it, use the new compatible
>> string "ti,dra7x-usb2-phy2" for the second instance of USB2 PHY.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index f69db70..a8ee829 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -1235,7 +1235,7 @@
>>  			};
>>  
>>  			usb2_phy2: phy@4a085000 {
>> -				compatible = "ti,omap-usb2";
>> +				compatible = "ti,dra7x-usb2-phy2", "ti,omap-usb2";
> 
> Why do you want to retain "ti,omap-usb2".
> It is not backward compatible with it right?

The newer dtbs will anyway have "ti,dra7x-usb2-phy2", so "ti,omap-usb2" was
kept just for legacy reasons.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
