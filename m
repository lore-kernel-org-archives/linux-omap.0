From: Kiril Maler <kiril.maler@gmail.com>
Subject: Fwd: Workaround for hanging u-boot 'Load Address: fffffff2'
Date: Mon, 14 Jan 2013 10:02:11 +0100
Message-ID: <CABJxTWGmmZ55GE7YiwVCCj8JmofQBF_wc-Q9PBtfQW-uarJhDg@mail.gmail.com>
References: <CABJxTWFKCxS=syoFCyRyCMdJmwMg_yLq3pOMfr9MhCO7g=Rtzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:55988 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab3ANJCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 04:02:22 -0500
Received: by mail-la0-f45.google.com with SMTP id ep20so3590807lab.32
        for <linux-omap@vger.kernel.org>; Mon, 14 Jan 2013 01:02:20 -0800 (PST)
In-Reply-To: <CABJxTWFKCxS=syoFCyRyCMdJmwMg_yLq3pOMfr9MhCO7g=Rtzg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

---------- Forwarded message ----------
From: Kiril Maler <kiril.maler@gmail.com>
Date: 14 January 2013 09:46
Subject: Workaround for hanging u-boot 'Load Address: fffffff2'
To: "davinci-linux-open-source@linux.davincidsp.com"
<davinci-linux-open-source@linux.davincidsp.com>


If your fresh uImage hangs in a similar way:

## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.8.0-rc2-tst04+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1161118 Bytes = 1.1 MiB
   Load Address: fffffff2
   Entry Point:  fffffff2
   Verifying Checksum ... OK
   Loading Kernel Image ...


Then a temporary fix could be added in arch/arm/boot/Makefile

git diff  arch/arm/boot/Makefile
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index abfce28..4182943 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -13,6 +13,8 @@

 ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
+else
+include $(srctree)/arch/arm/mach-omap2/Makefile.boot
 endif

 # Note: the following conditions must always be true:


Change 'mach-omap2' in the patch above to required machine directory

This is needed because 'MACHINE' in arch/arm/Makefile is
set empty when CONFIG_ARCH_MULTIPLATFORM=y, and consequently parameters
-a and -e are empty in arch/arm/boot/.uImage.cmd

Regards,
