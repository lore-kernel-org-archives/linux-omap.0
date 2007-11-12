From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 0/4] 32k timer reorg and sched_clock cleanup
Date: Mon, 12 Nov 2007 15:24:01 -0800
Message-ID: <20071112232401.723638265@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[ resend of previous series, with more sched_clock cleanup ]

Here's a short series of patches to reorganize and consolidate the 32k
timer code and the implementation of sched_clock().  In particular,
conslidate the usage of DM timers, move the OMAP1 specifics into
mach-omap1, and have only one sched_clock().

Kevin

--
