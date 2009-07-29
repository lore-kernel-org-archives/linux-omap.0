From: Mike Chan <mike@android.com>
Subject: drivers that require headers in mach-omap
Date: Tue, 28 Jul 2009 18:49:19 -0700
Message-ID: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:37239 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZG2BtT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jul 2009 21:49:19 -0400
Received: by pzk42 with SMTP id 42so296696pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2009 18:49:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Omap folks, how are drivers that require access to prm and cm
registers via cm_read_mod_reg() etc... suppose to access these?

For example if drivers/usb/host/ohci-omap.c wanted to call:
cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_IDLEST);

It seems some of the headers in mach-omap2 should be in
plat-omap/include/mach, or is there a more elegant way? The other
alternatives are to register calls in all the board files, or #include
../../.. both do not seem very elegant to me.

-- Mike
