From: Kevin Hilman <khilman@mvista.com>
Subject: oprofile on OMAP2: ARM11 PMU interrupts?
Date: Fri, 26 Oct 2007 10:37:58 -0700
Message-ID: <472225F6.9070502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Is anyone using oprofile on OMAP2?

A quick test of the current code in current git doesn't seem to work.  I
see the PMU being configured, IRQ3 being registered but no interrupts
ever fire on that IRQ, and thus no data is collected.

I tested on a 2420/H4 and 2430SDP with same results.  In both cases, the
IRQ is configured to IRQ3, which in the TRM says 'BENCH MPU emulation'.
 I have no idea what that means, but it doesn't sound like the ARM11 PMU
interrupt to me though.

Any ideas?

Kevin
