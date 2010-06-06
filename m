From: "Luke-Jr" <luke@dashjr.org>
Subject: OMAP video compile error; regression from 2.6.33-rc4 onward (including current master)
Date: Sun, 6 Jun 2010 16:52:25 -0500
Message-ID: <201006061652.39248.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@nokia.com, slapin@ossfans.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This doesn't even build, so I don't know how it was tested... Reverting the 
offending commit (simple, but does require conflict resolution) at least lets 
it compile, but I haven't tested whether it alone is enough to work in 
practise yet... hoping Tomi might provide a real fix. Maybe even in time for 
2.6.35 final? :)

https://bugzilla.kernel.org/show_bug.cgi?id=16144

CC      drivers/video/omap/rfbi.o                                               
drivers/video/omap/rfbi.c: In function 'rfbi_get_clocks':                       
drivers/video/omap/rfbi.c:86: error: 'dispc' undeclared (first use in this
function)
drivers/video/omap/rfbi.c:86: error: (Each undeclared identifier is reported
only once
drivers/video/omap/rfbi.c:86: error: for each function it appears in.)          
make[1]: *** [drivers/video/omap/rfbi.o] Error 1                                
make: *** [drivers/video/omap/rfbi.o] Error 2                                   

The 'dispc' referred to herein is and has always been defined in
drivers/video/omap/dispc.c as an anonymous struct.

Broken in...
commit f778a12dd33200513596a0d4d3ba4d5f09e79c09
Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date:   Wed Dec 16 13:18:07 2009 +0200

    OMAP: OMAPFB: fix clk_get for RFBI

    omapfb platform device was still used to get clocks inside rfbi.c

    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
    Tested-by: Sergey Lapin <slapin@ossfans.org>
