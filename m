From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Preempt-RT on OMAP3?
Date: Mon, 6 Apr 2009 15:25:25 +1200
Message-ID: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:50858 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZDFDZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2009 23:25:28 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1961386yxl.1
        for <linux-omap@vger.kernel.org>; Sun, 05 Apr 2009 20:25:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi everyone,

I'm trying to get the realtime patch set to work on OMAP3 (Gumstix
Overo). Linux-omap 2.6.29 with the RT patches -rt1 or -rt2 work mostly
as is (MUSB and the usb-gadget layer have quite a few problems, and
the realtime self-test stuff picks up a few problems to do with
spinlock usage etc, but most things seem to mostly work correctly for
my needs). Running cyclictest with various types of loads gives an
average latency of ~30-50 usec and worst case up around 300 usec.

Is anyone working on RT on omap3? Is there a more suitable mailing
list for this? Is there a git repo somewhere tracking the work on
2.6.39-rtX for OMAP?

Thanks,
Hugo Vincent
