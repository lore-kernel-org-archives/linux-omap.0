From: Michael Welling <mwelling@ieee.org>
Subject: Re: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Mon, 11 May 2015 15:16:33 -0500
Message-ID: <20150511201633.GA31117@deathray>
References: <5550DDCB.8010303@ti.com>
 <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com>
 <20150511183032.GA8085@deathray>
 <5550FC38.6020801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36017 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbbEKUQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 16:16:39 -0400
Content-Disposition: inline
In-Reply-To: <5550FC38.6020801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-spi@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 02:00:08PM -0500, Nishanth Menon wrote:
> On 05/11/2015 01:30 PM, Michael Welling wrote:
> > On Mon, May 11, 2015 at 01:27:08PM -0500, Nishanth Menon wrote:
> >> On 05/11/2015 12:07 PM, Michael Welling wrote:
> >>> On Mon, May 11, 2015 at 11:50:19AM -0500, Nishanth Menon wrote:
> >>>> Hi,
> >>>>
> >>>> SDP4430 uses a SPI based network chip ks8851.
> >>>>
> >>>> next-20150508:
> >>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt
> >>>>
> >>>> However, next-20150511:
> >>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt
> >>>>
> >>>
> >>> I will look into this but it is going to be difficult to debug with access to the hardware.
> >>> This is what I get for changing a driver that effects so many SoCs.
> >>>
> >>
> >> Let me know if there is any test patch you'd want me to run. The board
> >> is on a remote "board farm" which most of TI folks have access to as
> >> well.. So, if you need anything run, just send out a debug patch OR a
> >> potential fix and we can help try it out and provide logs back for
> >> your debug.
> > 
> > Okay.
> > 
> > It looks like you revert the patches in the wrong order above.
> > 
> > The GPIO patch should apply after the transfer_one patch so it should
> > logically be reverted in the reverse order.
> > 
> Apologies on a slow response, was tracking another LPAE regression down.
> 
> I did do that -> but logged it in reverse - unfortunately it seems to
> have caused a little more confusion :(. is there something else you'd
> like me to do?

Okay I have another patch that appears to fix the issue on my board.

Please test the attached patch and see if it fixes the issue on your board.

If it does, I will send it upstream.

> 
> git log  next-20150508..next-20150511 drivers/spi
> Tells me:
> 
> commit bc7f9bbc80bcc77745b3f54ec4e7103e3e142bb9
> Author: Michael Welling <mwelling@ieee.org>
> Date:   Fri May 8 13:31:01 2015 -0500
> 
>     spi: omap2-mcspi: Add gpio_request and init CS
> 
>     If GPIO chip select is specified, request the GPIO in the setup
> function
>     and release it in the cleanup function.
> 
>     Signed-off-by: Michael Welling <mwelling@ieee.org>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> commit b28cb9414db9f8e42ac18c9e360e4e99cda42489
> Author: Michael Welling <mwelling@ieee.org>
> Date:   Thu May 7 18:36:53 2015 -0500
> 
>     spi: omap2-mcspi: Switch driver to use transfer_one
> 
>     Switches from transfer_one_message to transfer_one to prepare
> driver for
>     use of GPIO chip selects.
> 
>     Signed-off-by: Michael Welling <mwelling@ieee.org>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> 
> 
> my tested git log looks as follows: (redid it just to be sure):
> 
> a4617b41e04c Revert "spi: omap2-mcspi: Switch driver to use transfer_one"
> http://paste.ubuntu.org.cn/2595136
> 
> b49011271c7f Revert "spi: omap2-mcspi: Add gpio_request and init CS"
> http://paste.ubuntu.org.cn/2595142
> 
> 
> 012034602bd6 HACK: Makefile: Build a uImage with dtb already appended
> f17107cb8886 Add linux-next specific files for 20150511
> 
> 012034602bd6 commit is
> https://github.com/nmenon/linux-2.6-playground/commit/177f5f71b3f2 ->
> for legacy platforms needing uImage based booting.
> 
> -- 
> Regards,
> Nishanth Menon

--NzB8fVQJ5HfG6fxh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="omap-mcspi.patch"

GPIO chip select patch series appears to have broken the native chip select
support. This patch pulls the manual native chip select toggling out of
the transfer_one routine and adds a set_cs routine.

Tested natively on AM3354 with SPI serial flash on spi0cs0.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 90cf7e7..a7d85c5 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -243,17 +243,20 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 	mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
 }
 
-static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
+static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 l;
 
-	l = mcspi_cached_chconf0(spi);
-	if (cs_active)
-		l |= OMAP2_MCSPI_CHCONF_FORCE;
-	else
-		l &= ~OMAP2_MCSPI_CHCONF_FORCE;
+	if (spi->controller_state) {
+		l = mcspi_cached_chconf0(spi);
 
-	mcspi_write_chconf0(spi, l);
+		if (enable)
+			l &= ~OMAP2_MCSPI_CHCONF_FORCE;
+		else
+			l |= OMAP2_MCSPI_CHCONF_FORCE;
+
+		mcspi_write_chconf0(spi, l);
+	}
 }
 
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
@@ -1075,7 +1078,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 
 	struct spi_master		*master;
 	struct omap2_mcspi_dma		*mcspi_dma;
-	int				cs_active = 0;
 	struct omap2_mcspi_cs		*cs;
 	struct omap2_mcspi_device_config *cd;
 	int				par_override = 0;
@@ -1118,11 +1120,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
 	}
 
-	if (!cs_active) {
-		omap2_mcspi_force_cs(spi, 1);
-		cs_active = 1;
-	}
-
 	chconf = mcspi_cached_chconf0(spi);
 	chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
 	chconf &= ~OMAP2_MCSPI_CHCONF_TURBO;
@@ -1169,12 +1166,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 	if (t->delay_usecs)
 		udelay(t->delay_usecs);
 
-	/* ignore the "leave it on after last xfer" hint */
-	if (t->cs_change) {
-		omap2_mcspi_force_cs(spi, 0);
-		cs_active = 0;
-	}
-
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (mcspi->fifo_depth > 0)
@@ -1187,9 +1178,6 @@ out:
 		status = omap2_mcspi_setup_transfer(spi, NULL);
 	}
 
-	if (cs_active)
-		omap2_mcspi_force_cs(spi, 0);
-
 	if (cd && cd->cs_per_word) {
 		chconf = mcspi->ctx.modulctrl;
 		chconf |= OMAP2_MCSPI_MODULCTRL_SINGLE;
@@ -1334,6 +1322,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->auto_runtime_pm = true;
 	master->transfer_one = omap2_mcspi_transfer_one;
+	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
-- 
1.7.9.5


--NzB8fVQJ5HfG6fxh--
