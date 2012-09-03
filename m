From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 09/23] OMAPDSS: Create links between managers, outputs
 and devices
Date: Mon, 3 Sep 2012 14:56:37 +0530
Message-ID: <504477CD.10901@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-10-git-send-email-archit@ti.com>  <1346422242.7508.18.camel@lappyti> <5040C907.5090000@ti.com>  <1346424344.16067.39.camel@deskari> <1346425698.16067.52.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35228 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756186Ab2ICJ0Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 05:26:25 -0400
In-Reply-To: <1346425698.16067.52.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 08:38 PM, Tomi Valkeinen wrote:
> On Fri, 2012-08-31 at 17:45 +0300, Tomi Valkeinen wrote:
>
>> So I'm not really against having the enum. It just would've been neat to
>> have the output type and instance number encoded into this enum, so that
>> it'd be easy to extract either one. But that kinda ruins the possibility
>> to use it in a bit mask.
>
> Hmm, this is just a non-finished idea (and it's late Friday... =) that
> came to my mind:
>
> I had a brief look at TRMs for different OMAPs (omap4/5/6), and it looks
> like the maximum output options for one manager is 4 (LCD2 on omap4460).
> Usually there are just 2 or 3.
>
> So, we could trust that the above holds and do this so that we use a u32
> field to hold four 8 bit output options. In 8 bits we can combine two
> values from 0 to 15. 15 should be more than enough for output display
> types and output instances.
>
> Then with helpers like these:
>
> /* second DSI instance */
> #define DSI1 ((1 << 4) | DISPLAY_TYPE_DSI)
> /* first DPI instance */
> #define DPI0 ((0 << 4) | DISPLAY_TYPE_DPI)

Okay, so DISPLAY_TYPE_DSI / DPI can't be a number left shifted any 
more(that would limit us to have only 4 types of output display types), 
like we have right now, they would need to be 0, 1, 2, 3 and so on. So 
with this approach, we could extract the instance number quickly, but we 
may not be able to check if the manager supports the output display type 
in constant time.

>
> an example output options for a manager that can be connected to DSI1
> and DPI0 could be:
>
> (DSI1 << 8) | (DPI0)
>
> This could be parsed with a for loop, going though the 4 bytes of the
> u32 value. This would allow us to avoid managing a real list, and we
> could extract the instance and the type from the value. Of course we
> could also extend the field to u64 to hold 8 outputs if need be.

Probably we could have a u64, and 2 bytes for each output, and a bit 
mask for both output instance and output display type. We could have 
display type enums as:

DISPLAY_TYPE_DPI	1 << 5
DISPLAY_TYPE_DSI	1 << 6
DISPLAY_TYPE_VENC	1 << 7
DISPLAY_TYPE_HDMI	1 << 8
DISPLAY_TYPE_SDI	1 << 9
DISPLAY_TYPE_RFBI	1 << 10
...

>
> Whether this would be worth it compared to simple bitmask, I'm not sure
> =). Depends how much we need to extract the ID and type.

Anyway, I don't think I'll try to implement this in this series. I'll 
stick to the output instance enums for now.

Archit

