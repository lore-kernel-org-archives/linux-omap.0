From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Fri, 20 Sep 2013 15:48:04 +0530
Message-ID: <523C20DC.2090100@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <523C02C8.30207@ti.com> <523C0BFE.5010409@ti.com> <523C0D6E.30701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35688 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166Ab3ITKS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Sep 2013 06:18:57 -0400
In-Reply-To: <523C0D6E.30701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org

On Friday 20 September 2013 02:25 PM, Tomi Valkeinen wrote:
> On 20/09/13 11:49, Archit Taneja wrote:
>
>> I suppose we would hit this case if all of the displays are deferred
>> because of some dependency and are probed after omapdrm probes.
>>
>> Is that the case with beagle-xm?
>
> Yes, DVI is probed after omapdrm. There's also analog TV out on beagle.
> I'm not sure why that wasn't ready earlier, or was it available at all.
> I didn't study it further.
>
> If the analog tv would've been available, omapdrm would have started
> with only tv out, and DVI would have been left out. So it's still not
> perfect.

Right, I suppose omapdrm should be probed only after all the dssdevs are 
probed. That's a bit tough to do.

>
>> I think we need to move this from pdev_probe() anyway. I don't see other
>> drivers doing much in pdev_probe(), they do most of their stuff in
>> dev_load() itself. I'll try with that along with disabling of the
>> dssdevs in encoder's destroy.
>
> Ok. The dssdevs are disabled in omap_connector already, though.

I couldn't find where it is disabled in omap_connector. The only 
function which calls dssdrv->disable is omap_connector_set_enabled(). 
That doesn't seem to be called in omap_connector.

Archit


