From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: ARM: CONFIG_FRAME_POINTER
Date: Tue, 12 May 2009 16:46:30 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53895 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbZELVqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 17:46:36 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4CLkXmV012867
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 16:46:38 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4CLkWaP026430
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 16:46:32 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n4CLkW5V021782
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 16:46:32 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,

I have been doing some testing with the latest linux-omap kernel on the 3430sdp and the kernel appeared to hang on start-up during the delay loop calibration. 

After debugging this I found that this was being caused because there was a difference in the compilation flags being used when compiling this kernel version and an earlier kernel version. Please note that I am using the code sourcery arm2007q3 compiler version (gcc 4.2.1) which is old I know!

Investigating further I noticed that the source of the different kernel compilation flags was due to the fact that kernel option "CONFIG_FRAME_POINTER" was missing from the .config. Although this is declared in the defconfig for the 3430sdp but it was not getting copied over to the .config.

Looking at the lib/Kconfig.debug it appears that there is a new option added back in January called "ARCH_WANT_FRAME_POINTERS" [1]. And only if this new option is defined in the ARCH Kconfig will CONFIG_FRAME_POINTER be used. Today this is not defined for ARM. 

I know this is the linux-omap list and not linux-arm but wanted to see if anyone had any comments/inputs about this and whether I should be using a newer compiler. 

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=64dec40ddee9d36d7b83f8a0513fdeaffe260a0e;hp=a3c6018e565dc07cf3738ace6bbe412f97b1bba8 

Cheers
Jon 
