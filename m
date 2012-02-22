From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: DSS: Add runtime_pm protection around wait_for_vsync.
Date: Wed, 22 Feb 2012 11:15:01 +0530
Message-ID: <4F4480DD.1000502@ti.com>
References: <1329833192-16529-1-git-send-email-archit@ti.com>  <1329833192-16529-4-git-send-email-archit@ti.com> <1329840498.2090.36.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab2BVFpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 00:45:12 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1M5jB6F032719
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 23:45:11 -0600
In-Reply-To: <1329840498.2090.36.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lajos@ti.com, linux-omap@vger.kernel.org

On Tuesday 21 February 2012 09:38 PM, Tomi Valkeinen wrote:
> On Tue, 2012-02-21 at 19:36 +0530, Archit Taneja wrote:
>> From: Lajos Molnar<lajos@ti.com>
>>
>> If DSS is suspended during a wait_for_vsync operation, it may loose its clock.
>> Request runtime_pm around wait_for_vsync.
>>
>> Signed-off-by: Lajos Molnar<lajos@ti.com>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dispc.c |   16 +++++++++++-----
>>   1 files changed, 11 insertions(+), 5 deletions(-)
>
> This only handles omap_dispc_wait_for_irq_interruptible_timeout(),
> there's also omap_dispc_wait_for_irq_timeout().
>
> However, I think it'd be better to do the runtime_get/put in the caller,
> instead of in these dispc's wait funcs. While it doesn't really matter
> with dss_mgr_wait_for_vsync(), for dss_mgr/ovl_wait_for_go() it makes
> much more sense to get/put there just once, instead of every time the
> omap_dispc_wait_* is called.

Right, that makes sense. Btw, in the current code, how do we ensure that 
clocks are enabled when someone calls omap_dss_mgr_apply().

Archit

>
>   Tomi
>

