From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: Could not enter target state in pm_suspend in Overo board.
Date: Wed, 09 Feb 2011 12:27:35 +0530
Message-ID: <4D523ADF.9070402@e-consystems.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:39985 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750906Ab1BIG5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 01:57:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP-KML <linux-omap@vger.kernel.org>

Hi,

I am testing pm in overo board. it is a freshly build kernel from OMAP 
mainline git.

 From the below log, I have doubt whether the OMAP really goes into 
suspend to RAM state.

root@overo:~# echo mem > /sys/power/state
[  866.503662] PM: Syncing filesystems ... done.
[  866.590515] Freezing user space processes ... (elapsed 0.02 seconds) 
done.
[  866.620361] Freezing remaining freezable tasks ... (elapsed 0.04 
seconds) done.
[  866.676452] Suspending console(s) (use no_console_suspend to debug)
[  866.807464] PM: suspend of devices complete after 119.415 msecs
[  866.810516] PM: late suspend of devices complete after 2.990 msecs
[  866.811279] omap_device: omap_uart.2: new worst case deactivate 
latency 0: 122070
[  868.480895] Powerdomain (core_pwrdm) didn't enter target state 1
[  868.480926] Could not enter target state in pm_suspend
[  868.482574] PM: early resume of devices complete after 1.464 msecs
[  868.734558] mmc1: error -110 during resume (card was removed?)
[  868.739562] PM: resume of devices complete after 256.439 msecs
[  868.796142] Restarting tasks ... done.


Queries.

[  866.811279] omap_device: omap_uart.2: new worst case deactivate 
latency 0: 122070

1 . do I need to set some thing before suspend to ram.

[  868.480895] Powerdomain (core_pwrdm) didn't enter target state 1
[  868.480926] Could not enter target state in pm_suspend

2. So it didn't enter into the suspend state completely .

Could some one clarify the above.

-- 
Best Regards,
Mohamed Thalib H

