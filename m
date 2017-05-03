From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 0/4] Motorola Droid 4: Add WL1285C support
Date: Wed, 3 May 2017 09:47:13 -0500
Message-ID: <CAL_JsqKktwFmxXijB0FVVoWGkswXm3twzD7She7zGR=rVQ4hWA@mail.gmail.com>
References: <20170503142226.32380-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170503142226.32380-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 3, 2017 at 9:22 AM, Sebastian Reichel
<sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
> Hi,
>
> Motorola Droid 4 uses a WL1285C, as visible on iFixit [0]. This
> fixes the DT file to use correct compatible for the wifi node
> and adds the bluetooth node.
>
> [0] https://www.ifixit.com/Teardown/Motorola+Droid+4+Teardown/7759#s31961
>
> Changes to PATCHv1:
>  - use proper compatible value for bluetooth / shared transport
>  - add patches fixing wlcore compatible for Droid 4
>
> -- Sebastian
>
> Sebastian Reichel (4):
>   wlcore: add wl1285 compatible
>   ARM: dts: omap4-droid4: Use wl1285 for wifi compatible
>   Bluetooth: hci_ll: Add compatible values for more WL chips
>   ARM: dts: omap4-droid4: Add bluetooth

For the series,

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
