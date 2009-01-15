From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Reading OMAP3 CONTROL_RAND_KEY_0 register hangs
Date: Thu, 15 Jan 2009 17:23:44 +0100
Message-ID: <496F6310.30104@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:51388 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbZAOQX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 11:23:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so594331fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 15 Jan 2009 08:23:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


With OMAP3530 on BeagleBoard we like to read OMAP3's 
CONTROL_RAND_KEY_0 (0x4800 2318) register with something like

printf ("attempting cpu_uid read\n");
u32 cpu_uid = *((u32 *) 0x48002318);
/* u32 cpu_uid = readl(&ctrl_base->randkey_0); */
printf ("cpu_uid read done\n");

This does hang after first printf, second printf is never printed. 
Both, the direct register access and the readl style doesn't work. 
Access to other system control module register in the same address 
range works fine, though.

Any idea or hint?

For details see spruf98b.pdf page 960 and

http://www.sakoman.net/cgi-bin/gitweb.cgi?p=u-boot-omap3.git;a=blobdiff;f=cpu/arm_cortexa8/omap3/sys_info.c;h=347e8ba24b03d5a4c3a37878cf6fc9f6868066c7;hp=67955531f3f0782b2f3f7e587472e0bef08c921c;hb=292a36ca0271c4a93196f4efd118640b11a65482;hpb=0b043b4ac2144a517d2a5d24ffff7c957b9178f7

Yes, this isn't Linux, but for U-Boot. But as a lot OMAP experts are 
here and same might happen if reading this registers from Linux, we'd 
like to ask here.

Thanks

Dirk






