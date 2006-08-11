From: Jonathan McDowell <noodles@earth.li>
Subject: Framebuffer status in latest git?
Date: Fri, 11 Aug 2006 16:14:01 +0100
Message-ID: <20060811151401.GT27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

I'm finding the framebuffer isn't working in latest git, but does in
2.6.17-omap2. I can't see any changes in drivers/video/omap between the
two. Is anyone else experiencing this (or is anyone successfully using
the framebuffer with latest git)?

(This is on the Amstrad Delta, so OMAP150, with a patch that isn't yet
in git but is the same for both 2.6.17-omap2 and latest git - I was in
the process of making sure it still worked so I could submit it.)

J.

-- 
/-\                             |     A PBS mind in an MTV world.
|@/  Debian GNU/Linux Developer |
\-                              |
