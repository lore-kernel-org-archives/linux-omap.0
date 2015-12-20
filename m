From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 9/9] phy: omap-usb2: use *syscon* framework API to
 power on/off the PHY
Date: Sun, 20 Dec 2015 17:37:59 +0530
Message-ID: <56769A1F.3060607@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <1450170968-11282-10-git-send-email-kishon@ti.com>
 <20151220033901.GI9883@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151220033901.GI9883@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On Sunday 20 December 2015 09:09 AM, Rob Herring wrote:
> On Tue, Dec 15, 2015 at 02:46:08PM +0530, Kishon Vijay Abraham I wrote:
>> Deprecate using phy-omap-control driver to power on/off the PHY,
>> and use *syscon* framework to do the same. This handles
>> powering on/off the PHY for the USB2 PHYs used in various TI SoCs.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/phy/ti-phy.txt |    8 +-
>>  drivers/phy/phy-omap-usb2.c                      |   94 ++++++++++++++++++----
>>  include/linux/phy/omap_usb.h                     |   23 ++++++
>>  3 files changed, 107 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
>> index 49e5b0c..a3b3945 100644
>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
>> @@ -31,6 +31,8 @@ OMAP USB2 PHY
>>  
>>  Required properties:
>>   - compatible: Should be "ti,omap-usb2"
>> +	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
>> +	       in DRA7x
> 
> The 2nd instance is different somehow?

yeah, the bit fields are slightly different.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
