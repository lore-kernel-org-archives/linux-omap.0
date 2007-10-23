From: Tony Lindgren <tony@atomide.com>
Subject: About to tag 2.6.23-omap1
Date: Mon, 22 Oct 2007 18:19:21 -0700
Message-ID: <20071023011920.GL17318@atomide.com>
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

Hi all,

I'm planning to tag 2.6.23-omap1 tomorrow morning PST with current
linux-omap git tree unless somebody comes up with fixes that still
should go in.

So only fixes right now please, then let's update the tree to
mainline kernel, and try to get most of the pending patches such as
mmc, v4l, osk-2420, omap2-nand etc applied (and fixed if needed).

After that, let's plan on doing the move of arch/arm/plat-omap/dsp
to drivers/dsp/omap. And then we prepare patches do the fixes needed
for Russell for plat-omap and mach-omap1 before 2.6.24-rc5 to try to
get them mostly in sync with mainline. Then we can hopefully sync up
mach-omap2 for 2.6.25-rc5.

Cheers,

Tony
