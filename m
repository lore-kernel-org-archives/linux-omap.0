From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Fri, 2 Nov 2012 16:39:28 +0530
Message-ID: <5093A9E8.70106@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762395Ab2KBLJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 07:09:45 -0400
In-Reply-To: <5093A530.5050302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Friday 02 November 2012 04:19 PM, Tomi Valkeinen wrote:
> On 2012-11-02 12:44, Archit Taneja wrote:
>
>> Hmm, that makes sense. Anyway, I don't think it's really bad if we refer
>> to dssdev->channel for now.
>
> It is, because dssdev->channel doesn't exist with DT.
>
> With DT we either need to figure out the channel in omapdss at runtime,
> or add a property to the DT data telling the channel. And adding such a
> property is not correct, as DT should be about describing the HW.

Ok.

I don't totally agree with your idea of figuring out the manager in 
panel the panel's probe. If it's done in the panel driver's probe 
itself, then by this point of time we have already set 
mgr->output->device links. If omapdss only does this stuff, then 
omapfb/omapdrm have just the job of connecting the overlays to the 
manager. Do you think that's okay?

Archit

