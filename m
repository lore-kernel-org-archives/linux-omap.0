From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: OMAP-McBSP driver not allowing suspend/resume
Date: Fri, 6 Nov 2009 19:13:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A704F27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56579 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758047AbZKFNn2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 08:43:28 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

Hi,

I am trying to put OMAP3 in suspend state, while audio is playing,
by issuing:

echo mem > /sys/power/state

root@omap3evm:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
Powerdomain (core_pwrdm) didn't enter target state 1
Powerdomain (per_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
Restarting tasks ... Suspended. Trying resume. done.
Done.
root@omap3evm:~#

As can be seen from the log, both the CORE and PER power domains
are not going to the suspend state.

On further debug, I found that McBSP 2 instance belongs to the
PER domain whereas SDMA belongs to CORE domain. And at least 
McBSP driver (on l-o tip) doesn't allow disabling of the clocks
unless McBSP instance itself is freed. Because of this, when 
McBSP is stopped after receiving the suspend request, the
clocks are still ON and the PER domain is not allowed to enter
to the desired low-power state. 

The McBSP driver needs to be modified so that it can accommodate 
suspend/resume requests and turns off the clocks when not required.
Has anyone modified the driver for this, on some other branch? I
tried finding it but could not do so. (Just wanted to make sure
before doing the changes)

Regards,
Anuj Aggarwal

