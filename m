From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 08/21] OMAPDSS: clean up the omapdss platform data mess
Date: Thu, 8 Mar 2012 14:24:10 +0530
Message-ID: <4F5873B2.50806@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>  <1331124290-6285-9-git-send-email-tomi.valkeinen@ti.com>  <4F57A4E5.6070201@ti.com> <1331193777.2354.21.camel@deskari>  <4F586B28.1050403@ti.com> <1331195632.2354.37.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33469 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab2CHIy2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 03:54:28 -0500
In-Reply-To: <1331195632.2354.37.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 08 March 2012 02:03 PM, Tomi Valkeinen wrote:
> On Thu, 2012-03-08 at 13:47 +0530, Archit Taneja wrote:
>> On Thursday 08 March 2012 01:32 PM, Tomi Valkeinen wrote:
>
>>>> why do we check board_data being NULL here and not in omap_display_init()?
>>>
>>> I added it for DT case, because then we don't have board_data for the
>>> devices defined in the DT data. However, for now we always have the
>>> board_data, and in this patch I should just move the code. So I'll
>>> remove the check, and add it later with DT code if needed.
>>
>> Ok. When DT will be in use, would omap_display_init() be called or not?
>
> No. Currently the board files create and fill the board_data, and then
> call omap_display_init.
>
> With DT, the DT data will contain all the dynamic, per-board
> information. Something like:
>
> dss {
> 	dpi {
> 		dvi {
> 			pd-gpio =<10>;
> 			...
> 		};
> 	};
>
> 	dsi@1 {
> 		taal {
> 			reset-gpio =<20>;
> 			...
> 		};
> 	}
>
> 	...
> };
>
> The DT data will be passed individually to each dss driver (i.e. dsi
> driver will get its DT node, etc.). The drivers will read the data, and
> initialize themselves with that, more or less the same manner they'd do
> with the board_data from board files.
>
> However, we currently have this "omapdss" device, which is not a hwmod
> device at all. In the long run I think the omapdss device should be
> removed, but for now we need it. And device has to be created in the
> arch code, the same way it's now created in omap_display_init().
>
> So with DT we need a new func, omap_display_init_dt() or such, which
> creates the omapdss device, and also creates a board_data which contains
> the ctx_loss etc function pointers. But the board data won't have any
> display data, those come directly from DT data.
>
> It's a bit messy solution, but it should allow us to have both DT and
> non-DT working at the same time, with quite minimal changes to the board
> files.

Okay, thanks for the clarification.

Archit

>
>   Tomi
>

