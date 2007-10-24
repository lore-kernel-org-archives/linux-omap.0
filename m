From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 4/4] OMAP: DMA: Added support for DMA chaining
Date: Wed, 24 Oct 2007 12:40:21 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804AF986A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Added support for DMA chaining.
This patch depends on patches [1-3]
"OMAP: DMA: Cleanup of DMA Request Lines",
"OMAP: DMA: Added support for OMAP3" and=20
"OMAP: DMA: Added utility APIs for setting DMA global parameters".

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/plat-omap/dma.c        |  708 =
+++++++++++++++++++++++++++++++++++++++-
 include/asm-arm/arch-omap/dma.h |   39 ++
 2 files changed, 745 insertions(+), 2 deletions(-)

Index: omap-git/arch/arm/plat-omap/dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- omap-git.orig/arch/arm/plat-omap/dma.c	2007-10-23 03:28:51.072585880 =
-0400
+++ omap-git/arch/arm/plat-omap/dma.c	2007-10-23 03:30:06.524115504 =
-0400
@@ -41,6 +41,14 @@
 #define	debug_printk(x)
 #endif
=20
+#ifndef CONFIG_ARCH_OMAP1
+enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
+	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
+};
+
+enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
+#endif
+
 #define OMAP_DMA_ACTIVE		0x01
 #define OMAP_DMA_CCR_EN		(1 << 7)
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
@@ -57,9 +65,66 @@
 	const char *dev_name;
 	void (* callback)(int lch, u16 ch_status, void *data);
 	void *data;
+
+#ifndef CONFIG_ARCH_OMAP1
+	/* required for Dynamic chaining */
+	int prev_linked_ch;
+	int next_linked_ch;
+	int state;
+	int chain_id;
+
+	int status;
+#endif
 	long flags;
 };
=20
+#ifndef CONFIG_ARCH_OMAP1
+struct dma_link_info {
+	int *linked_dmach_q;
+	int no_of_lchs_linked;
+
+	int q_count;
+	int q_tail;
+	int q_head;
+
+	int chain_state;
+	int chain_mode;
+
+};
+
+static struct dma_link_info dma_linked_lch[OMAP_LOGICAL_DMA_CH_COUNT];
+
+/* Chain handling macros */
+#define OMAP_DMA_CHAIN_QINIT(chain_id)					\
+	do {								\
+		dma_linked_lch[chain_id].q_head =3D			\
+		dma_linked_lch[chain_id].q_tail =3D			\
+		dma_linked_lch[chain_id].q_count =3D 0;			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
+		(dma_linked_lch[chain_id].no_of_lchs_linked =3D=3D		\
+		dma_linked_lch[chain_id].q_count)
+#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
+	do {								\
+		((dma_linked_lch[chain_id].no_of_lchs_linked-1) =3D=3D	\
+		dma_linked_lch[chain_id].q_count)			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
+		(0 =3D=3D dma_linked_lch[chain_id].q_count)
+#define __OMAP_DMA_CHAIN_INCQ(end)					\
+	((end) =3D ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
+#define OMAP_DMA_CHAIN_INCQHEAD(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
+		dma_linked_lch[chain_id].q_count--;			\
+	} while (0)
+
+#define OMAP_DMA_CHAIN_INCQTAIL(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_tail);	\
+		dma_linked_lch[chain_id].q_count++; \
+	} while (0)
+#endif
 static int dma_chan_count;
=20
 static spinlock_t dma_chan_lock;
@@ -73,6 +138,10 @@
 	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
 };
=20
+static inline void disable_lnk(int lch);
+static void omap_disable_channel_irq(int lch);
+static inline void omap_enable_channel_irq(int lch);
+
 #define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
 						__FUNCTION__);
=20
@@ -467,6 +536,12 @@
 	if (dma_chan[lch].next_lch !=3D -1)
 		OMAP_DMA_CLNK_CTRL_REG(lch) =3D
 			dma_chan[lch].next_lch | (1 << 15);
+
+#ifndef CONFIG_ARCH_OMAP1
+	if (dma_chan[lch].next_linked_ch !=3D -1)
+		OMAP_DMA_CLNK_CTRL_REG(lch) =3D
+			dma_chan[lch].next_linked_ch | (1 << 15);
+#endif
 }
