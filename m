From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 0/4] Motorola Droid 4: Add WL1285C support
Date: Wed, 3 May 2017 17:02:13 +0200
Message-ID: <F455FC62-BA1C-4A59-B526-DDB90362CFE8@holtmann.org>
References: <20170503142226.32380-1-sebastian.reichel@collabora.co.uk>
 <CAL_JsqKktwFmxXijB0FVVoWGkswXm3twzD7She7zGR=rVQ4hWA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKktwFmxXijB0FVVoWGkswXm3twzD7She7zGR=rVQ4hWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

>> Motorola Droid 4 uses a WL1285C, as visible on iFixit [0]. This
>> fixes the DT file to use correct compatible for the wifi node
>> and adds the bluetooth node.
>> 
>> [0] https://www.ifixit.com/Teardown/Motorola+Droid+4+Teardown/7759#s31961
>> 
>> Changes to PATCHv1:
>> - use proper compatible value for bluetooth / shared transport
>> - add patches fixing wlcore compatible for Droid 4
>> 
>> -- Sebastian
>> 
>> Sebastian Reichel (4):
>>  wlcore: add wl1285 compatible
>>  ARM: dts: omap4-droid4: Use wl1285 for wifi compatible
>>  Bluetooth: hci_ll: Add compatible values for more WL chips
>>  ARM: dts: omap4-droid4: Add bluetooth
> 
> For the series,
> 
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

so now the question is if we merge this through a single maintainer or have each maintainer take the pieces? I would almost suggest that Dave Miller takes this directly into net-next to make this smoother.

Regards

Marcel
