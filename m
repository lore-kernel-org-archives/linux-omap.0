From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: [RESEND][PATCH]Separate out 3430 LCD panel support from 2430
 file
Date: Fri, 4 Jul 2008 07:13:26 -0500
Message-ID: <DFEF307E035C8647B119E6A60DB62D4AE483AE25@dlee02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BFE70AA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:50552 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbYGDMNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 08:13:38 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BFE70AA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, Iqbal <iqbal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Emailing the fix on behalf of Iqbal:

> -----Original Message-----
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gadiyar, Anand
> Subject: RE: [RESEND][PATCH]Separate out 3430 LCD panel
> support from 2430 file
>
> > * iqbal@ti.com <iqbal@ti.com> [080702 15:25]:
> > > From: Iqbal Shareef <iqbal@ti.com>
> > >
> > > Separate out 3430 LCD panel support from 2430 SDP.
> > >
> > > Currently the support for the LCD on 3430SDP is added in
> > the lcd_2430sdp.c
> > > file. This patch separates it out to a new file.
> >
> > Pushing today.
> >
> > Tony
>
> This one breaks compile on 3430. Will see if I can send a fix.

----< Cut here >-------

From: Iqbal Shareef <iqbal@ti.com>

Fix SDP 3430 compile error

The PM_RECEIVER macro is replaced with TWL4030_MODULE_PM_RECEIVER

Signed-off-by: Iqbal Shareef  <iqbal@ti.com>
---
 drivers/video/omap/lcd_3430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_3430sdp.c b/drivers/video/omap/lcd_3430sdp.c
index 20ac0e5..6e7a8b6 100644
--- a/drivers/video/omap/lcd_3430sdp.c
+++ b/drivers/video/omap/lcd_3430sdp.c
@@ -70,7 +70,7 @@ static int sdp3430_panel_enable(struct lcd_panel *panel)
        if (0 != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
                                        TWL4030_VAUX3_DEDICATED))
                return -EIO;
-       if (0 != twl4030_i2c_write_u8(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
+       if (0 != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
                                        TWL4030_VAUX3_DEV_GRP))
                return -EIO;

--
1.5.3.2
