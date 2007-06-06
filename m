From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC] Generic DMA chaining APIs
Date: Wed, 6 Jun 2007 00:02:18 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701120BC1@dlee13.ent.ti.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all:

I would like to port Generic DMA chaining API support from TI's 2430 DMA =
driver to our OMAP GIT DMA driver.

- Basically these APIs give flexibility for handling DMA chaining for =
drivers like McBSP (for audio), McSPI (for LCD), UART, etc.=20

- Chaining is very important for drivers like Audio, LCD etc.

- Our current DMA driver on GIT does support APIs to enable /configure =
DMA logical channel chaining, but they have to be again used in client =
drivers to implement the queuing logic.

- Since there are multiple drivers in need of these kind of chaining =
support, it's preferable to implement them in a generic way so that all =
other drivers can leverage the code instead of creating a redundant copy =
in every driver.

A code snippet (from TI's DMA driver) is as shown below. Please do let =
me know if you find any issues with this kind of implementation/approach =
before I start (this week) this porting activity.

Thanks in advance.

APIs to be ported are:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
omap_request_dma_chain
omap_free_dma_chain
omap_dma_chain_a_transfer
omap_modify_dma_chain_params
omap_start_dma_chain_transfers
omap_stop_dma_chain_transfers

omap_dma_chain_status
omap_get_dma_chain_index
omap_get_dma_chain_dst_pos
omap_get_dma_chain_src_pos

This code has to be ported to OMAP GIT, please comment on design (not =
coding aspects).

/**=20
 * @brief omap_request_dma_chain : Request a chain of DMA channels
 *=20
 * @param dev_id - Device id using the dma channel
 * @param dev_name - Device name
 * @param callback - Call back function
 * @chain_id -
 * @no_of_chans - Number of channels requested
 * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
 * 					      OMAP_DMA_DYNAMIC_CHAIN
 * @params - Channel parameters
 *=20
 * @return - Succes : 0
 * 	     Failure: EINVAL/EINVAL/EBUSY
 */
int
omap_request_dma_chain(int dev_id, const char *dev_name,
		       void (*callback) (int chain_id, u16 ch_status,
					 void *data), int *chain_id,
		       int no_of_chans, int chain_mode,
		       dma_channel_params params)
{
	int *channels =3D NULL;
	int i, err;

	/* Is the chain mode valid ? */
	if (chain_mode !=3D OMAP_DMA_STATIC_CHAIN
	    && chain_mode !=3D OMAP_DMA_DYNAMIC_CHAIN) {
		printk(KERN_ERR "Invalid chain mode requested \n");
		return -EINVAL;
	}

	if (unlikely((no_of_chans < 1 || no_of_chans > =
OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid Number of channels requested\n");
		return -EINVAL;
	}

	/* Allocate a queue to maintain the status of the channels in the chain =
*/
	channels =3D (int *)kmalloc(sizeof(int) * no_of_chans, GFP_KERNEL);
	if (channels =3D=3D NULL) {
		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
		return -ENOMEM;
	}

	/* request and reserve DMA channels for the chain */
	for (i =3D 0; i < no_of_chans; i++) {
		err =3D
		    omap_request_dma(dev_id, dev_name, callback, 0,
				     &channels[i]);
		if (err < 0) {
			/* Save duplicating code */
			goto chain_fail;
		}
		dma_chan[channels[i]].next_linked_ch =3D -1;
		dma_chan[channels[i]].prev_linked_ch =3D -1;
		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;

		/*=20
		 * Allowing client drivers to set common parameters now,=20
		 * so that later only relevant (src_start, dest_start and element =
count)=20
		 * can be set
		 */
		err =3D omap_set_dma_params(channels[i], params);
chain_fail:
		if (err < 0) {
			int j;
			for (j =3D 0; j < i; j++) {
				omap_free_dma(channels[j]);
			}
			kfree(channels);
			printk(KERN_ERR "omap_dma: Request failed %d\n",err);
			return err;
		}
	}

	*chain_id =3D channels[0];
	dma_linked_lch[*chain_id].linked_dmach_q =3D channels;
	dma_linked_lch[*chain_id].chain_mode =3D chain_mode;
	dma_linked_lch[*chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;
	dma_linked_lch[*chain_id].no_of_lchs_linked =3D no_of_chans;

	for (i =3D 0; i < no_of_chans; i++)
		dma_chan[channels[i]].chain_id =3D *chain_id;

	/* Reset the Queue pointers */
	OMAP_DMA_CHAIN_QINIT(*chain_id);

	/* Set up the chain */
	if (no_of_chans =3D=3D 1)
		create_dma_lch_chain(channels[0], channels[0]);
	else {
		for (i =3D 0; i < (no_of_chans - 1); i++)
			create_dma_lch_chain(channels[i], channels[i + 1]);
	}
	return 0;
}

/**=20
 * @brief omap_modify_dma_chain_param : Modify the chain's params - =
Modify the=20
 * params after setting it. Dont do this while dma is running!!
 *=20
 * @param chain_id - Chianed logical channel id.
 * @param params=20
 *=20
 * @return - Success : 0
 * 	     Failure : EINVAL=20
 */
int=20
omap_modify_dma_chain_params(int chain_id, dma_channel_params params)
{
	int *channels;
	u32 i , ret;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}
	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
		/*=20
		 * Allowing client drivers to set common parameters now,=20
		 * so that later only relevant (src_start, dest_start and element =
count)=20
		 * can be set
		 */
		if (0 !=3D (ret =3D omap_set_dma_params(channels[i], params))) {
			printk(KERN_ERR "Setting params of ch: %d failed.\n",=20
								channels[i]);
			return ret;
		}
	}
	return 0;
}

/**=20
 * @brief omap_free_dma_chain - Free all the logical channels in a =
chain.
 *=20
 * @param chain_id=20
 *=20
 * @return - Success : 0
 * 	     Failure :=20
 */
int=20
omap_free_dma_chain(int chain_id)
{
	int *channels;
	u32 i;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}

	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
		dma_chan[channels[i]].next_linked_ch =3D -1;
		dma_chan[channels[i]].prev_linked_ch =3D -1;
		dma_chan[channels[i]].chain_id =3D -1;
		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;
		omap_free_dma(channels[i]);
	}

	kfree(channels);

	dma_linked_lch[chain_id].linked_dmach_q =3D NULL;
	dma_linked_lch[chain_id].chain_mode =3D -1;
	dma_linked_lch[chain_id].chain_state =3D -1;
	return (0);
}