=20
 static inline void disable_lnk(int lch)
@@ -533,6 +608,9 @@
 	chan->dev_name =3D dev_name;
 	chan->callback =3D callback;
 	chan->data =3D data;
+#ifndef CONFIG_ARCH_OMAP1
+	chan->chain_id =3D -1;
+#endif
 	chan->enabled_irqs =3D OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
=20
 	if (cpu_class_is_omap1())
@@ -923,6 +1001,607 @@
 	dma_chan[lch_head].next_lch =3D -1;
 }
=20
+#ifndef CONFIG_ARCH_OMAP1
+/* Create chain of DMA channesls */
+static void create_dma_lch_chain(int lch_head, int lch_queue)
+{
+	u32 w;
+
+	/* Check if this is the first link in chain */
+	if (dma_chan[lch_head].next_linked_ch =3D=3D -1) {
+		dma_chan[lch_head].next_linked_ch =3D lch_queue;
+		dma_chan[lch_head].prev_linked_ch =3D lch_queue;
+		dma_chan[lch_queue].next_linked_ch =3D lch_head;
+		dma_chan[lch_queue].prev_linked_ch =3D lch_head;
+	}
+
+	/* a link exists, link the new channel in circular chain */
+	else {
+		dma_chan[lch_queue].next_linked_ch =3D
+					dma_chan[lch_head].next_linked_ch;
+		dma_chan[lch_queue].prev_linked_ch =3D lch_head;
+		dma_chan[lch_head].next_linked_ch =3D lch_queue;
+		dma_chan[dma_chan[lch_queue].next_linked_ch].prev_linked_ch =3D
+					lch_queue;
+	}
+
+	w =3D OMAP_DMA_CLNK_CTRL_REG(lch_head);
+	w &=3D ~(0x0f);
+	w |=3D lch_queue ;
+	OMAP_DMA_CLNK_CTRL_REG(lch_head) =3D w;
+
+	w =3D OMAP_DMA_CLNK_CTRL_REG(lch_queue);
+	w &=3D ~(0x0f);
+	w |=3D (dma_chan[lch_queue].next_linked_ch);
+	OMAP_DMA_CLNK_CTRL_REG(lch_queue) =3D w;
+}
+
+/**
+ * @brief omap_request_dma_chain : Request a chain of DMA channels
+ *
+ * @param dev_id - Device id using the dma channel
+ * @param dev_name - Device name
+ * @param callback - Call back function
+ * @chain_id -
+ * @no_of_chans - Number of channels requested
+ * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
+ * 					      OMAP_DMA_DYNAMIC_CHAIN
+ * @params - Channel parameters
+ *
+ * @return - Succes : 0
+ * 	     Failure: -EINVAL/-ENOMEM
+ */
+int omap_request_dma_chain(int dev_id, const char *dev_name,
+			   void (*callback) (int chain_id, u16 ch_status,
+					     void *data),
+			   int *chain_id, int no_of_chans, int chain_mode,
+			   struct omap_dma_channel_params params)
+{
+	int *channels;
+	int i, err;
+
+	/* Is the chain mode valid ? */
+	if (chain_mode !=3D OMAP_DMA_STATIC_CHAIN
+			&& chain_mode !=3D OMAP_DMA_DYNAMIC_CHAIN) {
+		printk(KERN_ERR "Invalid chain mode requested \n");
+		return -EINVAL;
+	}
+
+	if (unlikely((no_of_chans < 1
+			|| no_of_chans > OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid Number of channels requested\n");
+		return -EINVAL;
+	}
+
+	/* Allocate a queue to maintain the status of the channels
+	 * in the chain */
+	channels =3D (int *)kmalloc(sizeof(*channels) * no_of_chans, =
GFP_KERNEL);
+	if (channels =3D=3D NULL) {
+		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
+		return -ENOMEM;
+	}
+
+	/* request and reserve DMA channels for the chain */
+	for (i =3D 0; i < no_of_chans; i++) {
+		err =3D omap_request_dma(dev_id, dev_name,
+					callback, 0, &channels[i]);
+		if (err < 0) {
+			int j;
+			for (j =3D 0; j < i; j++)
+				omap_free_dma(channels[j]);
+			kfree(channels);
+			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
+			return err;
+		}
+		dma_chan[channels[i]].next_linked_ch =3D -1;
+		dma_chan[channels[i]].prev_linked_ch =3D -1;
+		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
+
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+
+	*chain_id =3D channels[0];
+	dma_linked_lch[*chain_id].linked_dmach_q =3D channels;
+	dma_linked_lch[*chain_id].chain_mode =3D chain_mode;
+	dma_linked_lch[*chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
+	dma_linked_lch[*chain_id].no_of_lchs_linked =3D no_of_chans;
+
+	for (i =3D 0; i < no_of_chans; i++)
+		dma_chan[channels[i]].chain_id =3D *chain_id;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(*chain_id);
+
+	/* Set up the chain */
+	if (no_of_chans =3D=3D 1)
+		create_dma_lch_chain(channels[0], channels[0]);
+	else {
+		for (i =3D 0; i < (no_of_chans - 1); i++)
+			create_dma_lch_chain(channels[i], channels[i + 1]);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(omap_request_dma_chain);
+
+/**
+ * @brief omap_modify_dma_chain_param : Modify the chain's params - =
Modify the
+ * params after setting it. Dont do this while dma is running!!
+ *
+ * @param chain_id - Chained logical channel id.
+ * @param params
+ *
+ * @return - Success : 0
+ * 	     Failure : -EINVAL
+ */
+int omap_modify_dma_chain_params(int chain_id,
+				struct omap_dma_channel_params params)
+{
+	int *channels;
+	u32 i;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0
+			|| chain_id >=3D OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(omap_modify_dma_chain_params);
+
+/**
+ * @brief omap_free_dma_chain - Free all the logical channels in a =
chain.
+ *
+ * @param chain_id
+ *
+ * @return - Success : 0
+ * 	     Failure : -EINVAL
+ */
+int omap_free_dma_chain(int chain_id)
+{
+	int *channels;
+	u32 i;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		dma_chan[channels[i]].next_linked_ch =3D -1;
+		dma_chan[channels[i]].prev_linked_ch =3D -1;
+		dma_chan[channels[i]].chain_id =3D -1;
+		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
+		omap_free_dma(channels[i]);
+	}
+
+	kfree(channels);
+
+	dma_linked_lch[chain_id].linked_dmach_q =3D NULL;
+	dma_linked_lch[chain_id].chain_mode =3D -1;
+	dma_linked_lch[chain_id].chain_state =3D -1;
+	return (0);
+}
+EXPORT_SYMBOL(omap_free_dma_chain);
+
+/**
+ * @brief omap_dma_chain_status - Check if the chain is in
+ * active / inactive state.
+ * @param chain_id
+ *
+ * @return - Success : OMAP_DMA_CHAIN_ACTIVE/OMAP_DMA_CHAIN_INACTIVE
+ * 	     Failure : -EINVAL
+ */
+int omap_dma_chain_status(int chain_id)
+{
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	debug_printk((KERN_INFO "CHAINID=3D%d, qcnt=3D%d\n", chain_id,
+		      dma_linked_lch[chain_id].q_count));
+
+	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
+		return OMAP_DMA_CHAIN_INACTIVE;
+	return OMAP_DMA_CHAIN_ACTIVE;
+}
+EXPORT_SYMBOL(omap_dma_chain_status);
+
+/**
+ * @brief omap_dma_chain_a_transfer - Get a free channel from a chain,
+ * set the params and start the transfer.
+ *
+ * @param chain_id
+ * @param src_start - buffer start address
+ * @param dest_start - Dest address
+ * @param elem_count
+ * @param frame_count
+ * @param callbk_data - channel callback parameter data.
+ *
+ * @return  - Success : start_dma status
+ * 	      Failure: -EINVAL/-EBUSY
+ */
+int omap_dma_chain_a_transfer(int chain_id, int src_start, int =
dest_start,
+			int elem_count, int frame_count, void *callbk_data)
+{
+	int *channels;
+	u32 w, lch;
+	int start_dma =3D 0;
+
+	/* if buffer size is less than 1 then there is
+	 * no use of starting the chain */
+	if (elem_count < 1) {
+		printk(KERN_ERR "Invalid buffer size\n");
+		return -EINVAL;
+	}
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0
+			|| chain_id >=3D OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exist\n");
+		return -EINVAL;
+	}
+
+	/* Check if all the channels in chain are in use */
+	if (OMAP_DMA_CHAIN_QFULL(chain_id))
+		return -EBUSY;
+
+	/* Frame count may be negative in case of indexed transfers */
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get a free channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_tail];
+
+	/* Store the callback data */
+	dma_chan[lch].data =3D callbk_data;
+
+	/* Increment the q_tail */
+	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
+
+	/* Set the params to the free channel */
+	if (src_start !=3D 0)
+		OMAP2_DMA_CSSA_REG(lch) =3D src_start;
+	if (dest_start !=3D 0)
+		OMAP2_DMA_CDSA_REG(lch) =3D dest_start;
+
+	/* Write the buffer size */
+	OMAP_DMA_CEN_REG(lch) =3D elem_count;
+	OMAP_DMA_CFN_REG(lch) =3D frame_count;
+
+	/* If the chain is dynamically linked,
+	 * then we may have to start the chain if its not active */
+	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_DYNAMIC_CHAIN) =
{
+
+		/* In Dynamic chain, if the chain is not started,
+		 * queue the channel */
+		if (dma_linked_lch[chain_id].chain_state =3D=3D
+						DMA_CHAIN_NOTSTARTED) {
+			/* Enable the link in previous channel */
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
+								DMA_CH_QUEUED)
+				enable_lnk(dma_chan[lch].prev_linked_ch);
+			dma_chan[lch].state =3D DMA_CH_QUEUED;
+		}
+
+		/* Chain is already started, make sure its active,
+		 * if not then start the chain */
+		else {
+			start_dma =3D 1;
+
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
+							DMA_CH_STARTED) {
+				enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state =3D DMA_CH_QUEUED;
+				start_dma =3D 0;
+				if (0 =3D=3D ((1 << 7) & (OMAP_DMA_CCR_REG
+					(dma_chan[lch].prev_linked_ch)))) {
+					disable_lnk(dma_chan[lch].
+						    prev_linked_ch);
+					debug_printk((KERN_INFO
+						"\n prev ch is stopped\n"));
+					start_dma =3D 1;
+				}
+			}
+
+			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
+							=3D=3D DMA_CH_QUEUED) {
+				enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state =3D DMA_CH_QUEUED;
+				start_dma =3D 0;
+			}
+			omap_enable_channel_irq(lch);
+
+			w =3D OMAP_DMA_CCR_REG(lch);
+
+			if ((0 =3D=3D (w & (1 << 24))))
+				w &=3D ~(1 << 25);
+			else
+				w |=3D (1 << 25);
+			if (start_dma =3D=3D 1) {
+				if (0 =3D=3D (w & (1 << 7))) {
+					w |=3D (1 << 7);
+					dma_chan[lch].state =3D DMA_CH_STARTED;
+					debug_printk((KERN_INFO
+						"starting %d\n", lch));
+					OMAP_DMA_CCR_REG(lch) =3D w;
+				} else
+					start_dma =3D 0;
+			} else {
+				if (0 =3D=3D (w & (1 << 7)))
+					OMAP_DMA_CCR_REG(lch) =3D w;
+			}
+			dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
+		}
+	}
+	return start_dma;
+}
+EXPORT_SYMBOL(omap_dma_chain_a_transfer);
+
+/**
+ * @brief omap_start_dma_chain_transfers - Start the chain
+ *
+ * @param chain_id
+ *
+ * @return - Success : 0
+ * 	     Failure : -EINVAL/-EBUSY
+ */
+int omap_start_dma_chain_transfers(int chain_id)
+{
+	int *channels;
+	u32 w, i;
+
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	if (dma_linked_lch[channels[0]].chain_state =3D=3D DMA_CHAIN_STARTED) =
{
+		printk(KERN_ERR "Chain is already started \n");
+		return -EBUSY;
+	}
+
+	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_STATIC_CHAIN) =
{
+		for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
+									i++) {
+			enable_lnk(channels[i]);
+			omap_enable_channel_irq(channels[i]);
+		}
+	} else {
+		omap_enable_channel_irq(channels[0]);
+	}
+
+	w =3D OMAP_DMA_CCR_REG(channels[0]);
+	w |=3D (1 << 7);
+	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_STARTED;
+	dma_chan[channels[0]].state =3D DMA_CH_STARTED;
+
+	if ((0 =3D=3D (w & (1 << 24))))
+		w &=3D ~(1 << 25);
+	else
+		w |=3D (1 << 25);
+	OMAP_DMA_CCR_REG(channels[0]) =3D w;
+
+	dma_chan[channels[0]].flags |=3D OMAP_DMA_ACTIVE;
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_chain_transfers);
+
+/**
+ * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a =
chain.
+ *
+ * @param chain_id
+ *
+ * @return - Success : 0
+ * 	     Failure : EINVAL
+ */
+int omap_stop_dma_chain_transfers(int chain_id)
+{
+	int *channels;
+	u32 w, i;
+	u32 sys_cf;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* DMA Errata:
+	 * Special programming model needed to disable DMA before end of block
+	 */
+	sys_cf =3D omap_readl(OMAP_DMA4_OCP_SYSCONFIG);
+	w =3D sys_cf;
+	/* Middle mode reg set no Standby */
+	w &=3D ~((1 << 12)|(1 << 13));
+	omap_writel(w, OMAP_DMA4_OCP_SYSCONFIG);
+
+	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+
+		/* Stop the Channel transmission */
+		w =3D OMAP_DMA_CCR_REG(channels[i]);
+		w &=3D ~(1 << 7);
+		OMAP_DMA_CCR_REG(channels[i]) =3D w;
+
+		/* Disable the link in all the channels */
+		disable_lnk(channels[i]);
+		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
+
+	}
+	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(chain_id);
+
+	/* Errata - put in the old value */
+	omap_writel(sys_cf, OMAP_DMA4_OCP_SYSCONFIG);
+	return 0;
+}
+EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
+
+/* Get the index of the ongoing DMA in chain */
+/**
+ * @brief omap_get_dma_chain_index - Get the element and frame index
+ * of the ongoing DMA in chain
+ *
+ * @param chain_id
+ * @param ei - Element index
+ * @param fi - Frame index
+ *
+ * @return - Success : 0
+ * 	     Failure : -EINVAL
+ */
+int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
+{
+	int lch;
+	int *channels;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	if ((!ei) || (!fi))
+		return -EINVAL;
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_head];
+
+	*ei =3D OMAP2_DMA_CCEN_REG(lch);
+	*fi =3D OMAP2_DMA_CCFN_REG(lch);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_dma_chain_index);
+
+/**
+ * @brief omap_get_dma_chain_dst_pos - Get the destination position of =
the
+ * ongoing DMA in chain
+ *
+ * @param chain_id
+ *
+ * @return - Success : Destination position
+ * 	     Failure : -EINVAL
+ */
+int omap_get_dma_chain_dst_pos(int chain_id)
+{
+	int lch;
+	int *channels;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_head];
+
+	return (OMAP_DMA_CDAC_REG(lch));
+}
+EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
+
+/**
+ * @brief omap_get_dma_chain_src_pos - Get the source position
+ * of the ongoing DMA in chain
+ * @param chain_id
+ *
+ * @return - Success : Destination position
+ * 	     Failure : -EINVAL
+ */
+int omap_get_dma_chain_src_pos(int chain_id)
+{
+	int lch;
+	int *channels;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >=3D =
OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch =3D channels[dma_linked_lch[chain_id].q_head];
+
+	return (OMAP_DMA_CSAC_REG(lch));
+}
+EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
+#endif
+
 =
