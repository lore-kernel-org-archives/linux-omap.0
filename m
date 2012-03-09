From: Allen Pais <allen.lkml@gmail.com>
Subject: mmc_delayed_work error
Date: Fri, 9 Mar 2012 15:20:39 +0530
Message-ID: <CAOMdWSKdT+hJ2btwwwVMFB7p7LjuYgZr34Q7RxT3Lex+xz2cWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:59379 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753474Ab2CIJuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 04:50:40 -0500
Received: by obbuo6 with SMTP id uo6so1914779obb.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 01:50:39 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

  When i suspend the system, i get

0 : OFF, 1 : RETENTION, 2 : ON-INACTIVE, 3 : ON-ACTIVE
Powerdomain (core_pwrdm) entered state 1
Powerdomain (gfx_pwrdm) is in state 0
Powerdomain (abe_pwrdm) entered state 0
Powerdomain (dss_pwrdm) is in state 0
Powerdomain (tesla_pwrdm) entered state 0
Powerdomain (wkup_pwrdm) is in state 0
Powerdomain (cpu0_pwrdm) entered state 0
Powerdomain (cpu1_pwrdm) entered state 0
Powerdomain (emu_pwrdm) is in state 0
Powerdomain (mpu_pwrdm) entered state 0
Powerdomain (ivahd_pwrdm) entered state 0
Powerdomain (cam_pwrdm) is in state 0
Powerdomain (l3init_pwrdm) entered state 1
Powerdomain (l4per_pwrdm) entered state 1
Powerdomain (always_on_core_pwrdm) is in state 0
Powerdomain (cefuse_pwrdm) is in state 0
PM: early resume of devices complete after 0.854 msecs
wakeup wake lock: mmc_delayed_work
PM: resume of devices complete after 150.054 msecs
Restarting tasks ...


mmc_delayed_work keeps looping. Any idea on whats going wrong.
Am using 2.6.35.

-- 
Cheers!!
Allen
