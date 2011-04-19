From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: The old omapfb support
Date: Tue, 19 Apr 2011 15:20:26 +0300
Message-ID: <1303215626.32281.70.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51548 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754995Ab1DSMUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 08:20:31 -0400
Received: by mail-ew0-f48.google.com with SMTP id 22so1786671ewy.7
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 05:20:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, lo-ml <linux-omap@vger.kernel.org>

Hi Tony, All,

Due to the recent SRAM discussion I started removing SRAM support from
the new omapdss and omapfb driver, which was quite a simple task. Then I
realized that the old omapfb driver also contains SRAM code, removing of
which which wasn't such a simple task. I think I got that solved, but it
needs still cleaning up.

But this again reminded me of the mess of having two display drivers,
the old omapfb and the new DSS2. Many of the OMAP2 boards using the old
driver should be quite easy to port to DSS2, with the exception of N800.
DSS2 doesn't support OMAP1, so there's not much that can be done with
those boards currently.

What is the status of OMAP1 support in general? Is having a working
framebuffer for OMAP1 boards something we need? 

Will there be a single kernel config containing OMAP1 and OMAP2+ support
in the future? This will cause problems, as the old and new display
drivers cannot coexist currently.

I have never worked with an OMAP1 board, and I don't own one, and thus I
don't have any experience on OMAP1 display HW. This will make any work I
do on OMAP1 omapfb slightly difficult, but if there's clear need for
OMAP1 fb, then I think the only way to go is to convert the old omapfb
driver to an OMAP1 framebuffer driver.

But whatever is decided on OMAP1 fb, I'll start converting the OMAP2
drivers to the new DSS2.

 Tomi


