From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: OMAP3 DSPBridge review
Date: Wed, 16 Apr 2008 20:12:04 +0530
Message-ID: <5d5443650804160742y71ae769dub7716e75b77a40e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:12867 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYDPOmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 10:42:10 -0400
Received: by nf-out-0910.google.com with SMTP id g13so712871nfb.21
        for <linux-omap@vger.kernel.org>; Wed, 16 Apr 2008 07:42:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Hari,

I was just going this dspbridge code, and I was surprised to find
layers for un-necessary things, where we could have simply called the
linux kernel provided function. Here goes the list:

1. There is un-necessary "linux" directory inside mpu_driver source
codes. e.g src/osal/linux etc. I hope we are writing this code for
Linux kernel only.
2. src/osal/linux
  - As the name suggest for directory it is OS Abstraction layer for
Linux. I don't see any need for this at all. In Linux kernel, we
follow approach of directly calling the provided functions and not to
further wrap it until necessary.

src/osal/list.c

- This whole file tries implement doubly linked list code, I am sure
you can get away this with list.h itself. I don't see any need of
further wrapping it.

src/osal/kfile.c

- Don't use KENREL_VERSION comparision check unless very much
necessary, always try to keep driver in sync in latest kernel version
instead.
- Again there are wrappers for file reading functions provided by kernel.
- If this functions are only used for doff loader, then moving it to
outside kernel space, then we can get away with this functions.

src/osal/mem.c

- I see here that you guys are maintaining the pool of memory
allocated with dma_alloc_coherent, you guys should have used existing
mempool apis instead, look at dspgw code for example.

src/osal/isr.c

- Not required, please call request_irq/free_irq directly please. I
also see lots of #ifdef LINUX and #ifndef LINUX, does TI also target
to build this code for WinCE and Symbian like OS. If yes, I don't see
how we are going to maintain this along with community.

src/osal/dpc.c - please call tasklet functions directly instead.

src/pmgr/linux/common/dmm.c -

Please correct if my undestanding is in-correct for dmm.c - Here you
guys are trying to manage the virtual memory of target (dsp/iva) as
linked list of node, so that reserved memory from ARM can be mapped to
DSP and then can be used as shared memory. If we are trying manage
virtual memory in Gigabytes , e.g 2GB for IVA1.0, then doubly linked
list may not be optimal for searching the free node, where we can map
this buffer.

You guys should have used lib/bitmap.c functions for creating bitmap,
once the bitmap is created use bitmap_find_free_region, which is very
fast. For example of this function grep in SH architecture code.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
