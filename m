From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 0/4] Add support for DesignWare Core USB3 IP
Date: Mon, 15 Aug 2011 18:57:21 +0300
Message-ID: <1313423845-2288-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42482 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab1HOP5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Aug 2011 11:57:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>

Hi all,

this is the combined work that me and Sebastian
have been doing for the past 8 months. It's the
driver for the USB3 DRD Controller which will
come on the OMAP5 [1] series of processors.

Because this core is licensed from Synopsys, we
decided to write the core driver in a platform-agnostic
setup using the platform bus, and have platform-specific
glue layers which will allocate the core platform-device.

This gives us maximum flexibility on the design of
the driver and prevents many of the problems we had
(and still have) with MUSB with regards to exported
symbols all over the place.

This driver has been validated on a Virtual model of
the IP and an FPGA platform provided by Synopsys as
well (haps [2]). The HAPS platform is very useful but
it has a fundamental caveat: it uses the PCI ids
allocated for XHCI hosts, this means you have to either
patch XHCI to return -ENODEV when it sees HAPS or
blacklist xhci-hcd on that machine.

The driver is usable and we have tested many transfers
with g_zero and mass storage. Nevertheless, it's not
finished and we'd like more time to test it before
accepting it in mainline. Still, we think it's good
to show to the community the design decisions we have
made on the way and we'd like to hear from the rest of
the community any comments/criticisms wrt this driver.

The host support will be added later and will depend
on the XHCI PCI decoupling patches which Sebastian was
kind enough to take over from me [3].

Below, you can find the entire shortlog of the driver
since commit #1. It's also available at my dwc3-history
branch [4] for reference:

