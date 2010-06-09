From: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Subject: Timekeeping issue on aggressive suspend/resume
Date: Wed, 9 Jun 2010 12:50:39 -0700
Message-ID: <AANLkTinIO5a1EeK6Ej2ljkuyL9zv06OMfbyiZBaxTQTd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f204.google.com ([209.85.211.204]:48778 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220Ab0FITvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 15:51:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

I have an application (running on 2.6.29-omap1) which puts an OMAP1
system to suspend aggressively. The system wakes up every 4 seconds
and stays awake for about 35 milliseconds and sleeps again for another
4 seconds. This design is to save power on a battery operated device.

This aggressive suspend resume action seems like creating an issue to
other applications in the system waiting for some timeout to happen
(especially an application which is waiting using the mq_timedreceive
and is supposed to timeout every 30 seconds. It seems to wake up every
90 seconds). Seems like the timekeeping is not happening properly in
side the kernel.

If the suspend duration is changed from 4 second to 1 second, then
things work somewhat better. On reducing it to 0.5 second (which was
our earlier design on 2.6.16-rc3), the problem seems to disappear.

Is this expected?

Thanks in advance,

Suresh
