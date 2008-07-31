From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: (unknown)
Date: Thu, 31 Jul 2008 16:51:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02568EB105@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:55083 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbYGaLVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 07:21:31 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m6VBLQ6U026123
	for <linux-omap@vger.kernel.org>; Thu, 31 Jul 2008 06:21:31 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m6VBLPuO008842
	for <linux-omap@vger.kernel.org>; Thu, 31 Jul 2008 06:21:25 -0500 (CDT)
Subject: 
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

With "no_hz=off" added to my bootargs, I get the following message every two minutes
on my 3430SDP. Also seen on the beagleboard (with a different gpio number, I think).

Has anyone seen this before? Any clues why this happens?

- Anand

<3>INFO: task twl4030 gpio:263 blocked for more than 120 seconds.
INFO: task twl4030 gpio:263 blocked for more than 120 seconds.
<3>"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>twl4030 gpio  Dtwl4030 gpio  D c028b918  c028b918     0   263      2    0   263      2
[<c028b6b4>] [<c028b6b4>] (schedule+0x0/0x2a0) (schedule+0x0/0x2a0) from [<c00628dc>] from [<c00628dc>] (kthread+0x3c/0x80)
(kthread+0x3c/0x80)
[<c00628a0>] [<c00628a0>] (kthread+0x0/0x80) (kthread+0x0/0x80) from [<c0052bdc>] from [<c0052bdc>] (do_exit+0x0/0x5fc)
(do_exit+0x0/0x5fc)
 r5:00000000 r5:00000000 r4:00000000 r4:00000000
