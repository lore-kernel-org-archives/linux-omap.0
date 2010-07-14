From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
Date: Wed, 14 Jul 2010 23:05:36 +0100
Message-ID: <20100714220536.GE18138@n2100.arm.linux.org.uk>
References: <4C3C0032.5020702@codeaurora.org> <20100713150311B.fujita.tomonori@lab.ntt.co.jp> <20100713121420.GB4263@codeaurora.org> <20100714104353B.fujita.tomonori@lab.ntt.co.jp> <20100714201149.GA14008@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100714201149.GA14008@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
To: Zach Pfeffer <zpfeffer@codeaurora.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 14, 2010 at 01:11:49PM -0700, Zach Pfeffer wrote:
> If the DMA-API contained functions to allocate virtual space separate
> from physical space and reworked how chained buffers functioned it
> would probably work - but then things start to look like the VCM API
> which does graph based map management.

Every additional virtual mapping of a physical buffer results in
additional cache aliases on aliasing caches, and more workload for
developers to sort out the cache aliasing issues.

What does VCM to do mitigate that?
