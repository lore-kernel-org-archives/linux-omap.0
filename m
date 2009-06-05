From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 05/06] OMAP3: PM: Implement locking for any scratchpad
 access
Date: Fri, 5 Jun 2009 16:54:29 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E092D2D@dlee02.ent.ti.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
 <1243514587-5323-2-git-send-email-rnayak@ti.com>
 <1243514587-5323-3-git-send-email-rnayak@ti.com>
 <1243514587-5323-4-git-send-email-rnayak@ti.com>
 <1243514587-5323-5-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.0906051445230.31531@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbZFEVyj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 17:54:39 -0400
In-Reply-To: <alpine.DEB.2.00.0906051445230.31531@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Friday, June 05, 2009 4:26 PM

> On Thu, 28 May 2009, Rajendra Nayak wrote:
>
> > This patch implements locking using the semaphore in scratchpad
> > memory preventing any concurrent access to scratchpad from OMAP
> > and Baseband/Modem processor.
>
> This patch might be okay for the target use case.  But there might still
> be a race window with this patch, where the modem could steal the MPU's
> lock or vice versa.
>
> That swp tries to guarantee atomicity through exclusive memory accesses,
> but the AXI2OCP bridge section of the TRM claims that the bridge
> translates "exclusive accesses to non-exclusive read/write in the bridge"
> (section 3.2.3.2).  That seems to suggest that the memory accesses will be
> non-atomic and that therefore a race window exists.

This is an incorrect interpretation.  A race does not exist because of this point.

The AXI2OCP does translate external excusive operations this way (STREX/LWREX).  This is not the same for SWP.  SWP generates a global bus lock.

Exclusive operations do have a reservation in the L2 block.  So they are good until they go to external memory.  On OMAP these work as you expect with respect to the ARM, but won't work between ARM and DSP or other master.

SWP on the other hand still works.  SWP is a relative pig compared to STREX/LWREX as it locks the whole L3, compared to a small key address, but, it's a lot lighter than a mailbox.


Regards,
Richard W.

