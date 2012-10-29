From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DISPC: remove dssdev depependency from
 error handler
Date: Mon, 29 Oct 2012 15:48:30 +0530
Message-ID: <508E57F6.4070207@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com> <508E2C48.6020008@ti.com> <508E389C.8080503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56004 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab2J2KSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 06:18:45 -0400
In-Reply-To: <508E389C.8080503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 29 October 2012 01:34 PM, Tomi Valkeinen wrote:
> On 2012-10-29 09:12, Archit Taneja wrote:
>> Hi,
>>
>> On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
>>> The dispc error handler tries to "fix" issues by disabling and enabling
>>> panel. This is problematic, as we're trying to remove the dependency
>>> from omapdss to the omap_dss_devices. It's also racy, and doesn't really
>>> fix anything.
>>>
>>> This patch removes the use of omap_dss_device from the error handler,
>>> and just disables and enables the associated overlay manager. This
>>> should produce similar results as the previous solution, without using
>>> dssdev.
>>
>> Calling APPLY functions from the DISPC driver seems a bit incorrect.
>> Instead of disabling/enabling the panel, can't we disable/enable the
>> manger by just using DISPC funcs?
>
> I agree, but if we don't call apply functions, we're bypassing the
> locks/etc from apply, and we could end up messing up what apply.c thinks
> is going on.
>
> With my omapdss+omapdrm compatibility patch series I'm moving the error
> handler to the apply mechanism, so it becomes a bit saner.

Okay. Having the error handler in apply would make things better.

Archit
