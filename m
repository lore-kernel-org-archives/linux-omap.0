From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Issue: Runtime API usage in wake-up device irq_handler during wakeup from system-wide-suspend.
Date: Fri, 26 Aug 2011 18:31:33 +0530
Message-ID: <1314363693-20831-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60200 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab1HZNB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 09:01:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Govindraj R <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>

Hello,

During system_wide_suspend pm runtime is disabled.
I.e. __pm_runtime_disable is called from __device_suspend.
Now, if a wakeup interrupt is triggered and the wakeup device irq handler
is called even before device_resume and pm_runtime_enable happens,
the device irq_handler proceeds to enable clock with runtime API to
handle wakeup event.
 
Wouldn't this result in system wide abort since the pm_runtime is not enabled
yet from dpm_resume?
As we end up accessing regs after doing runtime get_sync.
 
Looks like this scenario is not handled currently.
Or Am I missing something here?

--
Thanks,
Govindraj.R

