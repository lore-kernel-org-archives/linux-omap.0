From: Sriram V <vshrirama@gmail.com>
Subject: missing keypad interrupts
Date: Mon, 23 Nov 2009 19:05:32 +0530
Message-ID: <8bf247760911230535p75e60e23x844bb18dc2555e09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:59823 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbZKWNf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 08:35:27 -0500
Received: by pxi42 with SMTP id 42so3295513pxi.5
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 05:35:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Premi, Sanjeev" <premi@ti.com>

Hi,
   I use 2.6.29 kernel (omap zoom kernel) and am facing a strange problem.
  When i go to suspend, I am unable to wakeup using the keypad.
Sometimes this works.
  I find that when the system is alive keypad works fine. The sysnirq
mux is okay.
  I am not sure, why i am unable to wakeup when the system is suspended.
  I am missing keypad interrupts. I set an led on and off every time i
press the keypad in the isr.
  After sometime, it does not glow, when i press the keypad.

  However, i am able to wakeup on serial input.


 Please advise.


Regards,
sriram
