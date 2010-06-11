From: Tom Briggs <tbriggs6@gmail.com>
Subject: asoc beagle audio capture fails in 2.6.33 dspbridge kernel
Date: Fri, 11 Jun 2010 10:38:26 -0400
Message-ID: <AANLkTikYFxty_uIJ1vS5tml3pd-N7tkXfnQ80gtA823V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33828 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841Ab0FKOi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 10:38:28 -0400
Received: by bwz7 with SMTP id 7so369155bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 07:38:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have spent the past few weeks whacking at a problem with the 2.6.33
dspbridge kernel, and I'm hoping someone can help me out.

With a straight-up build of the head of the dspbridge kernel
(currently 2.6.33), doing an arecord fails to capture data.  Using
JTAG, I was able to trace through the kernel calls, and found that
registers on the McBSP were being set, the DMA request was being added
to the request chain, the TWL4030 register is set to begin
transferring data.  Comparing these to TRM, they seem to be
appropriate settings.  The DMA interrupt does not seem to be generated
by the audio capture (setting JTAG breakpoint at handle_level_irq I
see many other interrupts come in, but not int 12 for DMA, or 32/33
for McBSP framing errors).

Audio capture works fine in the 2.6.35 and 2.6.29 kernel (but
DSPBRIDGE doesn't).  So, I added the same printk's on the registers,
and where there were differences, they were negligible, e.g. in
2.6.35, the TWL4030 register 3A was set to 16, which was a higher gain
on an audio channel.

I've done a number of Google searches, and either I'm enough of a newb
that I'm not using the correct terms to bring up meaningful results,
or, noone else is reporting the same types of problems.  Is there a
patch that addresses this?

-tom


---------
Tom Briggs, PhD
Associate Professor, Department of Computer Science
Shippensburg University of Pennsylvania
