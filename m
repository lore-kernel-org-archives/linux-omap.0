From: Tony Lindgren <tony@atomide.com>
Subject: Multiple issues with omap4 panda es in linux next
Date: Fri, 19 Apr 2013 10:13:19 -0700
Message-ID: <20130419171318.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28025 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259Ab3DSRNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 13:13:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

Hi all,

Here's a list of breakage I've noticed so far while trying to
use linux next on my pandaboard es. Probably similar issues exist
on other boards as well.

Ideally we would not have any breakage by the merge window, so
let's try to get these fixed ASAP:

1. Serial console broken on panda es booting with DT

The symptoms are dmesg output stopping after few lines
and only continuing after pressing a key. Does not seem to
happen on blaze with DT for some reason. And does not happen
on panda es with legacy booting.

2. MUSB fails with legacy booting and DT on panda es

With both legacy and DT booting I get something like:

HS USB OTG: no transceiver configured
musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

3. DSS fails with DT booting

Works with legacy booting but fails with DT. I'm almost certain
the DT booting was working last week or so?

This is what I now get with DT booting:

omapdss DSI error: can't get VDDS_DSI regulator
omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
omapdss HDMI error: device hdmi init failed: -517
omapdss CORE error: driver probe failed: -22
...

4. WLAN with wl12xx fails with both legacy and DT booting

No real output here with the legacy mode, just the usual
using pinctrl dummy state warning.

Regards,

Tony
