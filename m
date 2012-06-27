From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 05/17] OMAPDSS: Add some new fields to omap_video_timings
Date: Wed, 27 Jun 2012 18:17:07 +0530
Message-ID: <4FEB00CB.4070502@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>   <1340703414-1915-7-git-send-email-archit@ti.com>  <1340797733.2649.48.camel@deskari> <4FEAFC02.2070006@ti.com> <1340800933.2649.72.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40346 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2F0MsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 08:48:13 -0400
In-Reply-To: <1340800933.2649.72.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Wednesday 27 June 2012 06:12 PM, Tomi Valkeinen wrote:
> On Wed, 2012-06-27 at 17:56 +0530, Archit Taneja wrote:
>> On Wednesday 27 June 2012 05:18 PM, Tomi Valkeinen wrote:
>>> On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
>>>> Some panel timing related fields are contained in omap_panel_config in the form
>>>> of flags. The fields are:
>>>>
>>>> - Hsync logic level
>>>> - Vsync logic level
>>>> - Data driven on rising/falling edge of pixel clock
>>>> - Output enable/Data enable logic level
>>>> - HSYNC/VSYNC driven on rising/falling edge of pixel clock
>>>>
>>>> Out of these parameters, Hsync and Vsync logic levels are a part of the timings
>>>> in the Xorg modeline configuration. So it makes sense to move the to
>>>> omap_video_timings. The rest aren't a part of modeline, but it still makes
>>>> sense to move these since they are related to panel timings.
>>>>
>>>> These fields stored in omap_panel_config in dssdev are configured for LCD
>>>> panels, and the corresponding LCD managers in the DISPC_POL_FREQo registers.
>>>>
>>>> Add the above fields in omap_video_timings. Represent their state via new enums.
>>>> The parameter pclk_edge is configured via omap_dss_signal_level, however it
>>>> actually configures whether data is driven on the rising or falling edge. This
>>>> is a bit unclean, but it prevents us from creating another enum.
>>>
>>> Hmm, why can't omap_dss_signal_edge be used for pclk_edge? I think it'd
>>> fit fine, except OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES would be an illegal
>>> value for it.
>>
>> I think my paragraph is a bit misleading. The issue is more about the
>> default value. For hsync_vsync_edge(which programs ONOFF and RF), the
>> default value is OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES, and is the case for
>> most panels. But for pclk_edge, the value for most panels is
>> OMAPDSS_DRIVE_SIG_ACTIVE_HIGH.
>>
>> So if I use the same enum for both, I'll need to populate either
>> pclk_edge or hsync_vsync_edge for almost every panel. With my approach,
>> I only need to populate these fields for panels having the non-default
>> requirements. The negative thing is that it's a bit misleading to
>> represent pclk_edge with the omap_dss_signal_level enum.
>
> Ah, I see.
>
> I really think using the ACTIVE_LOW/HIGH for pclk_edge is quite ugly =).
>
> Well, one option is to add new entry for the enums, "UNDEFINED" or
> perhaps "DEFAULT", which would have value 0. Then omapdss would know
> that it should use the default value, whatever that is.
>
> Another option is to have all panels define the pclk_edge, so that
> there's no default value needed.

I think I'll go with this.

>
> Also, related thing, I see you're writing enum values directly to the
> registers. If you do that, it'd be good to explicitly set the number
> value of the enums. Otherwise it's quite easy to add a new enum value
> later between the old ones, breaking everything (perhaps not a problem
> here, though).

Yes, that's true. I'll set the numbers anyway, for clarity.

Archit
