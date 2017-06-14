From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia N900
Date: Thu, 15 Jun 2017 01:11:33 +0300
Message-ID: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and there
is no display.

Bisected to:

a09d2bc1503508c17ef3a71c6b1905e3660f3029 is the first bad commit
commit a09d2bc1503508c17ef3a71c6b1905e3660f3029
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Tue May 3 22:08:01 2016 +0300

    drm/omap: Use omapdss_stack_is_ready() to check that the display stack is up
    
    Instead of 'guessing' based on aliases of the status of the DSS drivers,
    use the new interface to check that all needed drivers are loaded.
    In this way we can be sure that all needed drivers are loaded so it is
    safe to continue the probing of omapdrm.
    This method will allow the omapdrm to be probed 'headless', without
    outputs.
    
    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reverting the commit seems to fix the issue.

A.
