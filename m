From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V3 0/3] OMAPDSS: DISPC: Enable predecimation for DMA and VRFB
Date: Mon, 2 Apr 2012 20:43:15 +0530
Message-ID: <1333379598-11544-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59853 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab2DBPN2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 11:13:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
the following patch set directs to enable predecimation for DMA and VRF=
B
which consists of two pacthes.

The first patch is based on code written by Lajos Molnar <lajos@ti.com>=
 in
Android Kernel, which updates the code with predecimation logic thereby
increasing the downscaling ability of the DISPC module.

The second patch is based on code written by Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@nokia.com> which aims to avoid synclost errors occurring
in OMAP3 due to some undocumented horizontal position and timing relate=
d
limitations which I faced during testing of the previous patch.

The third patch corrects the usage of dispc fclk in scaling checks by
replacing it with dispc_core_clk as per suggestions of Ville Syrj=C3=A4=
l=C3=A4.

Modifications in V3 series:
* In 1st patch a check for decim_x_min has been added to avoid assignin=
g of
decim_x less than possible leading to assignment of scaling more than 4=
 times
* In 2nd patch=20
 -> check_horiz_timing() has been changed to check_horiz_timing_omap3()=
 and
	function description in code has been added
 -> clean up code of dispc_mgr_lclk_rate() has been removed
*  In 3rd patch dispc_core_clk_rate() is introduced.

I have tested these patches successfully on OMAP2, OMAP3 AND OMAP4 on t=
he
mainline kernel v3.4rc1. Horizontal and vertical predecimation worked f=
ine
but skewed images were seen on OMAP2 and OMAP3 on HDMI tv during horizo=
ntal
predecimation which will be addressed in the future patches.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (3):
  OMAPDSS: DISPC: Enable predecimation
  OMAPDSS: DISPC: Handle synclost errors in OMAP3
  OMAPDSS: DISPC: Correct DISPC functional clock usage

 drivers/video/omap2/dss/dispc.c |  354 +++++++++++++++++++++++++++++--=
-------
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 271 insertions(+), 84 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
