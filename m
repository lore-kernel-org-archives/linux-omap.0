From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/8] OMAP PM: create a PM layer plugin for per-device constraints
Date: Wed, 04 May 2011 07:36:58 -0700
Message-ID: <87vcxqv8fp.fsf@ti.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
	<1304516117-9334-2-git-send-email-j-pihet@ti.com>
	<20110504135930.GE2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42112 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754168Ab1EDOhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 10:37:02 -0400
Received: by mail-px0-f176.google.com with SMTP id 11so842359pxi.35
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 07:37:01 -0700 (PDT)
In-Reply-To: <20110504135930.GE2092@atomide.com> (Tony Lindgren's message of
	"Wed, 4 May 2011 06:59:30 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

Tony,

Tony Lindgren <tony@atomide.com> writes:

> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [110504 06:32]:
>>
>> +int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> ...
>
>> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
> ...
>
>> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
> ...
>
> You should implement this as a Linux generic framework, we don't
> want to add more omap specific frameworks.

This series isn't adding any new OMAP-specific frameworks.  The OMAP PM
layer is already in place, and has been there for awhile.  OMAP PM is a
layer which can have "plugins" so we can experiment with ways of
handling constraints without changing the driver interface, and this
series is just implementing a new plugin.

Once we are happy with a constraint layer, and can prove it will work,
the plan is to get rid of the (existing) OMAP-specific APIs and propose
a generic interface.

Kevin
