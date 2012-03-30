From: Ashwin Bihari <abihari@gmail.com>
Subject: OMAP TWL4030/TPS65950 power off
Date: Fri, 30 Mar 2012 14:04:43 -0400
Message-ID: <CANLagX8oMGLkkKuvDw4g30CE+n9bbvO=ouEDk0Vf=xOM5Q2eDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48899 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2C3SEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 14:04:44 -0400
Received: by obbeh20 with SMTP id eh20so1258744obb.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 11:04:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Greetings,

In one of the older Kernels, there was a twl4030-poweroff driver that
provided a hook to shutdown the OMAP when the "poweroff" or "shutdown
-h now" command was issued in Linux. This also put the
TWL4030/TPS65950 into it's power on state awaiting a press of the
power button. My most recent experience with this functionality
working is with a 2.6.32 Kernel.

I'm trying to get this functionality going with a 3.1.10 Kernel. I've
brought over the same twl4030-poweroff driver, but now the system just
crashes during shutdown as opposed to nice going down.

The file 'drivers/mfd/twl4030-power.c' does define the
PWR_P1_SW_EVENTS and PWR_DEVOFF bit, but the PWR_DEVOFF bit is never
used to turn the system off, why is it even defined and what is the
right way of turning of the system now?

-- Ashwin