/*-----------------------------------------------------------------------=
-----*/
=20
 #ifdef CONFIG_ARCH_OMAP1
@@ -1017,8 +1696,33 @@
 	OMAP_DMA_CSR_REG(ch) =3D OMAP2_DMA_CSR_CLEAR_MASK;
 	omap_writel(1 << ch, OMAP_DMA4_IRQSTATUS_L0);
=20
-	if (likely(dma_chan[ch].callback !=3D NULL))
-		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
+	/* If the ch is not chained then chain_id will be -1 */
+	if (dma_chan[ch].chain_id !=3D -1) {
+		int chain_id =3D dma_chan[ch].chain_id;
+		dma_chan[ch].state =3D DMA_CH_NOTSTARTED;
+		if (OMAP_DMA_CLNK_CTRL_REG(ch) & (1 << 15))
+			dma_chan[dma_chan[ch].next_linked_ch].state =3D
+							DMA_CH_STARTED;
+		if (dma_linked_lch[chain_id].chain_mode =3D=3D
+						OMAP_DMA_DYNAMIC_CHAIN)
+			disable_lnk(ch);
+
+		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
+			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
+	}
+
+	status =3D OMAP_DMA_CSR_REG(ch);
+
+	if (likely(dma_chan[ch].callback !=3D NULL)) {
+		if (dma_chan[ch].chain_id !=3D -1)
+			dma_chan[ch].callback(dma_chan[ch].chain_id, status,
+					      dma_chan[ch].data);
+		else
+			dma_chan[ch].callback(ch, status, dma_chan[ch].data);
+
+	}
+
+	OMAP_DMA_CSR_REG(ch) =3D status;
=20
 	return 0;
 }
