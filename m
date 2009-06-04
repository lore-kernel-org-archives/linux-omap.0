From: "Can Bal" <canbal@ee.bilkent.edu.tr>
Subject: DSP MMU Fault
Date: Thu, 4 Jun 2009 14:53:56 +0300 (EEST)
Message-ID: <44449.139.179.13.76.1244116436.squirrel@newmail.bilkent.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ispinoz.bcc.bilkent.edu.tr ([139.179.10.240]:45973 "EHLO
	ispinoz.bcc.bilkent.edu.tr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753342AbZFDMAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 08:00:42 -0400
Received: from newmail.bilkent.edu.tr (unknown [192.168.10.203])
	by ispinoz.bcc.bilkent.edu.tr (Postfix) with ESMTP id 73B286927
	for <linux-omap@vger.kernel.org>; Thu,  4 Jun 2009 14:53:52 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi everyone,

I'm implementing a code on DSP but at the time I do a memory allocation at
the DSP side as:

short *a;
a = malloc(192); // (short*)malloc(192) does not work either

But at this line I get the following error and DSP fails afterwards. Then
I need to reboot until I can run the application again.

<6>***** DSPMMU FAULT ***** IRQStatus 0x2
***** DSPMMU FAULT ***** IRQStatus 0x2
<6>***** DSPMMU FAULT ***** faultAddr 0x230674a0
***** DSPMMU FAULT ***** faultAddr 0x230674a0
<6>WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
<6>WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
<6>WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
<6>WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
<6>WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0

Do you have any ideas why this might be happening and how to fix it?
Thanks a lot.

Can

