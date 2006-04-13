From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: omap mmc build errors
Date: Thu, 13 Apr 2006 08:17:56 -0700 (PDT)
Message-ID: <20060413151756.47512.qmail@web32901.mail.mud.yahoo.com>
References: <443BAD8C.4090005@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-11933500-1144941476=:44708"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <443BAD8C.4090005@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-11933500-1144941476=:44708
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:

> Hi Komal and folks,
> 
> You have to apply a patch that Tony sent to the list 7 days ago. This
> 
> patch corrects the bugs mentioned above. Attached to this mail follow
> 

You still need the attached patch on top of the Tony's patch to build
it successfully.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-11933500-1144941476=:44708
Content-Type: text/x-patch; name="0001-Fix-OMAP-MMC-build.patch"
Content-Description: 1285005175-0001-Fix-OMAP-MMC-build.patch
Content-Disposition: inline; filename="0001-Fix-OMAP-MMC-build.patch"

>From nobody Mon Sep 17 00:00:00 2001
From: Komal Shah <komal_shah802003@yahoo.com>
Date: Thu Apr 13 16:57:34 2006 +0300
Subject: [PATCH] Fix OMAP MMC build.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/mmc/omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

43101f1398ea8610afc366c297ba18b3441bd7a0
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 63e4a7b..1ef94fb 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -341,8 +341,6 @@
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
 	int n;
-	void __iomem *reg;
-	u16 *p;
 
 	if (host->buffer_bytes_left == 0) {
 		host->sg_idx++;
@@ -659,8 +657,8 @@
 	struct mmc_data *mmcdat = host->data;
 
 	if (unlikely(host->dma_ch < 0)) {
-		dev_err(mmc_dev(host->mmc), "DMA callback while DMA not
-				enabled\n");
+		dev_err(mmc_dev(host->mmc), "DMA callback while DMA not"
+				"enabled\n");
 		return;
 	}
 	/* FIXME: We really should do something to _handle_ the errors */
@@ -1060,8 +1058,8 @@
 
 	if (host->power_pin >= 0) {
 		if ((ret = omap_request_gpio(host->power_pin)) != 0) {
-			dev_err(mmc_dev(host->mmc), "Unable to get GPIO
-					pin for MMC power\n");
+			dev_err(mmc_dev(host->mmc), "Unable to get GPIO"
+					"pin for MMC power\n");
 			goto out;
 		}
 		omap_set_gpio_direction(host->power_pin, 0);
-- 
1.3-rc1.GIT


--0-11933500-1144941476=:44708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-11933500-1144941476=:44708--
