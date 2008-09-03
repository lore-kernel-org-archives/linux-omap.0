From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Bug in twl4030backupbatt_voltage()
Date: Wed, 03 Sep 2008 18:10:20 +0300
Message-ID: <48BEA8DC.3030905@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42133 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYICPHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 11:07:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com

In the omap tree, commit f91fd98be045bec9c18e13110f22dafd44cb84b5
fixed a bug with the use of function twl4030_madc_conversion()
relating to the local variable 'struct twl4030_madc_request req'
not being fully initialised.

The same problem appears to be in the function
twl4030backupbatt_voltage() which is in drivers/power/twl4030_bci_battery.c

