From: Joachim Eastwood <manabian@gmail.com>
Subject: OMAPDSS and panel-dpi
Date: Thu, 17 Apr 2014 20:04:56 +0200
Message-ID: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:60890 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbaDQSE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 14:04:59 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so654942lab.20
        for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2014 11:04:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

My VAR-DVK-OM44 (OMAP4460) has both a HDMI and a LCD panel. As HDMI is
now working (thanks) I also taken a look at panel-dpi.

I found the DT patch for panel-dpi on the mailing list.
OMAPDSS: panel-dpi: Add DT support:
http://marc.info/?l=devicetree&m=139030201815380&w=2

And I got my display working with DT :)
So you add can my: Tested-by: Joachim Eastwood <manabian@gmail.com>

Could you upstream the panel-dpi DT support and the HDMI connector
gpio hpd patch in 3.16?
I hope it's easier to upstream the stuff when it gets some users in DT.

I will soon post my updated patches for the Variscite STK and DVK
boards, but for the display stuff to work they depend on the patches
mention above. It would also be nice if you could take a look at the
DT display nodes so I'll CC you on the set.

regards
Joachim Eastwood
