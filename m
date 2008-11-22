From: "Sudipta GHOSH" <sudipta.in@gmail.com>
Subject: busybox output to display
Date: Sat, 22 Nov 2008 21:35:03 +0200
Message-ID: <9e6474ae0811221135l1a3fcf93gb59d12407c57ecfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:56658 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYKVTfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 14:35:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1440687rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 22 Nov 2008 11:35:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This issue is more with busybox. Hope you will not mind for posting here.

In my development board, I use uboot as boot loader. busybox files are in flash.
when I boot , I can see the boot logo (peguin) in the lcd display and
all "printk" output.

But I am unable to see the busybox in the lcd display.

busybox prompt and all output from busybox is going to the serial port.

Like  if I do ls, then I see the output of "ls" in my serial port
(teraterm/hyper terminal).

How I can see busybox prompt and all output to my lcd display.


I use console=tty0 in the bootargs.

any advice?


Regards,
-SG
