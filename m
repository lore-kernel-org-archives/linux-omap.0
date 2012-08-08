From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in driver
 data
Date: Wed, 8 Aug 2012 11:59:15 +0530
Message-ID: <5022073B.6070109@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>   <1343817088-29645-9-git-send-email-archit@ti.com>  <1344348462.7216.77.camel@lappyti> <5021FFDC.6080006@ti.com> <1344406508.17575.12.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52748 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126Ab2HHGal (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 02:30:41 -0400
In-Reply-To: <1344406508.17575.12.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Wednesday 08 August 2012 11:45 AM, Tomi Valkeinen wrote:
> On Wed, 2012-08-08 at 11:27 +0530, Archit Taneja wrote:
>
>> I am a bit unclear about resolution when it comes to command mode panels.
>
> Right, it's a bit confusing. And I'm not 100% sure how to manage the
> rotation.
>
>> For command mode panels, we can perform rotation at the panel side. That
>> is, the panel refreshes itself by fetching pixels from it's buffer in a
>> rotated way. Is that right?
>
> Yes. Well, actually I think the panel stores the pixels in rotated
> manner when it receives them from OMAP, but it's practically the same.
>
> One thing to realize is that this kind of rotation is a bit limited:
> because there's only one buffer, OMAP will write pixels to the buffers
> at the same time as the panel shows them. When rotating, this leads to
> tearing.
>
> If the panel has double buffer, that solves the problem, but I haven't
> seen such panels. Another option is to update the panel in two parts,
> like N9 does, but that's timing sensitive and a bit tricky.
>
>> If the original resolution is 864x480, and we set rotation at panel side
>> to make the rotation 480x864, the DISPC manager size should also be
>> configured at 480x864 right?
>
> Yep. When we use the panel rotation, from OMAP's point of view the panel
> resolution has changed.
>
>> We seem to be setting the manager timings only once when DSI is enabled.
>> After that, setting rotation doesn't impact manager size.
>
> Hmm, previously the mgr size was set before each update. I wonder if
> that code has been dropped, probably because we removed the support for
> partial updates at one point. Without partial updates, the size stays
> the same, except obviously with rotation. I think I just forgot about
> rotation at that time.

I tried out rotation on Taal, and it only works for 180 degrees(and 0 of 
course), 90 and 270 result in no output. I'll add a 
dss_mgr_set_timings() in omap_dsi_update, that should sort of fix it, 
but someone would need to reconfigure the connected overlays too before 
trying out an update.

>
>> I am asking this to understand if we need to keep resolution as a
>> separate parameter than timings. That is, timings represents the initial
>> width and height of the panel, and resolution represents the current
>> width and height of the panel.
>
> I'm not sure. I think that OMAP doesn't really need to know about the
> initial resolution. It doesn't really matter from OMAP's point of view.
>
> I think I originally kept timings and resolution separately, and the
> idea was that timings represent the panel's timings, i.e. how it updates
> the screen from its own memory. And resolution represents the usable
> resolution, from OMAP's point of view.
>
> While I haven't seen such a cmd mode panel, there could be a command
> sent to the panel to configure its timings. For this we need real
> timings, not the rotated resolution.
>
> However, even in that case the DISPC doesn't need to know about those
> timings, they would be handled by the panel driver (which could,
> perhaps, reconfigure the DSI bus speed to match the new timings). So I
> think that inside omapdss, we don't need separate timings and resolution
> for DSI cmd mode panels.

Ok.

Archit
