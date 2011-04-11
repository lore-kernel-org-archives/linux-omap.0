From: Bob Liu <lliubbo@gmail.com>
Subject: pandaboard can't reboot on 2.6.38-rc2?
Date: Mon, 11 Apr 2011 18:13:06 +0800
Message-ID: <BANLkTikjyaA4mL-eWOcPse2T7NC2rbCfkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51900 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab1DKKNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2011 06:13:07 -0400
Received: by qyk7 with SMTP id 7so1144225qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 03:13:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, folks

I am using pandaboard and compiled a 2.6.38-rc2 kernel for it.
Everything works fine except that it can't reboot.

#reboot
#
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[  120.742370] Restarting system.

Then hanged...

Has anyone seen similar problem?

Thanks
-- 
Regards,
--Bob
