From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: mailbox_mach dependency problem
Date: Sat, 1 May 2010 17:47:57 +0300
Message-ID: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63778 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab0EAOsA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 10:48:00 -0400
Received: by bwz19 with SMTP id 19so599647bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 07:47:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <hiroshi.doyu@gmail.com>

Hi,

There seems to be a problem with 'mailbox' and 'mailbox_mach' modules.
When another module, like bridgedriver, uses mailbox stuff, only the
'mailbox' module is loaded which doesn't register the platform device.

The easiest solution would be to make mailbox_mach built-in when
mailbox is configured, however, mailbox_mach needs mailbox to be
loaded.

I tried to add a poke() function in mailbox_mach so that the module is
loaded when mailbox is loaded, but apparently linux doesn't like loop
dependencies:
WARNING: Loop detected: kernel/arch/arm/mach-omap2/mailbox_mach.ko
needs mailbox.ko which needs mailbox_mach.ko again!

Any ideas how to solve this issue?

-- 
Felipe Contreras
