From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Update MUSB CPPI 4.1 driver to correctly manage
 the DA8xx
Date: Tue, 26 Sep 2017 15:49:50 +0530
Message-ID: <ea600e51-87aa-9362-c57f-3525b3968d80@ti.com>
References: <20170920192612.16169-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920192612.16169-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 21 September 2017 12:56 AM, Alexandre Bailon wrote:
> A couple of weeks ago, Sekhar reported a warning issue happening in
> CPPI 4.1. The teardown sequence was not correctly programmed.
> The caused was a couple of difference between the DSPS and the DA8xx.
> These differences are the way to program the autoreq, the teardown and
> the DMA mode.
> This series intends to fix the teardown and to correctly program
> the DMA mode.
> 
> This series has been roughly tested.
> I have only tried it on the DA580 LCK and the BeagleBone Black.
> Only the device mode (msc and ecm) have been tested.

Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Tested on DA850 LCDK using g_ether (module probe and removal) and
g_ether (fast ping traffic test).

It will be nice if this can go into v4.14-rc cycle as these are
important fixes for DA850 platform.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
