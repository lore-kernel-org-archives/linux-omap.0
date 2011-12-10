From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: MMC not working reliably for Gumstix Overo Tide
Date: Sat, 10 Dec 2011 01:45:16 +0100
Message-ID: <jbua2s$8qq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42251 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab1LJApc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 19:45:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RZB4D-0006Gc-A4
	for linux-omap@vger.kernel.org; Sat, 10 Dec 2011 01:45:29 +0100
Received: from dslb-178-005-127-249.pools.arcor-ip.net ([178.5.127.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 01:45:29 +0100
Received: from andre.puschmann by dslb-178-005-127-249.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 01:45:29 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi list,

I've got a Gumstix Overo Tide (OMAP 3530) based board here which doesn't
have NAND and therefore needs the MMC to boot.

I've successfully built a kernel using Tony's master branch. The system
boots fine up to the point where the MMC driver loads (well, I guess
that is where the problem lies). I am using omap2plus_defconfig. The
weird thing is that sometimes the system hangs after printing "Waiting
for root device /dev/mmcblk0p2..." and sometimes after mounting the
rootfs. Any ideas? I've seen some probelms with MMC in the recent past,
could that be the cause?

Thanks in advance.

Cheers,
Andre



Kernel log:

[    2.092224] Waiting for root device /dev/mmcblk0p2...
[    2.271026] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    2.282379] mmc0: new high speed SDHC card at address b368
[    2.292053] mmcblk0: mmc0:b368 USD   14.9 GiB
[    2.303894]  mmcblk0: p1 p2
[    2.341644] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data
mode. Opts: (null)
[    2.350891] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    2.358917] Freeing init memory: 208K
 .. nothing happens here ..

