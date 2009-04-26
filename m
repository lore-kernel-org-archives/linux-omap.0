From: omar ramirez <or.rmz1@gmail.com>
Subject: [RFC] dspbridge: staging todo list
Date: Sun, 26 Apr 2009 11:07:18 -0500
Message-ID: <983c694e0904260907o2e10da56xffeade20f1b3ff7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:62561 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZDZQHT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 12:07:19 -0400
Received: by ewy24 with SMTP id 24so1761061ewy.37
        for <linux-omap@vger.kernel.org>; Sun, 26 Apr 2009 09:07:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: menon.nishanth@gmail.com, felipe.contreras@gmail.com, ameya.palande@nokia.com, dedekind@yandex.ru

Hi,

This is my personal TODO list, I gathered this from the comments
received from the list, mainly from Trilok Soni (TS), Hiroshi Doyu
(HD), Felipe Contreras (FC), Artem Biyutskiy (AB).

Let me know your thoughts or if you have something else to add.

- Remove the layers for unnecesary things (TS)
  - drivers/dsp/bridge/services/list.c
  This whole file tries implement doubly linked list code, I am sure you can
  get away this with list.h itself. I don't see any need of further wrapping it.

  - drivers/dsp/bridge/services/kfile.c
  Again there are wrappers for file reading functions provided by kernel.
  If this functions are only used for doff loader, then moving it to outside
  kernel space, then we can get away with this functions.

  - drivers/dsp/bridge/services/mem.c
  I see here that you guys are maintaining the pool of memory allocated with
  dma_alloc_coherent, you guys should have used existing mempool apis instead,
  look at dspgw code for example.

  - drivers/dsp/bridge/services/dpc.c
  call tasklet functions directly instead.

  - drivers/dsp/bridge/services/dmm.c
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

  - Remove any comment or piece of code that makes reference to other OS.

- Use mempool_* kernel API interfaces instead of having module parameter
phys_mempool* to reserve big amount of memory (HD)

- Clock module either to be removed or to use other clock interface(FC, HD)

- Remove bridge debug system (GT_Trace) and keep only the meaningful pr_*
  calls (AB), probably need to maintain this as a separate patch if needed. (OR)

- Stop using excessive enums (AB).

- Use normal types (AB) (i.e. remove DSP_STATUS and similar)

- Change error codes to return 0 on success and negative value on error,
  DSP_EFAIL and DSP_SOK. (AB)

- The code excessively uses these u32 types. (AB)

- Remove CamelCase and Hungarian notation.

---
omar ramirez
