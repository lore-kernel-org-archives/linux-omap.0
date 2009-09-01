From: Ameya Palande <ameya.palande@nokia.com>
Subject: [DSPBRIDGE RFC] Combining Reserve and Map into a new IOCTL
Date: Tue, 01 Sep 2009 16:35:15 +0300
Message-ID: <4A9D2313.4040408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36734 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZIANfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 09:35:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Doyu Hiroshi <hiroshi.doyu@nokia.com>, Contreras Felipe <felipe.contreras@nokia.com>, Tereshonkov Roman Sergeevitch <roman.tereshonkov@nokia.com>

Hi,

Current DSPBridge MPU side API provides following IOCTLs which are related to
reserving and mapping DSP address space:

1. DSPProcessor_ReserveMemory(): Reserve a virtually contiguous region of DSP
   address space.
2. DSPProcessor_Map(): Maps an MPU buffer to the DSP virtual address space.
3. DSPProcessor_UnMap(): Remove an MPU buffer mapping from the DSP virtual
   address space.
4. DSPProcessor_UnReserveMemory(): Frees a previously reserved region of the
   DSP virtual address space.

Typical call sequence is:

DSPProcessor_ReserveMemory()
DSPProcessor_Map()
DSPProcessor_UnMap()
DSPProcessor_UnReserveMemory()

Current approach has following problems:
1. Caller has to perform 4 system calls in order to map and unmap a buffer.
2. Kernel has no idea about the type of buffer (input/output). So depending
   on buffer type caller has to explicitly call DSPProcessor_FlushMemory() or
   DSPProcessor_InvalidateMemory().

Proposed approach:
Introduce 2 new IOCTLs which combine (reserve, map) and (unmap, unreserve).
Caller should also specify buffer type (input/output) attribute as a
parameter to new mapping IOCTL.

Benefits of new approach:
1. Saves 2 system calls per map and unmap pair.
2. By implementing lazy unreserve we can introduce cache of reserved
   mappings, which can skip reserve, unreserve operations.
3. Kernel can take care of flushing/invalidating cache depending on buffer
   type, which saves system call overhead and removed explicit cache control
   from user space.

These IOCTLs can be added to the current set of API which doesn't break
compatibility with old applications.

Waiting for comments!

Ideas proposed in this document are from:
1. Hiroshi Doyu <hiroshi.doyu@nokia.com>
2. Felipe Contreras <felipe.contreras@nokia.com>

Cheers,
Ameya.
