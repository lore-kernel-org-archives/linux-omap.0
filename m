From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 09/23] OMAPDSS: Create links between managers, outputs
 and devices
Date: Fri, 31 Aug 2012 19:54:07 +0530
Message-ID: <5040C907.5090000@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-10-git-send-email-archit@ti.com> <1346422242.7508.18.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60288 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab2HaOXx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:23:53 -0400
In-Reply-To: <1346422242.7508.18.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 07:40 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> Links between DSS entities are made in dss_recheck_connections when a new panel
>> is probed. Rewrite the code in dss_recheck_connections to link managers to
>> outputs, and outputs to devices.
>>
>> The fields in omap_dss_device struct gives information on which output and
>> manager to connect to. The desired manager and output pointers are retrieved and
>> prepared(existing outputs/devices unset, if default display)) to form the
>> desired links. The output is linked to the device, and then the manager to the
>> output. If a probed device's required manager isn't free, the required output
>> is still connected to the device so that it's easier to use the panel in the
>> future.
>
> I've been pondering this one, and I can't come to a conclusion. The
> recheck_connections is just so ugly that I'd like to get rid of it =). I
> guess this patch doesn't make it any more ugly, so we can include it in
> the patch series.
>
> And as I mentioned earlier, I think we should get rid of the
> OMAP_DISPLAY_TYPE_* enum, as it's kinda extra now. But doing that would
> require changing all board files. That's not out of the question, but I
> think we should first make sure we know what we are doing with the board
> files so we don't go back and forth there.

Yes, I didn't remove it for the same reason.

>
> Just gathering my thoughts:
>
> When we define a panel in DT/board file, we should also define the
> output instance, because that's part of the hardware design. But there

It's a part of hardware design if the panel can't be detached. But yes, 
even for detachable panels, we can assume that the panel would 
eventually connect to that output.

> are no hardcoded links between mgrs and outputs, so that doesn't belong
> to the DT/board file. For example, omap4460's DSI1 can take input from
> LCD1 or LCD2.

Right, so we don't need an equivalent of the dssdev->channel field in DT 
info. As you said, we need the output instance, is that why you were 
sceptical about it being defined as an enum in previous patches? 
Probably we could define output instances in DT as a pair of instance 
number and instance type {number, type}. It would be sort of hard to 
play around with those within OMAPDSS though.

>
> So who could/should make the decision which mgr to use... Well, I don't
> know on what basis the decision can be made, but I still think omapdss
> can't make good decisions on that, so probably the whole "chain" should
> be configured in the omapfb/omapdrm level.

Which manager to chose could be simply picking up the next free manager 
which can connect to that output. omapfb/drm can take care of that.

Archit

