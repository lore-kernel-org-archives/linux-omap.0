From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [DSPBRIDGE RFC] Combining Reserve and Map into a new IOCTL
Date: Wed, 2 Sep 2009 18:38:23 +0300
Message-ID: <20090902153823.GB6174@annwn.research.nokia.com>
References: <4A9D2313.4040408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61532 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZIBPic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 11:38:32 -0400
Content-Disposition: inline
In-Reply-To: <4A9D2313.4040408@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>

On Tue, Sep 01, 2009 at 03:35:15PM +0200, Ameya Palande wrote:
> Hi,
> 
> Current DSPBridge MPU side API provides following IOCTLs which are related to
> reserving and mapping DSP address space:
> 
> 1. DSPProcessor_ReserveMemory(): Reserve a virtually contiguous region of DSP
>    address space.
> 2. DSPProcessor_Map(): Maps an MPU buffer to the DSP virtual address space.
> 3. DSPProcessor_UnMap(): Remove an MPU buffer mapping from the DSP virtual
>    address space.
> 4. DSPProcessor_UnReserveMemory(): Frees a previously reserved region of the
>    DSP virtual address space.
> 
> Typical call sequence is:
> 
> DSPProcessor_ReserveMemory()
> DSPProcessor_Map()
> DSPProcessor_UnMap()
> DSPProcessor_UnReserveMemory()
> 
> Current approach has following problems:
> 1. Caller has to perform 4 system calls in order to map and unmap a buffer.
> 2. Kernel has no idea about the type of buffer (input/output). So depending
>    on buffer type caller has to explicitly call DSPProcessor_FlushMemory() or
>    DSPProcessor_InvalidateMemory().
> 
> Proposed approach:
> Introduce 2 new IOCTLs which combine (reserve, map) and (unmap, unreserve).
> Caller should also specify buffer type (input/output) attribute as a
> parameter to new mapping IOCTL.
> 
> Benefits of new approach:
> 1. Saves 2 system calls per map and unmap pair.
> 2. By implementing lazy unreserve we can introduce cache of reserved
>    mappings, which can skip reserve, unreserve operations.
> 3. Kernel can take care of flushing/invalidating cache depending on buffer
>    type, which saves system call overhead and removed explicit cache control
>    from user space.
> 
> These IOCTLs can be added to the current set of API which doesn't break
> compatibility with old applications.
> 
> Waiting for comments!
> 
> Ideas proposed in this document are from:
> 1. Hiroshi Doyu <hiroshi.doyu@nokia.com>
> 2. Felipe Contreras <felipe.contreras@nokia.com>

The whole proposal looks good to me :)

However, sometimes you would still want to do some extra cache
operations afer Map() there should be a way to do 'flush', 'clean' and
'inv'.

Cheers.

-- 
Felipe Contreras
