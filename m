From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] drm/omap: use omapdss low level API
Date: Fri, 16 Nov 2012 12:23:04 +0530
Message-ID: <50A5E2D0.3050406@ti.com>
References: <1353024058-11504-1-git-send-email-robdclark@gmail.com> <50A5E0BF.1010403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59673 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab2KPGxb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 01:53:31 -0500
In-Reply-To: <50A5E0BF.1010403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Archit Taneja <archit@ti.com>, dri-devel@lists.freedesktop.org, patches@linaro.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg KH <greg@kroah.com>

On Friday 16 November 2012 12:14 PM, Archit Taneja wrote:
> On Friday 16 November 2012 05:30 AM, Rob Clark wrote:
      if (!obj)
>> @@ -565,14 +344,6 @@ static int dev_load(struct drm_device *dev,
>> unsigned long flags)
>>
>>       dev->dev_private = priv;
>>
>> -    ret = omapdss_compat_init();
>> -    if (ret) {
>> -        dev_err(dev->dev, "coult not init omapdss\n");
>> -        dev->dev_private = NULL;
>> -        kfree(priv);
>> -        return ret;
>> -    }
>> -
>
> How can omapdss_compat_init/ininit already exist in the driver, and
> removed in this patch?

Had a look at Tomi's series, please ignore this one.

Archit