/**=20
 * @brief omap_dma_chain_status - Check if the chain is in active / =
inactive state.
 *=20
 * @param chain_id=20
 *=20
 * @return - Success : 0
 * 	     Failure : -EINVAL
 */
int=20
omap_dma_chain_status(int chain_id)
{
	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}
	debug_printk((KERN_INFO "CHAINID=3D%d, qcnt=3D%d\n", chain_id,
		      dma_linked_lch[chain_id].q_count));
	/* Check if all the channels in chain are in use */
	if (OMAP_DMA_CHAIN_QEMPTY(chain_id)) {
		return OMAP_DMA_CHAIN_INACTIVE;
	}
	return OMAP_DMA_CHAIN_ACTIVE;
}

/**=20
 * @brief omap_dma_chain_a_transfer - Get a free channel from a chain, =
set the params and=20
 * start the transfer.
 *=20
 * @param chain_id=20
 * @param src_start - buffer start address =20
 * @param dest_start - Dest address
 * @param elem_count=20
 * @param frame_count=20
 * @param callbk_data - channel callback parameter data.
 *=20
 * @return  - Success : start_dma status
 * 	      Failure: EINVAL/EBUSY
 */
int
omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
			  int elem_count, int frame_count, void *callbk_data)
{
	int *channels;
	u32 w, lch;
	int start_dma =3D 0;

	/* if buffer size is less than 1 then there is no use of starting the =
chain */
	if (elem_count < 1) {
		printk(KERN_ERR "Invalid buffer size\n");
		return -EINVAL;
	}

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}

	/* Check if all the channels in chain are in use */
	if (OMAP_DMA_CHAIN_QFULL(chain_id)) {
		return -EBUSY;
	}

	/* Frame count may be negative in case of indexed transfers */
	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	/* Get a free channel */
	lch =3D channels[dma_linked_lch[chain_id].q_tail];

	/* Store the callback data */
	dma_chan[lch].data =3D callbk_data;

	/* Increment the q_tail */
	if (~OMAP_DMA_CHAIN_QFULL(chain_id)) {
		OMAP_DMA_CHAIN_INCQTAIL(chain_id);
	}

	/* Set the params to the free channel */
	if (src_start !=3D 0) {
		writel(src_start, OMAP_DMA4_CSSA_REG(lch));
	}
	if (dest_start !=3D 0) {
		writel(dest_start, OMAP_DMA4_CDSA_REG(lch));
	}

	/* Write the buffer size */
	writel(elem_count, OMAP_DMA4_CEN_REG(lch));
	writel(frame_count, OMAP_DMA4_CFN_REG(lch));

	/* If the chain is dynamically linked, then we may have to start the =
chain if its not active */
	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_DYNAMIC_CHAIN) =
{

		/* In Dynamic chain, if the chain is not started queue the channel */
		if (dma_linked_lch[chain_id].chain_state =3D=3D
		    DMA_CHAIN_NOTSTARTED) {
			/* Enable the link in previous channel */
			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
			    DMA_CH_QUEUED) {
				enable_lnk(dma_chan[lch].prev_linked_ch);
			}
			dma_chan[lch].state =3D DMA_CH_QUEUED;
		}

		/* Chain is already started, make sure its active, if not then start =
the chain */
		else {
			start_dma =3D 1;

			/*=20
			 * if the previous channel is already started,=20
			 * then don't start DMA for this channel, just enable the link
			 */
			if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
			    DMA_CH_STARTED) {
				/* link it with the prev one */
				enable_lnk(dma_chan[lch].prev_linked_ch);
				dma_chan[lch].state =3D DMA_CH_QUEUED;
				start_dma =3D 0;
				/* check if link enabled channel is already completed and stopped */
				if (0 =3D=3D
				    (readl
				     (OMAP_DMA4_CCR_REG
				      (dma_chan[lch].
				       prev_linked_ch)) & CCR_EN)) {
					/* the prev channel is already stopped,=20
					   start the dma for current channel */
					/* disable the link that we enabled before */
					disable_lnk(dma_chan[lch].
						    prev_linked_ch);
					debug_printk((KERN_INFO "\n prev ch is stopped\n"));
					start_dma =3D 1;
				}
			}

			/* if the previous channel is not started, but its linked to its prev =
chan */
			else if (dma_chan[dma_chan[lch].prev_linked_ch].state =3D=3D
				 DMA_CH_QUEUED) {
				enable_lnk(dma_chan[lch].prev_linked_ch);
				dma_chan[lch].state =3D DMA_CH_QUEUED;
				start_dma =3D 0;
			}
			enable_dma_irq(lch);

			w =3D readl(OMAP_DMA4_CCR_REG(lch));

			if ((0 =3D=3D (w & (1 << 24)))) {
		     		/* 2420 ES1 - not implemented, and dest sync - dont use */
				w &=3D ~(CCR_BUF_DIS);
			} else {
				w |=3D CCR_BUF_DIS;
			}
			if (start_dma =3D=3D 1) {
				/* for chaining case, don't start if the channel is already started =
*/
				if (0 =3D=3D (w & CCR_EN)) {
					w |=3D CCR_EN;
					dma_chan[lch].state =3D DMA_CH_STARTED;
					debug_printk((KERN_INFO "starting %d\n", lch));
					writel(w, OMAP_DMA4_CCR_REG(lch));
				} else
					start_dma =3D 0;
			} else {
				/* DMA will not be started, just BUF DIS settings will be done */
				/* if DMA was already started, then don't write to CCR, it will=20
				   affect the ongoing transmission */
				if (0 =3D=3D (w & CCR_EN)) {
					writel(w, OMAP_DMA4_CCR_REG(lch));
				}
			}
			dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
		}		/* else dynamic chain is started */
	}			/* if dynamic chain */
