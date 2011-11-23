From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 42/65] OMAPDSS: DSI: call mgr_enable/disable for cmd mode
 displays
Date: Wed, 23 Nov 2011 16:38:58 +0530
Message-ID: <4ECCD44A.2070008@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>	 <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>	 <4ECCC68C.7070106@ti.com> <1322044977.28917.57.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34829 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab1KWLJ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 06:09:26 -0500
In-Reply-To: <1322044977.28917.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Wednesday 23 November 2011 04:12 PM, Tomi Valkeinen wrote:
> On Wed, 2011-11-23 at 15:40 +0530, Archit Taneja wrote:
>> On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
>>> The current code uses dsi_video_mode_enable/disable functions to
>>> enable/disable DISPC output for video mode displays. For command mode
>>> displays we have no notion in the DISPC side of whether the panel is
>>> enabled, except when a dss_start_update() call is made.
>>>
>>> However, to properly maintain the DISPC state in apply.c, we need to
>>> know if a manager used for a manual update display is currently in use.
>>>
>>> This patch achieves that by changing dsi_video_mode_enable/disable to
>>> dsi_enable/disable_video_output, which is called by both video and
>>> command mode displays. For video mode displays it starts the actual
>>> pixel stream, as it did before. For command mode displays it doesn't do
>>> anything else than mark that the manager is currently in use.
>>
>> dsi_video_mode_enable() doesn't only enable the DISPC output, it also
>> sends the long packet header to start video mode transfer.
>>
>> I think it would be better if we had 2 separate functions, one which
>> starts/stops DSI video mode, and the other which enables/disables the
>> DISPC video port.
>>
>> This way, a manual update panel would need to call only
>> dsi_enable/disable_video_output(which just enables or disables the
>> manager), whereas a video mode panel will need to call both.
>>
>> This is just a suggestion though. It's probably okay to have both in the
>> same function too. We might have to separate them out later if we were
>> planning to standardise mipi dsi across SoCs.
>
> If you think from the panel driver's point of view, it doesn't know
> about DISPC. It just wants to enable the video stream (on video mode
> displays).
>
> If we had two functions, could only the first be used? I.e. is it
> possible to just enable the video mode transfer, without enabling DISPC?
> If not, I'm not sure what would be the use for two separate functions.
> And even if it can, I'm not sure what use it would be to enable only the
> video mode output without the actual pixel data from DISPC.
>
> It is true that the function in thsi patch is not the best one. For
> command mode display it's more about reserving the ovl manager for use
> than actually enabling it. Then again, how I thought the function's
> purpose was that it enables the DSI video output, but because for
> command mode there's need to trigger the actual frame transfer later,
> the function doesn't start the pixel feed for command mode displays. It
> just "prepares" the output.
>
> But even if we had the functions separated, the function called by video
> mode and command mode displays would be different, as for the former one
> it enables the pixel stream, and for latter one it just reserves the
> output.
>
> So, I'm fine with changing the function, but the reasoning for what
> functions we have and what they do should come from the panel driver's
> perspective, not because of OMAP DSS's HW details.

If you look from the panel driver's perspective, we shouldn't split this.

I think it would be best to stuff the 'video mode enabling and manager 
enabling' functionality in omapdss_dsi_display_enable() itself, the 
panel driver shouldn't need to call a function separately to enable 
video mode for the panel. This way we would be more along the lines of 
the dpi driver, where dpi_display_enable() enables the manager in the end.

I guess we can leave this the way you are doing it currently, and move 
this code into dsi_display_enable() code later on.

Archit

>
>   Tomi
>

