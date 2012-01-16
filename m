From: Archit <a0393947@ti.com>
Subject: Re: [PATCH 5/6] OMAPDSS: DISPC: move fifo threhold calc to dispc.c
Date: Mon, 16 Jan 2012 15:29:43 +0530
Message-ID: <4F13F50F.9060705@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>	 <1326455193-19716-6-git-send-email-tomi.valkeinen@ti.com>	 <4F108D7A.4010802@ti.com> <1326707861.1875.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53507 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2APJ74 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 04:59:56 -0500
In-Reply-To: <1326707861.1875.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, rob@ti.com

On Monday 16 January 2012 03:27 PM, Tomi Valkeinen wrote:
> On Sat, 2012-01-14 at 01:30 +0530, Archit wrote:
>> Hi,
>>
>> On Friday 13 January 2012 05:16 PM, Tomi Valkeinen wrote:
>>> Move fifo threshold calculation into dispc.c, as the thresholds are
>>> really dispc internal thing.
>>>
>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>
>> <snip>
>>
>>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
>>> index 511ae2a..1cbb7a5 100644
>>> --- a/drivers/video/omap2/dss/dsi.c
>>> +++ b/drivers/video/omap2/dss/dsi.c
>>> @@ -4524,14 +4524,6 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
>>>    }
>>>    EXPORT_SYMBOL(omapdss_dsi_enable_te);
>>>
>>> -void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
>>> -		u32 fifo_size, u32 burst_size,
>>> -		u32 *fifo_low, u32 *fifo_high)
>>> -{
>>> -	*fifo_high = fifo_size - burst_size;
>>> -	*fifo_low = fifo_size - burst_size * 2;
>>> -}
>>
>> We are removing the special treatment for overlays connected to DSI done
>> before. Won't this cause the issues you saw with DSI in OMAP3?
>
> That's true. I had it in mind at some point, but I seem to have
> forgotten it.
>
> The problem with OMAP3, DSI and fifo thresholds was never cleared, and I
> haven't seen an errata about it, so there's a slim chance that it was
> only a problem with the particular setup.
>
> Are you back at the office yet? If I recall right, you had an OMAP3 DSI
> cmd mode board?

Not yet, I'll try it out when I get back.

>
> Anyway, I guess it's safest if I add a hack there, which tunes the
> thresholds a bit differently for OMAP3 DSI.

Yes, you could have that, we have to rewrite the whole threshold 
calculation later on anyway.

Archit

>
>   Tomi
>