Felipe Balbi (306):
      usb: Introduce DesignWare USB3 DRD Driver
      usb: dwc3: move structures to core.h
      usb: dwc3: split gadget functions to gadget.c
      usb: dwc3: more __devinit annotations
      usb: dwc3: fix event buffer memleak
      usb: dwc3: add the basic OMAP glue
      usb: dwc3: start implement IRQ handling
      usb: dwc3: gadget: implement depcfg command
      usb: dwc3: add a few more parameters
      usb: dwc3: gadget: fix parameter setting of DEPXFERCFG
      usb: gadget: introduce gadget_is_dwc3()
      usb: dwc3: gadget: half initialization of endpoints
      usb: dwc: gadget: split more of the generic stuff
      usb: dwc: gadget: add more nops
      usb: dwc3: add structures for all events
      usb: dwc3: implement disconnect IRQ
      usb: dwc3: handle in and out ep irq separately
      usb: dwc3: partially implemented reset irq
      usb: dwc3: drop OTG events
      usb: dwc: half done IN ep IRQ
      usb: dwc3: increase event buffer size
      usb: dwc3: omap: we're parents of core dwc3 device
      usb: dwc: gadget: add missing static
      usb: dwc: gadget: implement queue()/dequeue()
      usb: dwc: gadget: substitute dwc_ with dwc3_
      usb: dwc: gadget: add usb_gadget_ops
      usb: dwc: gadget: implement pullup()
      usb: dwc3: implement get_frame()
      usb: dwc3: implement set_selfpowered()
      usb: dwc3: hold pointers to eps in dwc structure
      usb: dwc3: introduce struct dwc3_trb
      usb: dwc3: gadget: minimal driver load/unload
      usb: dwc3: gadget: drop ioctl
      usb: dwc3: gadget: implement map/unmap buffer
      usb: dwc3: gadget: setup TRB
      usb: dwc3: use the define
      usb: dwc3: gadget: combine endpoint ops
      usb: dwc3: gadget: implement fifo_flush
      usb: dwc3: gadget: flush all fifos on gadget init
      usb: dwc3: gadget: variable names are better uniform
      usb: dwc3: gadget: add missing line break
      usb: dwc3: move irq handling to gadget.c
      usb: dwc3: gadget: drop carkit and i2c events
      usb: dwc3: gadget: add debugging to EP irq
      usb: dwc3: gadget: split event handlers to their own functions
      usb: dwc3: add ep0_state
      usb: dwc3: gadget: add debugging
      usb: dwc3: gagdget: implement connect done IRQ
      usb: dwc3: gadget: implement link state change
      usb: dwc3: gadget: add a bit of spacing
      usb: dwc3: gadget: lock when clearing gadget and gadget_driver
      usb: dwc3: gadget: fix checkpatch.pl warnings
      usb: dwc3: headers: search and replace patch
      usb: dwc3: omap: mark dev_pm_ops const
      usb: dwc3: gadget.h: fix 80+ character lines
      usb: dwc3: add a dma_pool for TRBs for each endpoint
      usb: dwc3: gadget: create/destroy trb_pool based on ep enable/disable
      usb: dwc3: gadget: unfinished TRB allocation
      usb: dwc3: gadget: switch over to an array
      usb: dwc3: gadget: use & instead of %
      usb: dwc3: gadget: add a debugging print
      usb: dwc3: add missing kernel-doc
      usb: dwc3: gadget: all struct dwc3_ep to be called dep
      usb: dwc3: gadget: brain-less cleanups
      usb: dwc3: gadget: drop a useless goto
      usb: dwc3: gadget: use res_trans_idx
      usb: dwc3: gadget: use is_chained flag
      usb: dwc3: gadget: add ep_ to the function name
      usb: dwc3: gadget: make __dwc3_gadget_ep_queue return a value
      usb: dwc3: gadget: free the TRB if queueing fails
      usb: dwc3: gadget: get rid of magic constants
      usb: dwc3: gadget: move some code around
      usb: dwc3: gadget: don't overwrite trbctl
      usb: dwc3: gadget: combine two cases
      usb: dwc3: gadget: only interrupt on last TRB
      usb: dwc3: gadget: introduce dwc3_gadget_ep_get_transfer_index
      usb: dwc3: gadget: implement dwc3_gadget_init_endpoint
      usb: dwc3: gadget: cut down on duplication
      usb: dwc3: gadget: implement dwc3_disable_endpoint()
      usb: dwc3: gadget: disable all eps on exit
      usb: dwc3: gadget: return early on two cases
      usb: dwc3: gadget: implement dwc3_gadget_ep_set_halt
      usb: dwc3: gadget: implement dwc3_gadget_ep_set_wedge
      usb: dwc3: gadget: drop dwc3_gadget_fifo_status
      usb: dwc3: gadget: add blank lines
      usb: dwc3: gadget: implement wakeup method
      usb: dwc3: core: make suspend and resume return something
      usb: dwc3: core: move us to fs_initcall()
      usb: dwc3: remove event_ prefix from two fields
      usb: dwc3: gadget: introduce next_request()
      usb: dwc3: gadget: implement transfer complete IRQ
      usb: dwc3: gadget: add request_count
      usb: dwc3: gadget: start next request if we have it queued
      usb: dwc3: gadget: introduce list_add/list_del helpers
      usb: dwc3: gadget: fix compile error
      usb: dwc3: shift has to be defined first
      usb: dwc3: gadget: combine IN and OUT ep IRQs
      usb: dwc3: add enumeration for TRB Statuses
      usb: dwc3: gadget: XFERINPROG and XFERNRDY are Isoc-only
      usb: dwc3: gadget: use EP CMD Complete IRQ
      usb: dwc3: introduce HAPS glue layer
      usb: dwc3: glue layers need to probe before core dwc3
      usb: dwc3: add resources to dwc3 device
      usb: dwc3: gadget: increment after check
      usb: dwc3: gadget: return IRQ_HANDLED
      Revert "usb: dwc3: gadget: use EP CMD Complete IRQ"
      usb: dwc3: gadget: add dwc3_ prefix to prepare_trbs
      usb: dwc3: gadget: drop unneeded gadget ops
      usb: dwc3: haps: few fixes to haps glue
      usb: dwc3: keep it all on module_init
      usb: dwc3: gadget: set CSP bit in TRB
      usb: dwc3: gadget: use max packet size from ep descriptor
      usb: dwc3: gadget: set binterval_m1 field
      usb: dwc3: haps: checkpatch.pl asks to use DEFINE_PCI_DEVICE_TABLE
      usb: dwc3: gadget: misc cleanups
      usb: dwc3: gadget: add missing register write
      usb: dwc3: gadget: fix typo DCW -> DWC
      usb: dwc3: fix up copyright
      device: add dev_WARN_ONCE
      usb: dwc3: gadget: convert WARN_ONCE() to dev_WARN_ONCE()
      usb: dwc3: gadget: Search&Replace dwc_ dwc3_
      usb: dwc3: gadget: drop useless check for ep type
      usb: dwc3: gadget: make internal function name uniform
      usb: gadget: add USB_GADGET_SUPERSPEED
      usb: dwc3: gadget: compile gadget code only if enabled
      usb: dwc3: Kconfig: drop "Disable DMA" entry
      usb: dwc3: omap: fix exit section annotation
      usb: dwc3: drop unnused enumeration
      usb: dwc3: fix typo
      usb: dwc3: gadget: give ep0 a wMaxPacketSize
      usb: dwc3: make our driver Dual BSD/GPL
      usb: dwc3: fix license on OMAP and HAPS glue layers
      usb: dwc3: core: drop ramN memory bases
      usb: dwc3: ep0: remove unneeded return statement
      usb: dwc: core: ioremap global space first
      usb: dwc3: gadget: fix typo in debugging message
      usb: dwc3: gadget: introduce next_queued_request()
      usb: dwc3: gadget: convert to next_queued_request()
      usb: dwc3: gadget: pass the list_head instead of endpoint
      usb: dwc3: gadget: WARN() on double allocation of TRB pool
      usb: dwc3: gadget: add lock around __dwc3_gadget_ep_disable()
      usb: dwc3: gagdget: fix typo s/requeust/request/
      usb: dwc3: gadget: update ep names with xfer type
      Revert "usb: dwc3: gadget: WARN() on double allocation of TRB pool"
      usb: dwc3: introduce platform_data.h
      usb: dwc3: update to use new platform_data
      usb: dwc3: gadget: drop unused argument
      usb: dwc3: gadget: handle Transfer In Progress
      Revert "usb: dwc3: update to use new platform_data"
      Revert "usb: dwc3: introduce platform_data.h"
      usb: dwc3: convert to only one base
      usb: dwc3: add features bit definitions
      usb: dwc3: use platform_device_id
      usb: dwc3: adapt to new platform_device_id
      usb: gadget: chips: fix dwc3 recognition
      usb: dwc3: core: use pm_runtime_get_sync()
      usb: always enter USB directory
      usb: dwc3: Kconfig: depend on USB or USB_GADGET
      usb: dwc3: haps: remove unused code
      usb: dwc3: core: mark platform_device_id __devinitconst
      Revert "usb: always enter USB directory"
      usb: don't enter usb subdirectories directly
      usb: dwc3: core: fix up the reset loop
      usb: gadget: chips: fixup our name
      usb: dwc3: use platform_get_resource_byname
      usb: dwc3: gadget: enable correct IRQs
      usb: dwc3: drop BIT(13) of DEVTEN
      usb: dwc3: gadget: add IRQF_SHARED
      usb: dwc3: core: get IRQ by name
      usb: dwc3: io: include <asm/io.h>
      usb: dwc3: introduce omap glue layer
      usb: dwc3: omap: don't try to reinitilize the device
      usb: dwc3: omap: drop pm_runtime from the glue layer
      usb: dwc3: omap: request IRQ lines before enabling the events
      usb: dwc3: fix up Makefile so we always build correctly
      usb: dwc3: fix offset of DEPCMD registers
      usb: dwc3: gadget: only set binternal_m1 if we have to
      usb: dwc3: gadget: we need to enable ep0/1 on POR
      usb: dwc3: core: save size of address space in our struct
      usb: dwc3: introduce simple debugfs interface
      usb: dwc3: haps: don't reinitialize pdev, HAPS remix
      usb: dwc3: haps: we need to pass IRQ to core driver too
      usb: dwc3: gadget: add verbose print when sending commands
      usb: dwc3: gadget: pass ignore_sequence_number as paramter
      usb: dwc3: gadget: fix up connection done IRQ
      usb: dwc3: gadget: move TRB allocation one layer up
      usb: dwc3: allow verbose debug to be selected
      usb: dwc3: gadget: fix up wMaxPacketSize on conndone IRQ
      usb: dwc3: gadget: move disabled check one layer up
      usb: dwc3: gadget: we should write back BYTE count
      usb: dwc3: gadget: don't reenable eps on reset IRQ
      usb: dwc3: gadget: no need for two defines
      usb: dwc3: gadget: don't drop run/stop on disconnect
      usb: dwc3: fix typo 'ponts'
      usb: dwc3: drop extra semicolon
      usb: dwc3: gadget: kill one compile warning
      usb: dwc3: gadget: alloc from coherent instead
      usb: dwc3: ep0: reference code uses ISP bit
      usb: dwc3: gadget: don't hardcode endpoint number to 1
      usb: dwc3: gadget: usb & instead of %
      usb: dwc3: gadget: issue start transfer after run/stop
      usb: dwc3: gadget: don't dereference null pointer
      usb: dwc3: ep0: pretty print ep0state
      usb: dwc3: ep0: add missing break
      usb: dwc3: ep0: drop few warnings
      usb: dwc3: ep0: add a few debugging prints
      usb: dwc3: ep0: only call complete() if queue isn't empty
      usb: dwc3: ep0: inspect the setup packet always
      usb: dwc3: ep0: fix compile error
      usb: dwc3: ep0: don't queue always to ep0
      usb: dwc3: gadget: call device register
      usb: dwc3: more debugging info
      usb: dwc3: ep0: use next_request()
      usb: dwc3: gadget: patch gadget speed
      usb: dwc3: ep0: do setup_status phase
      usb: dwc3: gadget: pass descriptor to alloc_trb
      usb: dwc3: gadget: fix endpoint mapping
      usb: dwc3: gadget: only enable xfer_in_progress for isoc
      usb: dwc3: gadget: we only need bInterval on SS
      usb: dwc3: core: define macro for command status
      usb: dwc3: gadget: pretty print for events
      usb: dwc3: ep0: print physical endpoint name instead
      usb: dwc3: gadget: fix up endpoint name
      usb: dwc3: gadget: follow reference code
      usb: dwc3: gadget: only call disconnect if we're working
      usb: gadget: ep0: move xfernotready closer to its sibling
      usb: dwc3: ep0: simplify debugging and handler
      usb: dwc3: core: fix a register name
      usb: dwc3: debugfs: improve regdump utility
      usb: dwc3: omap: move platform_set_drvdata up
      usb: dwc3: gadget: move req->queued to move_request_queued
      usb: dwc3: gadget: stop transfers before disconnect
      usb: dwc3: ep0: call giveback instead of reimplementing it
      usb: dwc3: ep0: we only support one request on control ep
      usb: dwc3: gadget: no need to command completion IRQ
      usb: dwc3: gadget: nuke all requests on disconnect
      usb: dwc3: ep0: simply ep0 handlers
      usb: dwc3: gadget: decrease verbosity to dev_dbg
      usb: dwc3: ep0: fix a compile warning
      usb: dwc3: ep0: don't handle setup on xfernotready
      usb: dwc3: gadget: disconnect when removing gadget driver
      usb: dwc3: gadget: unregister gadget device
      usb: dwc3: ep0: don't access list_head without locks
      usb: dwc3: ep0: fix for ep0_do_setup_status
      usb: dwc3: gadget: no need for XferNotReady for Bulk
      usb: dwc3: gadget: don't stop transfers on control pipe
      usb: dwc3: gadget: a little re-organization
      usb: dwc3: gadget: don't rely on request_count
      usb: dwc3: gadget: pass the entire event to handler
      usb: dwc3: gadget: add more consts
      usb: dwc3: haps: rename to pci
      usb: dwc3: fix DAVADDR typo
      usb: dwc3: ep0: prevent a possible buffer overflow
      usb: dwc3: gadget: ep0 packet size in SS is 512
      usb: dwc3: gadget: increase maxpacket size of all non-0 eps
      usb: dwc3: gadget: add missing break
      usb: dwc3: gadget: disable the uneeded PHY
      usb: dwc3: gadget: use correct FIFO numbers
      usb: dwc3: gadget: enable XferNotReady for all endpoints
      usb: dwc3: gadget: always set bInterval
      usb: dwc3: gadget: check correct list
      usb: dwc3: gadget: check if request is valid
      usb: dwc3: add DWC3_EP_BUSY flag
      usb: dwc3: gadget: ep0/ep1 need direction too
      usb: dwc3: gadget: use XferNotReady IRQ
      usb: dwc3: gadget: control endpoints don't need XferInProgress
      usb: dwc3: gadget: print ep name when sending ep cmd
      usb: dwc3: gadget: verbose debug print for each IRQ
      usb: dwc3: pci: fix pci_set_drvdata() call
      usb: dwc3: gadget: add DWC3_EP_PENDING_REQUEST flag
      usb: dwc3: pci: add a name to the driver
      usb: dwc3: pci: use pci_resource_end()
      usb: dwc3: core: calculate timeout correctly
      usb: dwc3: core: request the memory region
      usb: dwc3: omap: set dma_mask and dma_parms
      usb: dwc3: pci: set coherent_dma_mask
      usb: dwc3: gadget: introduce helpers for powering PHYs
      usb: dwc3: ep0: set address on correct register
      usb: dwc3: gadget: reset USB PHYs during init
      usb: dwc3: gadget: don't overwrite DCFG
      usb: dwc3: core: allow for memory over 4GiB
      usb: dwc3: ep0: allow for memory over 4GiB
      usb: dwc3: gadget: no need to restart ep0 out
      usb: dwc3: gadget: put PHY in reset when powered down
      usb: dwc3: search and replace
      usb: dwc3: gadget: only set run/stop bit as the last step
      usb: dwc3: gadget: fix Kconfig entry
      usb: dwc3: gadget: move to threaded IRQ
      usb: dwc3: core: fix compile warning
      usb: dwc3: gadget: set correct port mode
      usb: dwc3: gadget: don't keep PHY in SoftRst
      usb: dwc3: gadget: wait a bit after SoftRst too
      usb: dwc3: gadget: fix compilation as module
      usb: dwc3: gadget: fix usb ep enable sequence
      usb: dwc3: gadget: drop ignore argument
      usb: dwc3: gadget: fix wrong logic
      usb: dwc3: ep0: fix device address setting
      usb: dwc3: gadget: reset PHYs on disconnect
      usb: dwc3: ep0: in case of error, tell gadget driver
      usb: dwc3: gadget: apply SuperSpeed connect/disconnect workaround
      usb: dwc3: gadget: move start/stop up in the source file
      usb: dwc3: gadget: move to udc_start/udc_stop
      usb: dwc3: gadget: move more code to udc_start/stop
      usb: dwc3: gadget: fix up ep0->maxpacket
      usb: dwc3: fix up a typo on our license header
      usb: dwc3: gadget: do not kick transfers on complete

