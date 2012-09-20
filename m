From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB
Date: Thu, 20 Sep 2012 05:21:15 +0200
Message-ID: <505A8BAB.2020004@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348047128-25692-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 09/19/2012 11:32 AM, Kishon Vijay Abraham I wrote:
> This patch series adds dt data to get MUSB working in omap4 and omap3
> 
> Changes from v2:
> * Changes the subject of all the patches to include "ARM: dts:"
> * Added reg property and interrupt property for "usb_otg_hs". Previously these
>   were obtained from ti,hwmods property.
> * Rebased on
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git devel-dt
> 
> Changes from v1:
> Just removed the omap-usb2 dt data and sent that as a separate patch.
> 
> Kishon Vijay Abraham I (3):
>   ARM: dts: Add twl6030-usb data
>   ARM: dts: Add twl4030-usb data
>   ARM: dts: omap: Add usb_otg and glue data

Thanks for the update. I've just pulled the series for 3.7.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
