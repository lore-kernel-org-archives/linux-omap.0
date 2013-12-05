From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 04/10] usb: dwc3: use quirks to know if a particualr
 platform doesn't have PHY
Date: Thu, 5 Dec 2013 12:04:46 +0530
Message-ID: <52A01E86.50406@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com> <1385373690-12170-5-git-send-email-kishon@ti.com> <20131204144027.GB21055@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131204144027.GB21055@xps8300>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 04 December 2013 08:10 PM, Heikki Krogerus wrote:
> Hi guys,
> 
> Kishon, sorry I did not see this v3 set.
> 
> On Mon, Nov 25, 2013 at 03:31:24PM +0530, Kishon Vijay Abraham I wrote:
>> There can be systems which does not have an external phy, so get
>> phy only if no quirks are added that indicates the PHY is not present.
>> Introduced two quirk flags to indicate the *absence* of usb2 phy and
>> usb3 phy. Also remove checking if return value is -ENXIO since it's now
>> changed to always enable usb_phy layer.
> 
> Can you guys explain why is something like this needed? Like with
> clocks and gpios, the device drivers shouldn't need to care any more
> if the platform has the phys or not. -ENODEV tells you your platform

Shouldn't we report if a particular platform needs a PHY and not able to get
it. How will a user know if a particular controller is not working because it's
not able to get and initialize the PHYs? Don't you think in such cases it's
better to fail (and return from probe) because the controller will not work
anyway without the PHY?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
