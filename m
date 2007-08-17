From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [01/17 PATCH] MMC: OMAP: Introduces new structures for MMC multislot
 support.
Date: Fri, 17 Aug 2007 15:01:33 -0400
Message-ID: <46C5F08D.7070207@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040109020708050207010108"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109020708050207010108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Juha Yrjola <juha.yrjola@solidboot.com>

Introduces new structures for MMC multislot support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

--------------040109020708050207010108
Content-Type: text/plain;
	name*0="0001-MMC-OMAP-Introduce-new-structs-for-mmc-multislot-support.di";
	name*1="ff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-MMC-OMAP-Introduce-new-structs-for-mmc-multislot-suppor";
	filename*1="t.diff"

Introduces new structures for MMC multislot support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap/drivers/mmc/host/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/host/omap.c	2007-08-16 12:26:58.000000000 -0400
+++ linux-omap/drivers/mmc/host/omap.c	2007-08-16 12:27:46.000000000 -0400
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 
 #include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
@@ -99,6 +100,26 @@
 
 static int mmc_omap_enable_poll = 1;
 
+struct mmc_omap_host;
+
+struct mmc_omap_slot {
+	int			id;
+	unsigned int		vdd;
+	u16			saved_con;
+	u16			bus_mode;
+	unsigned int		fclk_freq;
+	unsigned		powered:1;
+
+	struct work_struct	switch_work;
+	struct timer_list	switch_timer;
+	unsigned		cover_open;
+
+	struct mmc_request *	mrq;
+	struct mmc_omap_host *  host;
+	struct mmc_host *	mmc;
+	struct omap_mmc_slot_data *pdata;
+};
+
 struct mmc_omap_host {
 	int			initialized;
 	int			suspended;
@@ -132,13 +153,13 @@ struct mmc_omap_host {
 	struct timer_list	dma_timer;
 	unsigned		dma_len;
 
-	short			power_pin;
-	short			wp_pin;
+	struct mmc_omap_slot *	slots[OMAP_MMC_MAX_SLOTS];
+	struct mmc_omap_slot *	current_slot;
+	spinlock_t		slot_lock;
+	wait_queue_head_t	slot_wq;
+	int			nr_slots;
 
-	int			switch_pin;
-	struct work_struct	switch_work;
-	struct timer_list	switch_timer;
-	int			switch_last_state;
+	struct omap_mmc_platform_data *pdata;
 };
 
 static inline int

--------------040109020708050207010108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040109020708050207010108--
