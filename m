From: Peter Barada <peterb@logicpd.com>
Subject: JTAG debugging of the kernel
Date: Fri, 15 Aug 2008 11:03:47 -0400
Message-ID: <1218812628.24975.89.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:41958 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759963AbYHOPDu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Aug 2008 11:03:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've been trying to use JTAG (and an Abatron BDI-2000) to debug the ALSA
driver to determine why madplay can't keep up when pulling .mp3 from an
SD card, and have not had any luck trying to halt via JTAG and set/stop
at breakpoints within the kernelthe kernel.  I've found that JTAG works
for a while on kernel startup, but stops working at a non-reproducible
point in the startup code.

Have people had success using a BDI-2000 to debug the kernel after it
has completed startup?

Any suggestions on what can cause the JTAG to stop working after the
kernel starts?

Thanks in advance!
