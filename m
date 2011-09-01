From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Date: Thu, 1 Sep 2011 13:47:52 +0100
Message-ID: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Some systems (such as OMAP) preserve the L2 cache across a suspend/
resume cycle.  This means they do not perform L2 cache maintanence
in their suspend finisher function.

However, the side effect is that the saved CPU state is not readable
by the resume code because it is sitting in the L2 cache.

This patch series adds L2 cache cleaning to the generic CPU suspend/
resume support code, making it possible to use this on systems with
L2 cache enabled without having to clean/invalidate the entire L2
cache.

We also add a separate page table, allocated at boot time, for the
resume process to use so we don't have to fiddle about with tweaking
entries in the current processes page table.  Moreover, the current
processes page table may be in use by another CPU in the system if
these paths are used from cpuidle or hotplug, so changing the page
table is technically unsound.

Overall, this makes it possible for OMAP4 systems to use this code.

The first four patches in this set are already merged into Linus' tree
as bug fixes, and are included here for completeness given that the
kernel.org infrastructure is currently offline.

This has (so far) only been tested on OMAP4.  Further testing on OMAP3
and Assabet will follow.
