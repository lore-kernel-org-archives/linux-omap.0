From: pavan_savoy@indiatimes.com
Subject: Place-Holder for a driver
Date: Sat, 22 Nov 2008 01:34:37 +0530 (IST)
Message-ID: <1433030405.242931227297877109.JavaMail.root@mbv7.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from omta1.indiatimes.com ([203.199.93.122]:35326 "HELO
	omta1.indiatimes.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752152AbYKUUGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 15:06:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The OMAP Zoom2 board has a bluetooth chip which needs to be enabled to be used. When running on Android, the Bluetooth service of Android uses the rfkill sysfs entry to turn on bluetooth.

So I linked the Bluetooth enable GPIO to the sys-fs entry, Now the question is where should/does this driver fit in ?

I've thought of drivers/misc, Any suggestions are welcome.

Thanks & Regards,
Pavan Savoy.


--
The New Maruti A-Star is here. View pics, videos, read expert opinion and more on ZigWheels.com
http://images.zigwheels.com/b2cam/a_star.html
