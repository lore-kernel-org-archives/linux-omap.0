From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 0/3] OMAPDSS: DISPC: Enable predecimation for DMA and VRFB
Date: Wed, 21 Mar 2012 15:21:24 +0530
Message-ID: <1332323484-8975-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48108 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757624Ab2CUJvf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:51:35 -0400
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
In version 2 patch description has been modified include reason for max=
imum
predecimation limit of 16.

The second patch is based on code written by Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@nokia.com> which aims to avoid synclost errors occurring
in OMAP3 due to some undocumented horizontal position and timing relate=
d
limitations which I faced during testing of the previous patch.
In version 2 the pcd factor has been replaced lclk / pclk to support HD=
MI and
tv output as pointed out by Ville Syrj=C3=A4l=C3=A4.

The third patch corrects the usage of dispc fclk in scaling checks by
replacing it with dispc_core_clk as per suggestions of Ville Syrj=C3=A4=
l=C3=A4.

I have tested these patches successfully on OMAP2, OMAP3 AND OMAP4 on t=
he
mainline kernel v3.3. Horizontal and vertical predecimation worked fine
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

 drivers/video/omap2/dss/dispc.c |  360 +++++++++++++++++++++++++++----=
--------
 1 files changed, 254 insertions(+), 106 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
