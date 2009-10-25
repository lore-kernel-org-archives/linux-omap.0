From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Please advise on modifying defconfig for Amstrad Delta
Date: Sun, 25 Oct 2009 04:40:32 +0200
Message-ID: <200910250340.34046.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59956 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbZJYClh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Oct 2009 22:41:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I'm just working on a new, updated version of ams_delta_defconfig. Starting from the current version, created over 2 years ago for 2.6.22, I turned on a few device drivers that was added recently, turned on thumb instructions support, turned on EABI, kept old ABI compatibility and NWFPE, and got a resulting kernel that is ~170kB too large to be successfully booted using tools available at http://the.earth.li/pub/e3/.

Of course, I am able to trim that down, even adding a few more drivers for add-on hardware that I am using, and get a kernel that works perfectly for me, but since I have never prepared a default config, I'd like to get your advice on what I can remove and what should rather be kept untouched.

Instead of pasting sixteen hundred lines here, I'd rather ask about the simplest change I can see:

-# CONFIG_EMBEDDED is not set
-CONFIG_KALLSYMS=y
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set

That would give me a kernel that is small enough, but since only a few of arm defconfigs have CONFIG_KALLSYMS not set, I am not sure if it is generally acceptable.

Thanks,
Janusz
