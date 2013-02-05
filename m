From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 08/13] USB: ehci-omap: Add device tree support and binding
 information
Date: Tue, 5 Feb 2013 14:46:40 +0200
Message-ID: <5110FF30.5050705@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-9-git-send-email-rogerq@ti.com> <20130205123346.GB26842@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130205123346.GB26842-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/05/2013 02:33 PM, Mark Rutland wrote:
> On Mon, Feb 04, 2013 at 03:58:55PM +0000, Roger Quadros wrote:
>> Allows the OMAP EHCI controller to be specified via device tree.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/usb/omap-ehci.txt          |   34 ++++++++++++++++++
>>  drivers/usb/host/ehci-omap.c                       |   36 +++++++++++++++++++-
>>  2 files changed, 69 insertions(+), 1 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/omap-ehci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap-ehci.txt b/Documentation/devicetree/bindings/usb/omap-ehci.txt
>> new file mode 100644
>> index 0000000..90e6e3a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/omap-ehci.txt
>> @@ -0,0 +1,34 @@
>> +OMAP HS USB EHCI controller
>> +
>> +This device is usually the child of the omap-usb-host
>> +Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>> +
>> +Required properties:
>> +
>> +- compatible: should be "ti,omap-ehci"
>> +- reg: should contain one register range i.e. start and length
>> +- interrupt-parent: phandle to the interrupt controller
>> +- interrupts: description of the interrupt line
>> +
>> +Optional properties:
>> +
>> +- phy: list of phandles to PHY nodes.
>> +  This property is required if at least one of the ports are in
>> +  PHY mode i.e. OMAP_EHCI_PORT_MODE_PHY
> 
> Any reason for not calling this "phys", given it's a list?
>

No good reason. "phys" seems more appropriate. Thanks.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
