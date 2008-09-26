From: "Ashwin Bihari" <abihari@gmail.com>
Subject: MUSB OTG Interrupts
Date: Fri, 26 Sep 2008 12:00:17 -0400
Message-ID: <1f11a5490809260900q43d1524fn8811e9516663bc12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:60785 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbYIZQAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 12:00:18 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1167101wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 09:00:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Greetings,

I've got a very curious problem with my OMAP3 based  board. I'm using
the OMAPZOOM kernel v2.6.27-rc3 and have enabled MUSB in OTG mode
(both host and perihperhal). I've got the file-backed-storage gadget.
If I plug the mini-B connector to the board, it gets the appropriate
interrupt and recognizes that it needs to be operate in peripheral
mode and goes about it's business. However, when I plug in the mini-A
connector to the board, there is no interrupt and no activity. I can
then unplug the mini-A connector, and plug in the mini-B connector to
get the interrupts and activity again.

If I boot the board up with the mini-A connector plugged in, it is
properly found/recognized during driver installation and any devices
attached are properly found and can be used. The IRQs at this time
fire properly. I have a thumb drive connected to a high speed hub
connected to the OMAP board, and the drive is found, I can mount it
and do everything. Now, in this particular case, if I unplug the
mini-A connector and plug either the mini-A or mini-B connector,
nothing happens at all.

Why am I only getting interrupts with the mini-B connector and not the
mini-A connector? Additionally, why does everything fail after my
second scenario above?

Regards
~ Ashwin
