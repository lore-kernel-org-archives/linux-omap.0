From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 9/9] phy: omap-usb2: use *syscon* framework API to
 power on/off the PHY
Date: Tue, 22 Dec 2015 12:19:14 -0600
Message-ID: <CAL_JsqKEfUihk6kO+_KukNPGz4ZwT4S6v+coYqL+ZdQHpe5WSg@mail.gmail.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <1450170968-11282-10-git-send-email-kishon@ti.com> <20151220033901.GI9883@rob-hp-laptop>
 <56769A1F.3060607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56769A1F.3060607-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 20, 2015 at 6:07 AM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Hi Rob,
>
> On Sunday 20 December 2015 09:09 AM, Rob Herring wrote:
>> On Tue, Dec 15, 2015 at 02:46:08PM +0530, Kishon Vijay Abraham I wrote:
>>> Deprecate using phy-omap-control driver to power on/off the PHY,
>>> and use *syscon* framework to do the same. This handles
>>> powering on/off the PHY for the USB2 PHYs used in various TI SoCs.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  Documentation/devicetree/bindings/phy/ti-phy.txt |    8 +-
>>>  drivers/phy/phy-omap-usb2.c                      |   94 ++++++++++++++++++----
>>>  include/linux/phy/omap_usb.h                     |   23 ++++++
>>>  3 files changed, 107 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> index 49e5b0c..a3b3945 100644
>>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> @@ -31,6 +31,8 @@ OMAP USB2 PHY
>>>
>>>  Required properties:
>>>   - compatible: Should be "ti,omap-usb2"
>>> +           Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
>>> +           in DRA7x
>>
>> The 2nd instance is different somehow?
>
> yeah, the bit fields are slightly different.

Okay,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
