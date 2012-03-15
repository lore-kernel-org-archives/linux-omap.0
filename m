From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 0/2] OMAPDSS: DISPC: Enable predecimation for DMA and VRFB
Date: Thu, 15 Mar 2012 17:18:03 +0530
Message-ID: <1331812083-9739-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43946 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761705Ab2COLsR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 07:48:17 -0400
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

I have tested these patches successfully on OMAP2, OMAP3 AND OMAP4 on t=
he
mainline kernel v3.3-rc5. Horizontal and vertical predecimation worked =
fine
but skewed images along with underflow errors were seen on OMAP2 and OM=
AP3
during horizontal predecimation which will be addressed in the future p=
atches.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (2):
  OMAPDSS: DISPC: Enable predecimation
  OMAPDSS: DISPC: Handle synclost errors in OMAP3

 drivers/video/omap2/dss/dispc.c |  323 +++++++++++++++++++++++++++++--=
--------
 1 files changed, 242 insertions(+), 81 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
