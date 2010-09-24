From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/9 v3] usb: musb: Using omap_device_build for musb
 device registration
Date: Fri, 24 Sep 2010 10:25:05 +0300
Message-ID: <20100924072505.GD8365@legolas.emea.dhcp.ti.com>
References: <1285201750-26438-1-git-send-email-hemahk@ti.com>
 <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
 <87bp7o5vru.fsf@deeprootsystems.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87bp7o5vru.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 23, 2010 at 10:23:17AM -0500, Kevin Hilman wrote:
>> could the omap_hwmod_lookup() part be moved to omap_device_build ? Or
>> maybe create a omap_hwmod_lookup_and_build(oh_name, dev_name, bus_id,
>> pdata, sizeof(*pdata)) ??
>
>I don't think that this is too much extra work.
>
>Also, many drivers are not doing a single hwmod lookup, they are using
>an iterator to iterate over a bunch of hwmods in a given class (c.f.
>omap_hwmod_for_each_by_class)
>
>So, IMO, keeping the lookup and build separate is better.
>
>> I think this is also a duplication, it's gonna on all hwmod device
>> registration, no ?
>
>Only for devices setting DMA masks.
>
>This is no more duplication than we have today for all platform_devices.

ok, agreed.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
