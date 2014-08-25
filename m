From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: Rearm wake-up interrupts for DT when
 MUSB is idled
Date: Mon, 25 Aug 2014 10:14:47 -0700
Message-ID: <20140825171446.GL17254@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16600 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932253AbaHYROy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2014 13:14:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

Looks like MUSB cable removal can cause wake-up interrupts to
stop working for device tree based booting at least for UART3
even as nothing is dynamically remuxed. This can be fixed by
calling reconfigure_io_chain() for device tree based booting
in hwmod code. Note that we already do that for legacy booting
if the legacy mux is configured.

My guess is that this is related to UART3 and MUSB ULPI
hsusb0_data0 and hsusb0_data1 support for Carkit mode that
somehow affect the configured IO chain for UART3 and require
rearming the wake-up interrupts.

In general, for device tree based booting, pinctrl-single
calls the rearm hook that in turn calls reconfigure_io_chain
so calling reconfigure_io_chain should not be needed from the
hwmod code for other events.

So let's limit the hwmod rearming of iochain only to
HWMOD_FORCE_MSTANDBY where MUSB is currently the only user
of it. If we see other devices needing similar changes we can
add more checks for it.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2185,6 +2185,8 @@ static int _enable(struct omap_hwmod *oh)
 			 oh->mux->pads_dynamic))) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 		_reconfigure_io_chain();
+	} else if (oh->flags & HWMOD_FORCE_MSTANDBY) {
+		_reconfigure_io_chain();
 	}
 
 	_add_initiator_dep(oh, mpu_oh);
@@ -2291,6 +2293,8 @@ static int _idle(struct omap_hwmod *oh)
 	if (oh->mux && oh->mux->pads_dynamic) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
 		_reconfigure_io_chain();
+	} else if (oh->flags & HWMOD_FORCE_MSTANDBY) {
+		_reconfigure_io_chain();
 	}
 
 	oh->_state = _HWMOD_STATE_IDLE;
