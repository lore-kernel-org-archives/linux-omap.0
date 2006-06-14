From: Kevin Hilman <khilman@deeprooted.net>
Subject: Fix dyntick locking patch upstream?
Date: Wed, 14 Jun 2006 11:14:41 -0700
Message-ID: <1150308881.20600.25.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony,

Is the 'fix dyntick locking' patch below planned to be sent upstream?  I
don't see it in Linus' tree.

I'm working on testing Ingo's realtime and generic IRQ stuff on OMAP
2.6.17-rc6 and this is one of the diffs that causes Ingo's patch to not
apply cleanly.

Kevin



commit c93034aee87c2e22f3e7c136e08e5830610cd083
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed May 10 02:50:03 2006 -0700

    ARM: Fix dyntick locking

    This patch fixes some dyntick locking issues on ARM as pointed
    out by Russell King.

    Signed-off-by: Tony Lindgren <tony@atomide.com>