Sebastian Andrzej Siewior (144):
      usb: dwc3: use platform_device_unregister()
      usb: dwc3: add a comment about the error case / use list iterator
      usb: dwc3: add missing break to dwc3_interrupt
      usb: dwc3: fix id detection
      usb: dwc3: add type for identify the event buffer type
      usb: dwc3: fixup event buffer definition
      usb: dwc3: reorganize event buffer handling
      usb: dwc3: make use of an if block instead of multiple depends
      usb: dwc3: handle error case in dwc3_gadget_init_endpoints()
      usb: dwc3: remove list head init
      usb: dwc3: add dwc3_gadget_free_endpoints
      usb: dwc3: add core deinit function
      usb: dwc3: gagdet: fix dev vs device
      usb: dwc3: again, use io instead of this
      usb: dwc3: save epnum in ep
      usb: dwc3: check for DevCtrlHl after touching START/STOP bit
      usb: dwc3: rename pullup dwc3_gadget_run_stop()
      usb: dwc3: add disconnect interrupt handling
      usb: dwc3: split dwc3_gadget_disconnect_interrupt()
      usb: dwc3: go through dwc3_gadget_reset_interrupt()
      usb: dwc3: partly revert "save epnum in ep"
      usb: dwc3: enlarge interrupt_number in dwc3_gadget_ep_depcfg_param1
      usb: dwc3: enlarge reserved16_14 in dwc3_gadget_ep_depcfg_param0
      usb: dwc3: go through connect done
      usb: dwc3: update dwc3_gadget_linksts_change_interrupt
      usb: dwc3: remove init list head in dwc3_gadget_ep_alloc_request()
      usb: dwc3: don't list_del on dwc3_gadget_ep_free_request()
      usb: dwc3: map dma later
      usb: dwc3: init request's dma address
      usb: dwc3: save the trb belonging to an request
      usb: dwc3: fix maybe not initialized value
      usb: dwc3: fix buffer address
      usb: dwc3: poll for command complete on the correct endpoint
      usb: dwc3: simple tx transfer of non ep0
      usb: dwc3: dwc3_gadget_conndone_interrupt() send msg to correct endpoint
      usb: dwc3: remove double assignment of bpl and length
      usb: dwc3: recognize ep0 correctly
      usb: dwc3: add an usb control request
      usb: dwc3: fix trb address
      usb: dwc3: add first setup phase for ep0
      usb: dwc3: prepare dwc3_ep0_start_dataphase() for split
      usb: dwc3: use dma_map() for the trb.
      usb: dwc3: split dwc3_ep0_start_trans() into dwc3_ep0_start_dataphase()
      usb: dwc3: add more ep0 bits
      usb: dwc3: remove dead block
      usb: dwc3: remove assignment of isp_imi
      usb: dwc3: move ep0 related functions into a separate file
      usb: dwc3: move DWC3_DEPCMD_SETTRANSFRESOURCE to dwc3_init_endpoint()
      usb: dwc3: don't init ep0/1 in gadget_init()
      usb: dwc3: add missing EP0_IN_WAIT_GADGET bits
      usb: dwc3: fix "is singular" assumption
      usb: dwc3: use delayed TRB allocations
      usb: dwc3: remove one level of indention
      usb: dwc3: remove __dwc3_gadget_kick_transfers()
      usb: dwc3: remove arguments from __dwc3_gadget_kick_transfer()
      usb: dwc3: clear TRB before usage
      usb: dwc3: fix the length argument in dwc3_endpoint_transfer_complete()
      usb: dwc3: don't enqueue new requsts unless it is the last one
      usb: dwc3: unmap the TRB earlier on completion
      usb: dwc3: remove irqreturn_t from most functions
      usb: dwc3: start ISOC transfers on XferNotReady event
      usb: dwc3: convert the current TRB queue design into a ring buffer
      usb: dwc3: make a lock less version of dwc3_gadget_ep_set_halt()
      usb: dwc3: go to EP0_OUT_WAIT_NRDY on XferNotReady event in EP0_OUT_WAIT_GADGET state
      usb: dwc3: stall and restart setup TRB in error case
      usb: dwc3: remove extra argument in dwc3_ep0_out_start()
      usb: dwc3: handle missing states in dwc3_ep0_start_trans()
      usb: dwc3: don't error out on EP0_*_WAIT_GADGET
      usb: dwc3: use usb_request directly dwc3_ep0_complete_data()
      usb: dwc3: start handling standard usb requests
      usb: dwc3: fixup Kconfig madness
      usb: dwc3: fix set addr to zero in dwc3_gadget_reset_interrupt()
      usb: dwc3: handle USB_REQ_SET_ADDRESS
      usb: dwc3: execute DWC3_DEPCMD_SETTRANSFRESOURCE for the correct EP
      usb: dwc3: handle USB_REQ_SET_CONFIGURATION
      usb: dwc3: let the gadgt driver handle requests by default
      usb: ch9: add function defines from ch9, USB 3.0 spec
      usb: dwc3: handle USB_REQ_CLEAR_FEATURE
      usb: dwc3: handle USB_REQ_SET_FEATURE
      usb: dwc3: merge dwc3_ep0_clear_feature() and dwc3_ep0_set_feature()
      usb: dwc3: remove WARN_ON() in XFERNOTREADY
      usb: dwc3: fixup typo
      usb: dwc3: prepare for ISOC updates
      usb: dwc3: toggle the HWO in dwc3_prepare_trbs() once the TRB is complete
      usb: dwc3: initialize request_list
      usb: dwc3: don't remove ep1 from the EP1 list
      usb: dwc3: move queued requests onto a seperate list
      usb: dwc3: allow to queue ISOC while ISOC are scheduled
      usb: dwc3: don't schedule ISOC if we don't have any requests
      usb: dwc3: add myself as the Co-Author
      usb: dwc3: support for 64bit addr_t
      usb: dwc3: generated IOC for ISOC more frequently
      usb: dwc3: link the ISOC TRBs
      usb: dwc3: fixup IOC/LST/CHN logic on ISOC
      usb: dwc3: return -EBUSY if the request is handled
      dwc: usb3: make __dwc3_gadget_kick_transfer() consider the correct list
      usb: dwc3: add 64bit support for TRBs
      arm: omap: use hwmod to create a dwc3 device
      usb: dwc3: remove driver name from haps
      usb: dwc3: fixup bitfield definitions
      usb: dwc3: remove CHN bit
      usb: dwc3: add a missing ;
      usb: dwc3: initialize dwc in dwc3_gadget_ep_disable()
      usb: dwc3: make the TRB structure endian safe
      usb: dwc3: invert wait logic in dwc3_send_gadget_ep_cmd()
      usb: dwc3: don't look at jiffies in dwc3_send_gadget_ep_cmd()
      usb: dwc3: use usb_endpoint_type() where possible
      usb: dwc3: remove locking from atomic context
      usb: dwc3: remove jiffies assumption in dwc3_gadget_run_stop()
      usb: dwc3: no need for irqsave() in dwc3_interrupt()
      usb: dwc3: don't flush the fifo on init
      usb: dwc3: nuke dwc3_gadget_ep_fifo_flush()
      usb: dwc3: gadget: send DEPCMD_SETEPCONFIG/DEPCMD_DEPSTARTCFG correctly
      usb: dwc3: fix DWC3_DALEPENA_EPIN() macro
      usb: dwc3: DWC3_DALEPENA_EP() is always used for both directions
      usb: dwc3: don't queue req for ep0/1 if something is going on
      usb: dwc3: simplify dwc3_prepare_trbs() by removing access request_count
      usb: dwc3: remove remaining request_count users request_count users
      usb: dwc3: add small todo list
      usb: dwc3: gadget: use computed value instead
      usb: dwc3: gadget: also disable IRQs on error path
      usb: dwc3: gadget: move put_device before goto label in err path
      uwb: dwc3: gadget: convert dwc3 to new udc class
      usb: dwc3: gadget: remove __devexit from exit path (dwc3_gadget_exit)
      usb: dwc3: gadget: fix starting one EP more than once
      usb: dwc3: gadget: don't treat -EBUSY on TRANSFER_NOT_READY
      usb: dwc3: omap: recognize the error on getting irq properly
      usb: dwc3: gadget: fix maxpacket size for SS
      usb: dwc3: gadget: fix multi TRB handling
      usb: dwc3: gadget: don't set IOC bit
      usb: dwc3: fix XferResourceIndex mask
      usb: dwc3: gadget: don't sleep in interrupt
      usb: dwc3: gadget: remove isp_imi for non ISO
      usb: dwc3: gadget: add TEST_MODE
      usb: dwc3: gadget: use proper endian accessor for wMaxPacketSize
      usb: dwc3: gadget: use the length of the name array
      usb: dwc3: gadget: handle short-packets-OUT transfers
      usb: dwc3: gadget: use GFP_ATOMIC in ep_enable
      usb: dwc3: gadget: don't queue transfers if we got interrupt on a short packet
      usb: dwc3: gadget: handle more cases in the clean up routine
      usb: dwc3: gadget: ep0: use wIndex and initialize it
      usb: dwc3: gadget: fixup merge conflict for "proper endian accessor for wMaxPacketSize"
      usb: dwc3: gadget: fix usb enpoint numbering
      usb: dwc3: add test mode support

