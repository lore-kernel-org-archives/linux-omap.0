From: Steven Cavanagh <steven@embeddedconsulting.ca>
Subject: UF1050
Date: Mon, 22 Jun 2009 20:12:49 -0600
Message-ID: <7f88bf070906221912v16b73c01u367f305d5dcd7d17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f171.google.com ([209.85.221.171]:63168 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZFWCMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 22:12:47 -0400
Received: by qyk1 with SMTP id 1so1581573qyk.33
        for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 19:12:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Has anyone been able to get a UF1050 working on the 3530?
Each time I insert a module from TimeSys, I see the following error
message?? Argh!
I started with a BeagleBoard kernel build on a custom platform.

Thanks,

Stella

mmc1: new SDIO card at address 0001
<6>unifi: card 0x61A80 inserted
unifi: card 0x61A80 inserted
<1>Unable to handle kernel paging request at virtual address 03197504
Unable to handle kernel paging request at virtual address 03197504
<1>pgd = c0004000
pgd = c0004000
<1>[03197504] *pgd=00000000[03197504] *pgd=00000000

Internal error: Oops: 5 [#1]
Internal error: Oops: 5 [#1]
Modules linked in:Modules linked in: unifi_sdio unifi_sdio

CPU: 0    Not tainted  (2.6.28-rc8-omap1 #313)
CPU: 0    Not tainted  (2.6.28-rc8-omap1 #313)
PC is at unifi_sdio_set_max_clock_speed+0x78/0x94 [unifi_sdio]
PC is at unifi_sdio_set_max_clock_speed+0x78/0x94 [unifi_sdio]
LR is at unifi_sdio_set_max_clock_speed+0x7c/0x94 [unifi_sdio]
LR is at unifi_sdio_set_max_clock_speed+0x7c/0x94 [unifi_sdio]
