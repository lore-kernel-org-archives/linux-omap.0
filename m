From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Query: Omap temperature sensor driver design
Date: Fri, 1 Apr 2011 18:09:43 +0530
Message-ID: <AANLkTimsX-=1Qe8F3=gJM75_TYP9SujTFTH6uvXncWRC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49311 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753792Ab1DAMjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 08:39:45 -0400
Received: by mail-wy0-f182.google.com with SMTP id 23so3445013wyf.13
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 05:39:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lm-sensors@lm-sensors.org
Cc: linux-omap@vger.kernel.org, KEERTHY J <j-keerthy@ti.com>

Hello All,

I am trying to implement a driver for the OMAP temperature sensor.
It is an on chip sensor.

The sensor is responsible for reporting the temperature. The sensor
has configurable thresholds. The user can configure the thresholds.
An interrupt will be generated as soon as there the temperature
thresholds are crossed.

Two possible approaches for the driver:

1) The entire driver resides in drivers/hwmon directory. The driver
containing all the sysfs nodes to be exposed to the user.
The interrupt handlers are also part of this driver. The device
registration happens in a OMAP arch specific file residing
in arch/arm/mach-omap2 directory.

2) The intialization and the interrupt handling done in a
separate driver file residing in in arch/arm/mach-omap2 or
drivers/misc directory.
The device registration happens in a OMAP arch specific file residing
in arch/arm/mach-omap2 directory.
Only the sysfs nodes will be exposed through a hwmon
driver residing in drivers/hwmon.

Please suggest the best alternative among the two or if any new
design for the requirements is better.

-- 
Regards and Thanks,
Keerthy
