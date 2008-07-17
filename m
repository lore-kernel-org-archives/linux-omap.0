From: amruth <amruth_pv@yahoo.com>
Subject: TI USB 3410 chipset download firmware
Date: Wed, 16 Jul 2008 20:53:38 -0700 (PDT)
Message-ID: <632333.35486.qm@web45215.mail.sp1.yahoo.com>
References: <20080716221708.GA20951@frodo>
Reply-To: amruth_pv@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n66.bullet.mail.sp1.yahoo.com ([98.136.44.50]:46785 "HELO
	n66.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752143AbYGQDxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jul 2008 23:53:39 -0400
In-Reply-To: <20080716221708.GA20951@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-hotplug@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi
> I am developing driver based on TI 3410 chipset. After
> downloading firmware using host, the USB bus system needs
> to be reset. The reset works fine but I cannot use the my
> target device because interrupt_in_urb is null. I am using
> usb serial driver on top of ti driver. I can see ttyUSB0
> created. After I remove the plug from my host and reconnect
> the system, the device works to be fine. Can you please let
> me know what could be going on. Should I close the serial
> device after downloading firmware. Why hotplug works after
> removing from system. I have done
> ti_usb_3410_5052.hotplug at /etc/hotplug.d. Can I execute
> hotplug from command line and see what is going on. If you
> have come across similar problem, please let me know. What
> steps of reinitialisation needs to be done after
> downloading firmware, in terms of data structures like
> interrupt_in, endpoints etc or I can probe the device once
> again.
> Thanks
> Amruth p.v






      

