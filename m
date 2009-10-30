From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [ANNOUNCE] updated dspbridge on linux-omap
Date: Fri, 30 Oct 2009 13:23:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426A1666E@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932792AbZJ3SX4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 14:23:56 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "ext-andriy.shevchenko@nokia.com" <ext-andriy.shevchenko@nokia.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>, "Shah, Bhavin" <bshah@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hi,

Dspbridge branch at linux-omap was updated with most of the latest patches received through the mailing list.

At this point, only "LIST removal" patches and "REG being changed to a linked list" patch are missing due to review.

Thanks for your contribution.

omar

---

Ameya Palande (2):
  DSPBRIDGE: Remove DSP_Close
  DSPBRIDGE: Get rid of mixed declaration code warning

Andy Shevchenko (16):
  dspbridge: Remove useless check
  dspbridge: Drop useless memory allocation
  DSPBRIDGE: Check input value
  dspbridge: Check pointer returned by MEM_Calloc()
  dspbridge: Check pointer before dereferencing it
  dspbridge: Check pointer before usage
  DSPBRIDGE: don't use potential invalid pointer in proc.c
  DSPBRIDGE: remove unused piece of code
  dspbridge: relocate MEM_ExtPhysPoolRelease() call
  DSPBRIDGE: OSAL: Remove CSL
  DSPBRIDGE: OSAL: Get rid of KFILE
  dspbridge: clean up errbase.h
  DSPBRIDGE: OSAL: Simplify REG API
  DSPBRIDGE: OSAL: Clean up dbreg.h and move it
  DSPBRIDGE: OSAL: Remove printS()
  dspbridge: Remove include duplicates

Felipe Balbi (6):
  DSPBRIDGE: use ARRAY_SIZE
  DSPBRIDGE: wcd: else is unnecessary
  DSPBRIDGE: rename Kbuild to Makefile
  DSPBRIDGE: always use dynamic major/minor numbers
  DSPBRIDGE: convert kmalloc() memset() to kzalloc()
  DSPBRIDGE: beautify error path

Fernando Guzman Lugo (1):
  DSPBRIDGE: Fix for RSTCTRL and RSTST register offset

Hiroshi DOYU (3):
  DSPBRIDGE: cleanup for PROC_FlushMemory/PROC_InvalidateMemory
  DSPBRIDGE: introduce VMA checking for cache operation
  DSPBRIDGE: add check if end address is included within VMA or not

Hiroshi Doyu (1):
  DSPBRIDGE: update checking VMA for cache operation

Omar Ramirez Luna (4):
  DSPBRIDGE: check the status of DMM_GetHandle
  DSPBRIDGE: Remove unused curr_pid variable
  DSPBRIDGE: KFILE_Seek & KFILE_Tell, u32 replaced with loff_t
  DSPBRIDGE: Delete unused file dbl.c

Phil Carmody (5):
  dspbridge: static code analysis issues - dead code path
  dspbridge: static code analysis issues - useless null pointer checks
  dspbridge: static code analysis issues - remember if GS_init
    succeeded
  dspbridge: static code analysis issues - failure to handle null
    paramters
  dspbridge: static code analysis issues - don't dereference NULL

