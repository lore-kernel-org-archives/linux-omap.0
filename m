From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
Date: Thu, 01 Jul 2010 15:05:44 -0700
Message-ID: <1278021944.7738.43.camel@c-dwalke-linux.qualcomm.com>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	 <1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	 <20100701101746.3810cc3b.randy.dunlap@oracle.com>
	 <20100701180241.GA3594@basil.fritz.box>
	 <1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
	 <20100701193850.GB3594@basil.fritz.box>  <4C2D0FF1.6010206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <4C2D0FF1.6010206@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: Zach Pfeffer <zpfeffer@codeaurora.org>
Cc: Andi Kleen <andi@firstfloor.org>, Randy Dunlap <randy.dunlap@oracle.com>, mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-07-01 at 15:00 -0700, Zach Pfeffer wrote:


> Additionally, the current IOMMU interface does not allow users to
> associate one page table with multiple IOMMUs unless the user explicitly
> wrote a muxed device underneith the IOMMU interface. This also could be
> done, but would have to be done for every such use case. Since the
> particular topology is run-time configurable all of these use-cases and
> more can be expressed without pushing the topology into the low-level
> IOMMU driver.
> 
> The VCMM takes the long view. Its designed for a future in which the
> number of IOMMUs will go up and the ways in which these IOMMUs are
> composed will vary from system to system, and may vary at
> runtime. Already, there are ~20 different IOMMU map implementations in
> the kernel. Had the Linux kernel had the VCMM, many of those
> implementations could have leveraged the mapping and topology management
> of a VCMM, while focusing on a few key hardware specific functions (map
> this physical address, program the page table base register).

So if we include this code which "map implementations" could you
collapse into this implementations ? Generally , what currently existing
code can VCMM help to eliminate?

Daniel

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
