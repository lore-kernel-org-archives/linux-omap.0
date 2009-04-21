From: twebb <taliaferro62@gmail.com>
Subject: lcd rotation in omapfb_main.c
Date: Tue, 21 Apr 2009 18:18:54 -0400
Message-ID: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:44467 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbZDUWSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 18:18:55 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1797646ywb.1
        for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 15:18:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm trying to start up the LCD panel on a new omap35xx-based platform
in portrait mode, though the native orientation of the display is
landscape.  I'm running linux-2.6.27-omap1.  However, when I change
"def_rotate" to 90 in omapfb_main.c, it doesn't seem to make any
difference in the orientation of the display.  Any ideas why this
might be happening?  Could there be outstanding fixes/patches I need?

Thanks,
twebb
