From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 0/2] MUSB: tracking down locking bugs
Date: Thu, 30 Aug 2007 19:53:59 -0700
Message-ID: <20070831025359.663866890@mvista.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

With the help of the lock debugging features of the -rt patch, I'm
trying to track down locking issues in the MUSB driver.

For starters, here's one fix and a patch which BUGs under potential
deadlocks for aid in tracking down more potential deadlock paths.

Kevin
--
