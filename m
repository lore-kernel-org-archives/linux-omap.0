From: Tony Lindgren <tony@atomide.com>
Subject: (no subject)
Date: Mon, 13 Aug 2007 06:48:35 -0700
Message-ID: <11870129672745-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: musb
References: musb
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

As the musb/tusb code now mostly works for host and peripheral,
I'm planning to push a series of search and replace patches
to start converting the musb/tusb driver into something that
follows CodingStyle.

Following is a list of changes I've done. I haven't gone through
DaVinci or 2430 specific code, as I cannot test them right now.
No functional changes should be included. Code has been tested
with tusb6010.

Regards,

Tony

[PATCH 1/52] musb_hdrc: Search and replace pThis with musb
[PATCH 2/52] musb_hdrc: Search and replace pEndPt with hw_ep
[PATCH 3/52] musb_hdrc: Search and replace pEnd with musb_ep when struct musb_ep
[PATCH 4/52] musb_hdrc: Search and replace pEnd with musb_ep when struct musb_hw_ep
[PATCH 5/52] musb_hdrc: Search and replace pRegs with mregs
[PATCH 6/52] musb_hdrc: Search and replace pBase with mbase
[PATCH 7/52] musb_hdrc: Search and replace pSource with src
[PATCH 8/52] musb_hdrc: Search and replace pDest with dst
[PATCH 9/52] musb_hdrc: Search and replace dwCount with len
[PATCH 10/52] musb_hdrc: Search and replace wFifoCount with fifo_count
[PATCH 11/52] musb_hdrc: Search and replace wCount with len
[PATCH 12/52] musb_hdrc: Search and replace bLocalEnd with epnum
[PATCH 13/52] musb_hdrc: Search and replace aLocalEnd with endpoints
[PATCH 14/52] musb_hdrc: Search and replace bEndCount with nr_endpoints
[PATCH 15/52] musb_hdrc: Search and replace bEndNumber with current_epnum
[PATCH 16/52] musb_hdrc: Search and replace bEnd0Stage with ep0_stage
[PATCH 17/52] musb_hdrc: Search and replace bEnd with epnum
[PATCH 18/52] musb_hdrc: Search and replace Lock with lock
[PATCH 19/52] musb_hdrc: Search and replace MGC_SelectEnd with musb_ep_select
[PATCH 20/52] musb_hdrc: Search and replace _pthis with _musb
[PATCH 21/52] musb_hdrc: Search and replace bIsHost with is_host
[PATCH 22/52] musb_hdrc: Get rid of old unused MUSB_EpFifoDescriptor
[PATCH 23/52] musb_hdrc: Search and replace bIsSharedFifo with is_shared_fifo
[PATCH 24/52] musb_hdrc: Search and replace wMaxPacketSizeTx with max_packet_sz_tx
[PATCH 25/52] musb_hdrc: Search and replace wMaxPacketSizeRx with max_packet_sz_rx
[PATCH 26/52] musb_hdrc: Search and replace pDmaController with dma_controller
[PATCH 27/52] musb_hdrc: Search and replace bIsMultipoint with is_multipoint
[PATCH 28/52] musb_hdrc: Search and replace bIgnoreDisconnect with ignore_disconnect
[PATCH 29/52] musb_hdrc: Search and replace bBulkSplit with bulk_split
[PATCH 30/52] musb_hdrc: Search and replace bBulkCombine with bulk_combine
[PATCH 31/52] musb_hdrc: Search and replace bAddress with address
[PATCH 32/52] musb_hdrc: Search and replace bTestModeValue with test_mode_nr
[PATCH 33/52] musb_hdrc: Search and replace bTestMode with test_mode
[PATCH 34/52] musb_hdrc: Search and replace pGadgetDriver with gadget_driver
[PATCH 35/52] musb_hdrc: Search and replace bDelayPortPowerOff with delay_port_power_off
[PATCH 36/52] musb_hdrc: Search and replace pProcEntry with proc_entry
[PATCH 37/52] musb_hdrc: Search and replace pPrivateData with private_data
[PATCH 38/52] musb_hdrc: Search and replace dwMaxLength with max_len
[PATCH 39/52] musb_hdrc: Search and replace dwActualLength with actual_len
[PATCH 40/52] musb_hdrc: Search and replace bStatus with status
[PATCH 41/52] musb_hdrc: Search and replace bDesiredMode with desired_mode
[PATCH 42/52] musb_hdrc: Search and replace bMode with mode
[PATCH 43/52] musb_hdrc: Search and replace MGC_pfDmaProgramChannel with dma_program_channel
[PATCH 44/52] musb_hdrc: Search and replace pControlRequest with ctrlrequest
[PATCH 45/52] musb_hdrc: Search and replace bResult with result
[PATCH 46/52] musb_hdrc: Search and replace bSetAddress with set_address
[PATCH 47/52] musb_hdrc: Search and replace bRecip with recip
[PATCH 48/52] musb_hdrc: Search and replace pRequest with request
[PATCH 49/52] musb_hdrc: Search and replace wCsrVal with csr
[PATCH 50/52] musb_hdrc: Search and replace bTx with tx
[PATCH 51/52] musb_hdrc: Search and replace wPacketSize with packet_sz
[PATCH 52/52] musb_hdrc: Search and replace channelNum with chnum