#ifdef DEBUG_DMA_DUMP
	{ int i;
	debug_printk((KERN_INFO "CHAINATRANFER\n"));
	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
		omap_dump_lch_reg(channels[i]);
	}
	}
#endif
	return start_dma;
}

/**=20
 * @brief omap_start_dma_chain_transfers - Start the chain
 *=20
 * @param chain_id=20
 *=20
 * @return - Success : 0
 * 	     Failure : EINVAL/EBUSY
 */
int=20
omap_start_dma_chain_transfers(int chain_id)
{
	int *channels =3D NULL;
	u32 w, i;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	/* If the chain is started, then don't start it again */
	if (dma_linked_lch[channels[0]].chain_state =3D=3D DMA_CHAIN_STARTED) {
		printk(KERN_ERR "Chain is already started \n");
		return -EBUSY;
	}

	/* If chain is static */
	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_STATIC_CHAIN) {
		/* Set the ENABLE_LNK bit */
		for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
			/* Enable link */
			enable_lnk(channels[i]);
			/* Enable irq */
			enable_dma_irq(channels[i]);
		}
	} else {
		enable_dma_irq(channels[0]);
	}

	w =3D readl(OMAP_DMA4_CCR_REG(channels[0]));
	w |=3D CCR_EN;
	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_STARTED;
	dma_chan[channels[0]].state =3D DMA_CH_STARTED;

	if ((0 =3D=3D (w & CCR_SEL_SRC_DST_SYNC))) {
		/* 2420 ES1 - not implemented, and dest sync - dont use */
		w &=3D ~(CCR_BUF_DIS);
	} else {
		w |=3D CCR_BUF_DIS;
	}
	/* Dump Registers */
