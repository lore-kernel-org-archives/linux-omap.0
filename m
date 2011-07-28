From: Arno Steffen <arno.steffen@googlemail.com>
Subject: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 15:15:20 +0200
Message-ID: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50497 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1G1NPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 09:15:21 -0400
Received: by pzk37 with SMTP id 37so4541671pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:15:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Maybe you are so kind to give me a hint:

Try to migrate from Kernel 33 to 37. Currently I don't see any message after

  Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

>From what I understand kernel starts with start_kernel()).
What is best way to find out which part is failing? At which point I
do a printk to see what's going on, or at least set a GPIO Pin of the
processor?
How to debug without any external tools like JTAG.
