From: Remith Ravi <remithmailinglist@gmail.com>
Subject: USB EHCI - Power Management - Query
Date: Wed, 29 Apr 2009 16:32:21 +0530
Message-ID: <814dfab70904290402g494dcf4ci111c10b85109595d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:50238 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509AbZD2LCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 07:02:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org

Hi,

I have a query on OMAP3530 USB EHCI Power Management.
USB EHCI port is not switching off the port during suspend activity
and it is drawing current from the system.

Is the power management tested for USB EHCI ?
In file "drivers/usb/host/ehci-omap.c", the function
ehci_hcd_omap_drv_suspend() and ehci_hcd_omap_drv_resume() is
commented out.

Did anybody tried power management on USB EHCI ?

Regards,
Remith