[1] http://www.ti.com/omap5
[2] https://www.synopsys.com/apps/haps/index.php
[3] http://marc.info/?l=linux-usb&m=131341992020339&w=2
[4] http://git.kernel.org/?p=linux/kernel/git/balbi/usb.git;a=shortlog;h=refs/heads/dwc3-history

Felipe Balbi (2):
  usb: gadget: introduce gadget_is_dwc3()
  usb: Introduce DesignWare USB3 DRD Driver

Sebastian Andrzej Siewior (2):
  arm: omap: use hwmod to create a dwc3 device
  usb: ch9: add function defines from ch9, USB 3.0 spec

 Documentation/usb/dwc3.txt            |   53 +
 arch/arm/mach-omap2/Makefile          |    3 +
 arch/arm/mach-omap2/usb-dwc3.c        |   49 +
 arch/arm/plat-omap/include/plat/usb.h |    6 +
 drivers/usb/Kconfig                   |    2 +
 drivers/usb/Makefile                  |    2 +
 drivers/usb/dwc3/Kconfig              |   25 +
 drivers/usb/dwc3/Makefile             |   22 +
 drivers/usb/dwc3/core.c               |  445 ++++++++
 drivers/usb/dwc3/core.h               |  700 ++++++++++++
 drivers/usb/dwc3/debug.h              |   51 +
 drivers/usb/dwc3/debugfs.c            |  534 +++++++++
 drivers/usb/dwc3/dwc3-omap.c          |  393 +++++++
 drivers/usb/dwc3/dwc3-pci.c           |  172 +++
 drivers/usb/dwc3/ep0.c                |  782 +++++++++++++
 drivers/usb/dwc3/gadget.c             | 1974 +++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/gadget.h             |  292 +++++
 drivers/usb/dwc3/io.h                 |   55 +
 drivers/usb/gadget/Kconfig            |   12 +
 drivers/usb/gadget/composite.c        |    6 +-
 drivers/usb/gadget/gadget_chips.h     |    3 +
 include/linux/usb/ch9.h               |    5 +
 22 files changed, 5584 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/usb/dwc3.txt
 create mode 100644 arch/arm/mach-omap2/usb-dwc3.c
 create mode 100644 drivers/usb/dwc3/Kconfig
 create mode 100644 drivers/usb/dwc3/Makefile
 create mode 100644 drivers/usb/dwc3/core.c
 create mode 100644 drivers/usb/dwc3/core.h
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/debugfs.c
 create mode 100644 drivers/usb/dwc3/dwc3-omap.c
 create mode 100644 drivers/usb/dwc3/dwc3-pci.c
 create mode 100644 drivers/usb/dwc3/ep0.c
 create mode 100644 drivers/usb/dwc3/gadget.c
 create mode 100644 drivers/usb/dwc3/gadget.h
 create mode 100644 drivers/usb/dwc3/io.h

-- 
1.7.6.396.ge0613