#ifdef DEBUG_DMA_DUMP
	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
		omap_dump_lch_reg(channels[i]);
	}
#endif
	writel(w, OMAP_DMA4_CCR_REG(channels[0]));

	dma_chan[channels[0]].flags |=3D OMAP_DMA_ACTIVE;
	return 0;
}

/**=20
 * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a =
chain.
 *=20
 * @param chain_id=20
 *=20
 * @return - Success : 0
 * 	     Failure : EINVAL
 */
int=20
omap_stop_dma_chain_transfers(int chain_id)
{
	int *channels;
	u32 w, i, lch =3D 0;
	u32 sys_cf;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}
	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	/* DMA Errata:
	 * Special programming model needed to disable DMA before end of block
	 */
	w =3D sys_cf =3D readl(OMAP_DMA4_OCP_SYSCONFIG);
	/* Middle mode reg set no Standby */
	w &=3D ~(OCPSYS_MIDMODE_NOSTDBY|OCPSYS_MIDMODE_STDBY);
	writel(w, OMAP_DMA4_OCP_SYSCONFIG);

	for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {

		/* Stop the Channel transmission */
		w =3D readl(OMAP_DMA4_CCR_REG(channels[i]));
		w &=3D ~CCR_EN;
		writel(w, OMAP_DMA4_CCR_REG(channels[i]));

		/* Disable the link in all the channels */
		disable_lnk(channels[i]);
		dma_chan[channels[i]].state =3D DMA_CH_NOTSTARTED;

	}
	dma_linked_lch[chain_id].chain_state =3D DMA_CHAIN_NOTSTARTED;

	/* Reset the Queue pointers */
	OMAP_DMA_CHAIN_QINIT(chain_id);

	/* Errata - put in the old value */
	writel(sys_cf, OMAP_DMA4_OCP_SYSCONFIG);
	dma_chan[lch].flags &=3D ~OMAP_DMA_ACTIVE;
	return 0;
}

/* Get the index of the ongoing DMA in chain */
/**=20
 * @brief omap_get_dma_chain_index - Get the element and frame index
 * of the ongoing DMA in chain=20
 *=20
 * @param chain_id=20
 * @param ei - Element index
 * @param fi - Frame index
 *=20
 * @return - Success : 0
 * 	     Failure : EINVAL
 */
int=20
omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
{
	int lch =3D 0;
	int *channels;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}
	if ((!ei) || (!fi)) {
		return -EINVAL;
	}

	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	/* Get the current channel */
	lch =3D channels[dma_linked_lch[chain_id].q_head];

	*ei =3D (readl(OMAP_DMA4_CCEN_REG(lch)));
	*fi =3D (readl(OMAP_DMA4_CCFN_REG(lch)));

	return 0;
}

/**=20
 * @brief omap_get_dma_chain_dst_pos - Get the destination position of =
the=20
 * ongoing DMA in chain
 *=20
 * @param chain_id=20
 *=20
 * @return - Success : Destination position
 * 	     Failure : EINVAL
 */
int=20
omap_get_dma_chain_dst_pos(int chain_id)
{
	int lch =3D 0;
	int *channels;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}

	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	/* Get the current channel */
	lch =3D channels[dma_linked_lch[chain_id].q_head];

	return (readl(OMAP_DMA4_CDAC_REG(lch)));
}

/**=20
 * @brief omap_get_dma_chain_src_pos - Get the source position of the =
ongoing DMA in chain
 *=20
 * @param chain_id=20
 *=20
 * @return - Success : Destination position
 * 	     Failure : -EINVAL
 */
int=20
omap_get_dma_chain_src_pos(int chain_id)
{
	int lch =3D 0;
	int *channels;

	/* Check for input params */
	if (unlikely((chain_id < 0 || chain_id > OMAP_LOGICAL_DMA_CH_COUNT))) {
		printk(KERN_ERR "Invalid chain id\n");
		return -EINVAL;
	}

	/* Check if the chain exists */
	if (dma_linked_lch[chain_id].linked_dmach_q =3D=3D NULL) {
		printk(KERN_ERR "Chain doesn't exists\n");
		return -EINVAL;
	}

	channels =3D dma_linked_lch[chain_id].linked_dmach_q;

	/* Get the current channel */
	lch =3D channels[dma_linked_lch[chain_id].q_head];

	return (readl(OMAP_DMA4_CSAC_REG(lch)));
}

Regards,
Khasim
