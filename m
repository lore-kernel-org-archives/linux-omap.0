From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 15:08:06 +0530
Message-ID: <5232DCFE.5050700@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41497 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab3IMJjB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 05:39:01 -0400
In-Reply-To: <5232D9C8.9020809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, devicetree@vger.kernel.org, Andy Gross <andygro@gmail.com>

On Friday 13 September 2013 02:54 PM, Tomi Valkeinen wrote:
> On 13/09/13 12:14, Archit Taneja wrote:
>> Move omapdrm device creation inside the omap_display_init so that we can
>> correctly create the device based on the presence of omapdss.
>>
>> Originally worked on by Andy Gross.
>
> If the dmm device is present in the DT data, there is no need to create
> the dmm device. It's created automatically.

Yes, that is done in a later patch.

>
> Also, omapfb device is currently created the same way as omapdrm,
> independently of omapdss. Why is it a problem to have them like that?

In a multiplatform config, we might have CONFIG_DRM_OMAP and 
CONFIG_DRM_OMAP_MODULE selected.

This would cause the call omap_init_drm() in arch/arm/mach-omap2/drm.c 
to occur. Creating a platform device for omapdrm is unnecessary here 
isn't it? Tying it with the initialisation of omapdss devices prevents it.

Archit
