From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Bad page state in tidspbridge driver
Date: Sun, 8 Jan 2012 19:17:31 +0100
Message-ID: <201201081917.31376.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:58635 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab2AHSRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jan 2012 13:17:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Arne Caspari <arne@unicap-imaging.org>

Hi,

I'm hitting what seems to be a tidspbridge driver issue when using gst-dsp 
with the DSP JPEG encoder.

My application captures images from the OMAP3 ISP directly to frame buffer 
memory for display. It then passes the frame buffer buffer pointer to gst-dsp 
and the tidspbridge driver, which maps them to the DSP IOMMU address space.

When starting the JPEG encoder a bunch of identical messages are printed to 
the kernel log:

[14643.065490] BUG: Bad page state in process source:src  pfn:89e39
[14643.072143] page:c0b11720 count:0 mapcount:0 mapping:  (null) index:0x0
[14643.079437] page flags: 0x410(dirty|reserved)
[14643.084197] [<c003ee5c>] (unwind_backtrace+0x0/0xe0) from [<c00a4c34>] 
(bad_page+0xc4/0xec)
[14643.093505] [<c00a4c34>] (bad_page+0xc4/0xec) from [<c00a5480>] 
(free_pages_prepare+0x70/0xe8)
[14643.102935] [<c00a5480>] (free_pages_prepare+0x70/0xe8) from [<c00a5634>] 
(free_hot_cold_page+0x20/0x1ac)
[14643.113525] [<c00a5634>] (free_hot_cold_page+0x20/0x1ac) from [<bf00d120>] 
(bridge_brd_mem_un_map+0x12c/0x3d4 [bridgedriver])
[14643.126007] [<bf00d120>] (bridge_brd_mem_un_map+0x12c/0x3d4 [bridgedriver]) 
from [<bf01cda8>] (proc_un_map+0x6c/0xa0 [bridgedriver])
[14643.139404] [<bf01cda8>] (proc_un_map+0x6c/0xa0 [bridgedriver]) from 
[<bf014490>] (api_call_dev_ioctl+0xe8/0x10c [bridgedriver])
[14643.152160] [<bf014490>] (api_call_dev_ioctl+0xe8/0x10c [bridgedriver]) 
from [<bf0208b8>] (bridge_ioctl+0x12c/0x15c [bridgedriver])
[14643.165191] [<bf0208b8>] (bridge_ioctl+0x12c/0x15c [bridgedriver]) from 
[<c00d8fd8>] (do_vfs_ioctl+0x4e8/0x55c)
[14643.176177] [<c00d8fd8>] (do_vfs_ioctl+0x4e8/0x55c) from [<c00d9080>] 
(sys_ioctl+0x34/0x54)
[14643.185333] [<c00d9080>] (sys_ioctl+0x34/0x54) from [<c003a700>] 
(ret_fast_syscall+0x0/0x3c)

The backtrace is printed because the page has the PG_reserved flag set, which 
is expected (as far as I know) for the frame buffer memory.

Is this use case unsupported ?

-- 
Regards,

Laurent Pinchart
