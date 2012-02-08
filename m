From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/16] rmk's patch series for fixing OMAP
Date: Wed, 8 Feb 2012 16:35:47 +0000
Message-ID: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39301 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab2BHQfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:35:55 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Samuel Ortiz <sameo@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

This is my set of patches for fixing OMAP for v3.3.

This is the complete series of patches I'm currently applying to _my_
tree to get v3.3-rc2 into a usable and sane state.

I want to see most of the problems uncovered in this series fixed sooner
rather than later, and certainly not taking three plus weeks to get into
mainline like this rather serious looking commit did:

commit c49d005b6cc8491fad5b24f82805be2d6bcbd3dd
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Tue Jan 17 11:09:57 2012 +0200

    OMAPDSS: HDMI: PHY burnout fix
    
    A hardware bug in the OMAP4 HDMI PHY causes physical damage to the board
    if the HDMI PHY is kept powered on when the cable is not connected.

which now has me wondering if, by trying to boot v3.3-rc2 on this board
during the past week, I have a destroyed HDMI interface on it.

So, a big thanks for sitting on that fix and exposing peoples hardware
to damage, that shows real professionalism.
