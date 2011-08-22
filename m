From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 0/7] PM QoS: add a per-device latency constraints framework
Date: Mon, 22 Aug 2011 10:56:32 -0700
Message-ID: <87mxf1wcrz.fsf@ti.com>
References: <1313609965-6568-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:57228 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751174Ab1HVR4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 13:56:38 -0400
Received: by mail-yx0-f172.google.com with SMTP id 17so3338665yxj.17
        for <linux-omap@vger.kernel.org>; Mon, 22 Aug 2011 10:56:37 -0700 (PDT)
In-Reply-To: <1313609965-6568-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 17 Aug 2011 21:39:18 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> High level implementation:
>
> 1. Preparation of the PM QoS for the addition of a device PM QoS constraints
>    framework:
>   . rename and move of the PM QoS implementation files to kernel/power/qos.c
>     and include/linux/pm_qos.h
>   . rename of API parameters and internal fields names
>   . Move around the PM QoS misc devices management code for better readability
>   . re-organize the internal data structs
>   . generalize and export the constraints management core code
>
> 2. Implementation of the per-device PM QoS constraints:
>   . create drivers/base/power/qos.c for the implementation
>   . create a device PM QoS API, which calls the PM QoS constraints management
>     core code
>   . the per-device latency constraints data strctures are stored in the device
>     dev_pm_info struct
>   . the device PM code calls the init and destroy of the per-device constraints
>     data struct in order to support the dynamic insertion and removal of the
>     devices in the system.
>   . to minimize the data usage by the per-device constraints, the data struct
>     is only allocated at the first call to dev_pm_qos_add_request. The data
>     is later free'd when the device is removed from the system
>   . per-device notification callbacks can be registered and called upon a
>     change to the aggregated constraint value
>   . a global mutex protects the constraints users from the data being
>     allocated and free'd.
>
> 3. add a global notification mechanism for the device constraints
>   . add a global notification chain that gets called upon changes to the
>     aggregated constraint value for any device.
>   . the notification callbacks are passing the full constraint request data
>     in order for the callees to have access to it. The current use is for the
>     platform low-level code to access the target device of the constraint

Reviewed-by: Kevin Hilman <khilman@ti.com>

