From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Is the OMAP patch process badly flawed?
Date: Tue, 17 Nov 2009 13:30:43 +0000
Message-ID: <4B02A583.8090602@blueyonder.co.uk>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au> <4B0213AC.6050502@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:57192 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752161AbZKQNao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 08:30:44 -0500
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NAO8v-0003zK-7a
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 13:30:49 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NAO8u-0004dL-Iq
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 13:30:48 +0000
In-Reply-To: <4B0213AC.6050502@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm curious - I download, build and test kernels on x86 and x86_64
platforms, -rc, -rc-git and -git all build and run.
On the OMAP platform I have so far not been able to do that with
omap-git, omap-dss2-git trees and snapshots all missing basic hardware
support, e.g:- I get the latest from gitorious.org, make
omap3_beagle_defconfg, make xconfig, but there is no EHCI config
available. I hunt down the patch and hand apply "default y if
ARCH_OMAP34XX" to drivers/usb/Kconfig, next the build complains that
drivers/usb/host/ehci-hcd.c: 1143:2: error: #error "missing bus glue for
ehci-hcd"

The bus glue patch ... ehci-omap.c no longer exists.
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1108,6 +1108,11 @@ MODULE_LICENSE ("GPL");
 #define        PLATFORM_DRIVER         ehci_hcd_au1xxx_driver
 #endif

+#ifdef CONFIG_ARCH_OMAP34XX
+#include "ehci-omap.c"
+#define        PLATFORM_DRIVER         ehci_hcd_omap_driver
+#endif
+
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
 #define        PS3_SYSTEM_BUS_DRIVER   ps3_ehci_driver

I would expect patches sent upstream would result in all the basics for
long established platforms to be fully covered. Appreciating that
development is quite fast paced with mods and supporting new platforms.
Could someone please enlighten me?
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

