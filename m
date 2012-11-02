From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Fri, 2 Nov 2012 17:26:35 +0530
Message-ID: <5093B4F3.1000703@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com> <5093AE79.9010603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab2KBL4x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 07:56:53 -0400
In-Reply-To: <5093AE79.9010603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Friday 02 November 2012 04:58 PM, Tomi Valkeinen wrote:
> On 2012-11-02 13:09, Archit Taneja wrote:
>> On Friday 02 November 2012 04:19 PM, Tomi Valkeinen wrote:
>>> On 2012-11-02 12:44, Archit Taneja wrote:
>>>
>>>> Hmm, that makes sense. Anyway, I don't think it's really bad if we refer
>>>> to dssdev->channel for now.
>>>
>>> It is, because dssdev->channel doesn't exist with DT.
>>>
>>> With DT we either need to figure out the channel in omapdss at runtime,
>>> or add a property to the DT data telling the channel. And adding such a
>>> property is not correct, as DT should be about describing the HW.
>>
>> Ok.
>>
>> I don't totally agree with your idea of figuring out the manager in
>> panel the panel's probe. If it's done in the panel driver's probe
>> itself, then by this point of time we have already set
>> mgr->output->device links. If omapdss only does this stuff, then
>
> Hmm, I'm not sure I understand what's your point above? If figuring out
> the mgr is done in panel's probe, the mgr->output link is not yet made
> before that time.

My point is that we are trying to find a manager at panel's probe 
itself. It think that's what we do now. But one of your recent patch 
moves that to omapfb.

>
>> omapfb/omapdrm have just the job of connecting the overlays to the
>> manager. Do you think that's okay?
>
> Yes, that's how I think it should be. I don't see why omapfb/omapdrm
> should care about which manager is being used for the output, it doesn't
> really matter as long there is one and it works.
>
> Then again, I don't have anything against omapfb/omapdrm choosing the
> manager, but I don't see how they would have any better idea of which
> manager to use than omapdss.
>
> But as doing the connections at probe time is a bit problematic, perhaps
> we should have a new step in this whole sequence. Something like
> "connect" or whatever, which would lock the required blocks in the whole
> pipeline, and acquire the required resources that couldn't be gotten at
> probe time.
>
> But even then, choosing the manager is not easy, as whoever chooses the
> manager needs to observe all the possible displays used at the same time...

Right. I was wondering if omapfb/omapdrm could understand the 'all 
possible displays information' better compared to a panel's probe.

Even omapdrm/omafb can't be perfect because we could insert a panel 
driver module at any time, and omapfb/omapdrm may miss that out.

Archit

