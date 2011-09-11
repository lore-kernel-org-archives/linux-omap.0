From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: [QUERY] am35x: crash with no_console_suspend
Date: Mon, 12 Sep 2011 01:52:28 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087037AF843D5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42577 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab1IKUXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Sep 2011 16:23:40 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8BKNbJC017602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 11 Sep 2011 15:23:39 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8BKNa6P021708
	for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 01:53:36 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

hi

On the am35x, I can see that resumption (after a suspend command was issued) from ram using the serial console
hangs without any messages, ONLY when I use no_console_suspend in boot-args. The last message I see is this :
                       "Disabling non-boot CPUs ...\n"

Using logs I can see that everything is fine till issuing of omap_uart_prepare_idle() in omap_sram_idle(), which happens
just before calling the assembly code that starts WFI. I have not yet been able to use a debugger to pinpoint the exact
point of failure.

As is evident, there is no issue if I don't use no_console_suspend. And that much of the code is the same as that of omap34xx
case ( when off mode is not being used). 
If anyone has seen anything like this please respond.

thanks and regards
Abhilash