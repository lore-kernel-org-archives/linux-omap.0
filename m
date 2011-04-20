From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Monitoring uevents at the user space
Date: Wed, 20 Apr 2011 17:34:05 +0530
Message-ID: <BANLkTi=eYr8u_-BhEJibj6dek0Luo=DnvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53937 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507Ab1DTMEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 08:04:07 -0400
Received: by wwb17 with SMTP id 17so628601wwb.12
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 05:04:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello All,

I am writing a driver for OMAP4460 thermal sensor. I have a requirement
to send events to the user space from the driver on some condition.

I am using kobject_uevent(&temp_sensor->dev->kobj, KOBJ_ADD) as
part of initialization.

On the occurrence of the event i am notifying via
kobject_uevent(&temp_sensor->dev->kobj, KOBJ_CHANGE).

I am using busybox file system. What is the recommended way
to actually verify whether the uevent has been propagated to the
user space or not from the driver?

-- 
Regards and Thanks,
Keerthy
