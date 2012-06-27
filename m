From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 05/17] OMAPDSS: Add some new fields to omap_video_timings
Date: Wed, 27 Jun 2012 17:56:42 +0530
Message-ID: <4FEAFC02.2070006@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>  <1340703414-1915-7-git-send-email-archit@ti.com> <1340797733.2649.48.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab2F0M1s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 08:27:48 -0400
In-Reply-To: <1340797733.2649.48.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Wednesday 27 June 2012 05:18 PM, Tomi Valkeinen wrote:
> On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
>> Some panel timing related fields are contained in omap_panel_config in the form
>> of flags. The fields are:
>>
>> - Hsync logic level
>> - Vsync logic level
>> - Data driven on rising/falling edge of pixel clock
>> - Output enable/Data enable logic level
>> - HSYNC/VSYNC driven on rising/falling edge of pixel clock
>>
>> Out of these parameters, Hsync and Vsync logic levels are a part of the timings
>> in the Xorg modeline configuration. So it makes sense to move the to
>> omap_video_timings. The rest aren't a part of modeline, but it still makes
>> sense to move these since they are related to panel timings.
>>
>> These fields stored in omap_panel_config in dssdev are configured for LCD
>> panels, and the corresponding LCD managers in the DISPC_POL_FREQo registers.
>>
>> Add the above fields in omap_video_timings. Represent their state via new enums.
>> The parameter pclk_edge is configured via omap_dss_signal_level, however it
>> actually configures whether data is driven on the rising or falling edge. This
>> is a bit unclean, but it prevents us from creating another enum.
>
> Hmm, why can't omap_dss_signal_edge be used for pclk_edge? I think it'd
> fit fine, except OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES would be an illegal
> value for it.

I think my paragraph is a bit misleading. The issue is more about the 
default value. For hsync_vsync_edge(which programs ONOFF and RF), the 
default value is OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES, and is the case for 
most panels. But for pclk_edge, the value for most panels is 
OMAPDSS_DRIVE_SIG_ACTIVE_HIGH.

So if I use the same enum for both, I'll need to populate either 
pclk_edge or hsync_vsync_edge for almost every panel. With my approach, 
I only need to populate these fields for panels having the non-default 
requirements. The negative thing is that it's a bit misleading to 
represent pclk_edge with the omap_dss_signal_level enum.

Archit