Index: omap-git/include/asm-arm/arch-omap/dma.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- omap-git.orig/include/asm-arm/arch-omap/dma.h	2007-10-22 =
03:18:23.902726680 -0400
+++ omap-git/include/asm-arm/arch-omap/dma.h	2007-10-23 =
03:30:06.525115352 -0400
@@ -394,6 +394,10 @@
 #define OMAP_DMA_SYNC_ELEMENT		0x00
 #define OMAP_DMA_SYNC_FRAME		0x01
 #define OMAP_DMA_SYNC_BLOCK		0x02
+#define OMAP_DMA_SYNC_PACKET		0x03
+
+#define OMAP_DMA_SRC_SYNC		0x01
+#define OMAP_DMA_DST_SYNC		0x00
=20
 #define OMAP_DMA_PORT_EMIFF		0x00
 #define OMAP_DMA_PORT_EMIFS		0x01
@@ -419,6 +423,14 @@
 #define DMA_THREAD_FIFO_25		(0x02 << 14)
 #define DMA_THREAD_FIFO_50		(0x03 << 14)
=20
+/* Chaining modes*/
+#ifndef CONFIG_ARCH_OMAP1
+#define OMAP_DMA_STATIC_CHAIN		0x1
+#define OMAP_DMA_DYNAMIC_CHAIN		0x2
+#define OMAP_DMA_CHAIN_ACTIVE		0x1
+#define OMAP_DMA_CHAIN_INACTIVE		0x0
+#endif
+
 #define DMA_CH_PRIO_HIGH		0x1
 #define DMA_CH_PRIO_LOW			0x0 /* Def */
