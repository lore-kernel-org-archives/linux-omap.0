From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: Update DSS2 patches for latest kernel changes
Date: Wed, 04 Nov 2009 11:25:13 +0200
Message-ID: <1257326713.13331.25.camel@tubuntu.research.nokia.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB692@dbde02.ent.ti.com>
	 <1257238471.13331.2.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E73940436EEB86B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55339 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbZKDJZd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 04:25:33 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEB86B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2009-11-03 at 10:02 +0100, ext Hiremath, Vaibhav wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]

> > Thanks, although I have already done that =). 
> [Hiremath, Vaibhav] I cross-checked your repository and could not find anything there, so I started rebasing it myself.
> 
> Anyway, please let me know once you are done with it.

I'm not done with it yet, but I pushed the current tree, based on
linux-next, to master-new branch in
git://gitorious.org/linux-omap-dss2/linux.git (Actually, it's still
pushing... Either gitorious or Nokia's proxies are really slow today).

That branch has been squashed with all the latest changes. I need to do
more testing, but it seemed to work with a board with a DSI display. SDP
also boots fine, but the LCD has (again) a green tint. And using DSI PLL
for pixel clock didn't seem to work. I guess there's (again) some power
missing. I hope I'll have time next week to go through these.

I was planning to also publish the non-squashed branch, but I seem to
have messed things up a bit and I don't have that branch saved. I can
try harder to find it if someone requests it. But as a hint what's been
changed since the last major squash, here's a list of commit names which
will probably give an idea. Mostly VRFB and DSI things:

Taal: Handle error when initializing panel
Taal: fix too long line
Taal: allow interrupting of memory read
Taal: Implement ESD check
Taal: Add missing field initialization
DSS2: OMAPFB: remove full screen update from SETUP_PLANE ioctl
DSS2: DSI: fix DDR_CLK_POST timing
DSS2: DSI: Add error handling for DSI init
DSS2: Add error print when fclk too low for scaling
DSS2: DSI: define DSI PLL divisors explicitely
DSS2: restructure clock handling and improve clk debug prints
DSS2: OMAPFB: Fix VRFB and mode changing
DSS2: VRFB: Add yuv_mode flag to vrfb data
DSS2: DSI: increase HS_TX timeout
DSS2: Disable all devices on shutdown
DSS2: Add timeouts to SDI PLL programming
DSS2: OMAPFB: implement OMAPFB_SET_TEARSYNC ioctl
DSS2: OMAPFB: Fix OMAPFB_GET_CAPS ioctl
DSS2: Add OMAP_DSS_DISPLAY_CAP_TEAR_ELIM display capability
DSS2: DSI: Adjust line buffer usage
DSS2: DSI: Adjust fifo thresholds to more optimal
DSS2: DSI: handle errors in dsi_init()
DSS2: DSI: fix problem with odd update widths
DSS2: DSI: fix checkpatch error
DSS2: OMAPFB: return error value from update_window ioctl
DSS2: Export omapfb_update_window for SGX driver use
DSS2: DSI: configure DSI_PLL_FREQSEL properly
DSS2: DSI: print possible DSI errors after framedone
DSS2: DSI: Fix set_update_mode
DSS2: DSI: make a better job in calculating DSI timeouts
DSS2: DSI: Calculate pck properly from TxByteClkHS
DSS2: Add more clock debug prints
DSS2: DSI: re-set update area after memory read
DSS2: DSI: Send BTA after set_max_rx_packet_size
DSS2: DSI: Add TX fifo reset when timeout happens
DSS2: add missing function prototype to omapfb.h
DSS2: DSI: Add functionality to catch missing TE
DSS2: DISPC: flush posted write in irq handler
DSS2: DSI: flush posted writes in irq handler
DSS2: add missing parenthesis for macros
DSS2: DSI: fix unnecessary framedone timeout
DSS2: OMAPFB: VRFB fixes
DSS2: VRFB: fix compilation when DEBUG defined
DSS2: OMAPFB: Setup VRFB before mapping rotated views
DSS2: OMAPFB: Separate VRFB setup from fixed parameter setup
DSS2: VRFB: Store the resolution for the context
DSS2: VRFB: Provide means for mapping the rotated views
DSS2: VRFB: Reduce the physical memory requirement
DSS2: OMAPFB: Consult VRFB for framebuffer size requirements
DSS2: VRFB: Provide memory requirements for given resolution
DSS2: OMAPFB: Split triggering of resizing into a new function
DSS2: OMAPFB: Split resolution reduction into separate functions
DSS2: OMAPFB: Split resolution bounds checking into a new function
DSS2: Reject invalid color modes
DSS2: Add RGB12U where appropriate
DSS2: OMAPFB: Remove unused variable
DSS2: Remove useless checks from pan_display
DSS2: Add symbolic names for rotation angles
DSS2: Advertise only the supported color modes
DSS2: Add some OMAP2 checks
DSS2: Add color_mode_to_bpp() helper
DSS2: remove VRFB suspend/resume

 Tomi



