From: Kevin Hilman <khilman@ti.com>
Subject: MFD USB host: prevents CORE retention in idle
Date: Wed, 23 May 2012 17:01:26 -0700
Message-ID: <87zk8yxx9l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:50544 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751074Ab2EXAB3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 May 2012 20:01:29 -0400
Received: by pbbrr4 with SMTP id rr4so10067264pbb.9
        for <linux-omap@vger.kernel.org>; Wed, 23 May 2012 17:01:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <Keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Keshava,

Using current l-o master, I noticed that CORE was not hitting retention
in idle on my 3530/Overo.  CORE hits retention on suspend just fine.

Debugging this, I found that usbtll_fck was still enabled during idle,
thus preventing CORE from hitting retention.

To test, I disabled USB host (CONFIG_MFD_OMAP_USB_HOST=n in .config) and
was then started seeing CORE hit retention in idle again.

I have nothing plugged into the USB host port on this board, so I
would've expected that runtime PM would've kicked in and shutdown this
clock.

Any ideas what's going on here?  Is this expected behavior?

Kevin
