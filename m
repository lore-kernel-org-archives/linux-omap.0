From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: dspgateway linux-omap branch
Date: Mon, 2 Feb 2009 01:51:12 +0200
Message-ID: <200902020151.12822.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:30490 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZBAXvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Feb 2009 18:51:17 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1048688fkf.5
        for <linux-omap@vger.kernel.org>; Sun, 01 Feb 2009 15:51:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dspgateway-devel@lists.sourceforge.net

Hello all,

I wonder about the status of dspgateway branch.
It does not compile cleanly for n770_defconfig confuguration. Applying patches
'USB: omap1 ohci buildfix (otg related)',
'drivers/usb/core/hub.c: fix CONFIG_USB_OTG=y build' and
'ARM: OMAP: Remove unused platform devices, v3'
makes it compile, but the resulting kernel does not boot on Nokia 770.

The same boot problem also affects 'origin/omap-fixes' branch.

Git HEAD seems to compile and boot fine on Nokia 770, and dspgateway patch can
be applied to it. But unfortunately 'demo_console' test application does not
work (dsp task gets loaded or is at least reported to be loaded,
but 'demo_console' arm side program gets stuck and does not show anything).

The last kernel version which has dspgateway in more or less working on Nokia
770 seems to be 2.6.27-omap1 (aic23 and sound related stuff has problems, but
can be disabled). Maybe some of the more recent kernels are fine too, but I
did not find the exact point where it got broken yet.

Are there any ideas how to bring dspgateway branch into a better shape?

-- 
Best regards,
Siarhei Siamashka
