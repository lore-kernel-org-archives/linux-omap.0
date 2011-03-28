From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Smartreflex on 'pm-wip/voltdm' Branch
Date: Mon, 28 Mar 2011 16:23:29 +0530
Message-ID: <AANLkTi=czLooLOFEZq-TYKLOqwFxn8eB6aTs7-3k_YSY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:32837 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517Ab1C1Kxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 06:53:31 -0400
Received: by mail-bw0-f53.google.com with SMTP id 12so2603747bwg.26
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 03:53:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

Kevin,

I am testing Smartreflex on your Branch 'pm-wip/voltdm'. There seems
an issue with reading VP registers.
For OMAP3 and OMAP4 reading debugfs entries shows constant voltage.
Logs are:

OMAP3:
# cat /debug/voltage/vdd_mpu_iva/curr_nominal_volt
1200000
# cat /debug/voltage/vdd_core/curr_nominal_volt
1200000
# echo 1 > /debug/voltage/vdd_mpu_iva/smartreflex/autocomp
[  311.680816] omap_device: smartreflex.0: new worst case activate
latency 0: 91552
# echo 1 > /debug/voltage/vdd_core/smartreflex/autocomp
# cat /debug/voltage/vdd_core/vp/curr_volt
900000
# cat /debug/voltage/vdd_mpu_iva/vp/curr_volt
900000


OMAP4:
 # cat /debug/voltage/vdd_core/curr_nominal_volt
1200000
# cat /debug/voltage/vdd_mpu/curr_nominal_volt
1375000
# cat /debug/voltage/vdd_iva/curr_nominal_volt
1188000
#
# echo 1 > /debug/voltage/vdd_mpu/smartreflex/autocomp
[   61.514038] omap_device: smartreflex.2: new worst case activate
latency 0: 30517
# echo 1 > /debug/voltage/vdd_core/smartreflex/autocomp
# echo 1 > /debug/voltage/vdd_mpu/smartreflex/autocomp
#
# cat /debug/voltage/vdd_iva/curr_nominal_volt
1188000
# cat /debug/voltage/vdd_iva/vp/curr_volt
1200000
#
# echo 1 > /debug/voltage/vdd_iva/smartreflex/autocomp
# cat /debug/voltage/vdd_iva/vp/curr_volt
812500
#
# cat /debug/voltage/vdd_mpu/vp/curr_volt
812500
# cat /debug/voltage/vdd_core/vp/curr_volt
812500
#

This Issue is not reproduced on 'pm-core' branch, seems in the voltage
Layer Clean up Patches somewhere some thing is goofed up.


Thanks,
Regards,
Shweta
