From: Afzal Mohammed <x0148406-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] usb: musb: dsps: fixes for -rc
Date: Fri, 2 Nov 2012 17:03:09 +0530
Message-ID: <5093AF75.5030206@ti.com>
References: <cover.1351691448.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1351691448.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Balbi,

On Wednesday 31 October 2012 07:54 PM, Afzal Mohammed wrote:

> This series contains a couple of fixes for musb dsps wrapper.
>
> First one restores capability to support at least one instance of musb.
> Without it, even a single instance can't be supported as change which
> is reverted by it was made along with multi phy changes and nop
> transciever dt support, both other changes didn't make it in during
> previous merge window.
>
> Second one corrects binding document; changes were made in driver as
> per review comments, but documentation was not updated.
>
> Please consider this series for inclusion in the next -rc cycle.

Can you please consider this series for inclusion in -rc cycle,
if you have any comments on this please let me know.

Regards
Afzal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