=20
@@ -474,6 +486,10 @@
=20
 	unsigned char read_prio;/* read priority */
 	unsigned char write_prio;/* write priority */
+
+#ifndef CONFIG_ARCH_OMAP1
+	enum omap_dma_burst_mode burst_mode; /* Burst mode 4/8/16 words */
+#endif
 };
=20
=20
@@ -529,6 +545,29 @@
 extern int omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 				 unsigned char write_prio);
=20
+/* Chaining APIs */
+#ifndef CONFIG_ARCH_OMAP1
+extern int omap_request_dma_chain(int dev_id, const char *dev_name,
+				  void (*callback) (int chain_id, u16 ch_status,
+						    void *data),
+				  int *chain_id, int no_of_chans,
+				  int chain_mode,
+				  struct omap_dma_channel_params params);
+extern int omap_free_dma_chain(int chain_id);
+extern int omap_dma_chain_a_transfer(int chain_id, int src_start,
+				     int dest_start, int elem_count,
+				     int frame_count, void *callbk_data);
+extern int omap_start_dma_chain_transfers(int chain_id);
+extern int omap_stop_dma_chain_transfers(int chain_id);
+extern int omap_get_dma_chain_index(int chain_id, int *ei, int *fi);
+extern int omap_get_dma_chain_dst_pos(int chain_id);
+extern int omap_get_dma_chain_src_pos(int chain_id);
+
+extern int omap_modify_dma_chain_params(int chain_id,
+					struct omap_dma_channel_params params);
+extern int omap_dma_chain_status(int chain_id);
+#endif
+
 /* LCD DMA functions */
 extern int omap_request_lcd_dma(void (* callback)(u16 status, void =
*data),
 				void *data);
