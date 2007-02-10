From: tony@atomide.com
Subject: Re: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Sat, 10 Feb 2007 11:08:45 -0800
Message-ID: <20070210190845.GA19642@atomide.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
	<20070209165157.GB22121@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>
	<20070210174121.GA5291@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070210174121.GA5291@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [070210 09:42]:
> * Woodruff, Richard <r-woodruff2@ti.com> [070209 13:48]:
> > Hi,
> > 
> > So took a quick look with the emulator and see its hanging in MMC.  I'm
> > not an MMC expert but I don't see how you can send an init-stream
> > command with no clocks running and if you did it looks like it should be
> > 80clocks over 1ms.
> > 
> > The note in the upper layer in mmc.c says you power it first, then send
> > clocks out.  mmc.c calls MMC_POWER_UP twice.  The first time with
> > ios->clock = 0 and a second time with iso->clock=f_min.  To me that just
> > says set the power bit in the first pass and set the initstream command
> > in the second pass.
> > 
> > The below patch seems to work fine and would appear to be a long
> > standing bug.
> > 
> > Signed-off-by: Richard Woodruff <r-woodruff2.com>
> > 
> > diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
> > index 796172a..55075cc 100644
> > --- a/drivers/mmc/omap.c
> > +++ b/drivers/mmc/omap.c
> > @@ -990,7 +990,7 @@ static void mmc_omap_set_ios(struct mmc_
> >  	 * Writing to the CON register twice seems to do the trick. */
> >  	for (i = 0; i < 2; i++)
> >  		OMAP_MMC_WRITE(host, CON, dsor);
> > -	if (ios->power_mode == MMC_POWER_UP) {
> > +	if ((ios->power_mode == MMC_POWER_UP) && ios->clock) {
> >  		/* Send clock cycles, poll completion */
> >  		OMAP_MMC_WRITE(host, IE, 0);
> >  		OMAP_MMC_WRITE(host, STAT, 0xffff);
> > 
> 
> Thanks. Looks like we're still doing the MMC powerup wrong for omap
> though. I made a patch for that a while back but it got forgotten
> for some reason:
> 
> http://lkml.org/lkml/2006/5/4/44
> 
> I'll refresh that patch so we can make sure it works on all platforms.

Here are the refreshed patches to try.

Regards,

Tony

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename="0001-MMC-Fix-omap-to-use-MMC_POWER_ON.txt"

>From fa6a7886da554980d7a250fc7232b8ed40168baf Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Sat, 10 Feb 2007 10:35:03 -0800
Subject: MMC: OMAP: Fix omap to use MMC_POWER_ON

As discussed earlier on LKML:

http://lkml.org/lkml/2006/5/4/44

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 796172a..7cc8972 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -973,8 +973,10 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		mmc_omap_power(host, 0);
 		break;
 	case MMC_POWER_UP:
-	case MMC_POWER_ON:
+		/* Cannot touch dsor yet, just power up MMC */
 		mmc_omap_power(host, 1);
+		return;
+	case MMC_POWER_ON:
 		dsor |= 1 << 11;
 		break;
 	}
@@ -990,7 +992,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * Writing to the CON register twice seems to do the trick. */
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
-	if (ios->power_mode == MMC_POWER_UP) {
+	if (ios->power_mode == MMC_POWER_ON) {
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host, IE, 0);
 		OMAP_MMC_WRITE(host, STAT, 0xffff);
-- 
1.4.4.2


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0002-MMC-Clean-up-omap-set_ios.txt"

>From 6e580793454d53e012e53581991dc54375c54143 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Sat, 10 Feb 2007 10:40:31 -0800
Subject: MMC: OMAP: Clean up omap set_ios and make MMC_POWER_ON work

Move divisor calculation into a separate function and
re-arrange the init order to make MMC_POWER_ON work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/omap.c |   47 ++++++++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 7cc8972..2ae4c1b 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -940,33 +940,41 @@ static void mmc_omap_power(struct mmc_omap_host *host, int on)
 	}
 }
 
-static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+static int mmc_omap_calc_divisor(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
+	int func_clk_rate = clk_get_rate(host->fclk);
 	int dsor;
-	int realclock, i;
-
-	realclock = ios->clock;
 
 	if (ios->clock == 0)
-		dsor = 0;
-	else {
-		int func_clk_rate = clk_get_rate(host->fclk);
-
-		dsor = func_clk_rate / realclock;
-		if (dsor < 1)
-			dsor = 1;
+		return 0;
 
-		if (func_clk_rate / dsor > realclock)
-			dsor++;
+	dsor = func_clk_rate / ios->clock;
+	if (dsor < 1)
+		dsor = 1;
 
-		if (dsor > 250)
-			dsor = 250;
+	if (func_clk_rate / dsor > ios->clock)
 		dsor++;
 
-		if (ios->bus_width == MMC_BUS_WIDTH_4)
-			dsor |= 1 << 15;
-	}
+	if (dsor > 250)
+		dsor = 250;
+	dsor++;
+
+	if (ios->bus_width == MMC_BUS_WIDTH_4)
+		dsor |= 1 << 15;
+
+	return dsor;
+}
+
+static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	int dsor;
+	int i;
+
+	dsor = mmc_omap_calc_divisor(mmc, ios);
+	host->bus_mode = ios->bus_mode;
+	host->hw_bus_mode = host->bus_mode;
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
@@ -981,9 +989,6 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	host->bus_mode = ios->bus_mode;
-	host->hw_bus_mode = host->bus_mode;
-
 	clk_enable(host->fclk);
 
 	/* On insanely high arm_per frequencies something sometimes
-- 
1.4.4.2


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ--
