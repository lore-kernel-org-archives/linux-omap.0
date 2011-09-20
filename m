From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
Date: Tue, 20 Sep 2011 12:45:27 +0100
Message-ID: <20110920114527.GA15663@e102568-lin.cambridge.arm.com>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 19, 2011 at 05:37:41PM +0100, Russell King - ARM Linux wrote:
> This is a re-post of the previous patch series, but with an additional
> TLB flush to ensure that hte global TLB entry in the page tables is
> flushed out.  This is a flush of all TLB entries, but it could probably
> be more targetted if we need to.
> 
> Original cover mail follows:
> 
> Some systems (such as OMAP) preserve the L2 cache across a suspend/
> resume cycle.  This means they do not perform L2 cache maintanence
> in their suspend finisher function.
> 
> However, the side effect is that the saved CPU state is not readable
> by the resume code because it is sitting in the L2 cache.
> 
> This patch series adds L2 cache cleaning to the generic CPU suspend/
> resume support code, making it possible to use this on systems with
> L2 cache enabled without having to clean/invalidate the entire L2
> cache.
> 
> We also add a separate page table, allocated at boot time, for the
> resume process to use so we don't have to fiddle about with tweaking
> entries in the current processes page table.  Moreover, the current
> processes page table may be in use by another CPU in the system if
> these paths are used from cpuidle or hotplug, so changing the page
> table is technically unsound.
> 
> Overall, this makes it possible for OMAP4 systems to use this code.
> 
> 

Thanks Russell for this.
As expected, it does fix the issue. Tested on ARM internal platforms
and Origen with both suspend and cpuidle. So, on the whole series:

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
