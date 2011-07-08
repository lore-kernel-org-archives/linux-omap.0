From: Kevin Hilman <khilman@ti.com>
Subject: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Fri, 08 Jul 2011 16:41:00 -0700
Message-ID: <871uy0733n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34322 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878Ab1GHXlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 19:41:06 -0400
Received: by pzk10 with SMTP id 10so2726924pzk.35
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 16:41:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Rafael,

Just curious why pm_runtime_suspended() requires the device to be
enabled for it to return true:

static inline bool pm_runtime_suspended(struct device *dev)
{
	return dev->power.runtime_status == RPM_SUSPENDED
		&& !dev->power.disable_depth;
}

I must be misunderstanding something, but I would consider a device that
has been runtime suspended before runtime PM was disabled to still be
runtime suspended.

I just noticed this when testing with your pm-domains branch.  when I
noticed that an 'if (pm_runtime_suspended(dev))' check in my PM domain's
->suspend_noirq() was always failing since it's after the PM core calls
pm_runtime_disable().  I had to change my PM domain code to only check
dev->power.runtime_status for it to work.

Kevin
