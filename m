From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 1/3] driver: spi: Modify core to compute the message length
Date: Mon, 8 Jul 2013 19:12:58 +0530
Message-ID: <1373290980-17883-2-git-send-email-sourav.poddar@ti.com>
References: <1373290980-17883-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1373290980-17883-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Make spi core calculate the message length while
populating the other transfer parameters. This will
be useful in cases where controller driver need to configure its 
framelength field without iterating through the linklist again in the
driver controller.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi.c       |    1 +
 include/linux/spi/spi.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 32b7bb1..6a05b3c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1375,6 +1375,7 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	 * it is not set for this transfer.
 	 */
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		message->frame_length += xfer->len;
 		if (!xfer->bits_per_word)
 			xfer->bits_per_word = spi->bits_per_word;
 		if (!xfer->speed_hz)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6ff26c8..d83841e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -575,6 +575,7 @@ struct spi_message {
 	/* completion is reported through a callback */
 	void			(*complete)(void *context);
 	void			*context;
+	unsigned		frame_length;
 	unsigned		actual_length;
 	int			status;
 
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
