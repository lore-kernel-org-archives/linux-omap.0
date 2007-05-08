From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated
Date: Mon, 7 May 2007 20:19:45 -0700
Message-ID: <20070508031945.GH31968@atomide.com>
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

I've updated our git tree to be in sync with mainline tree as Russell
has merged some of our pending patches.

Looks like 24xx does not currently boot, it seems to hang at
devicemaps_init(). I've verified that at least 16xx boots.

I'll have to continue debugging the 24xx devicemaps_init issue tomorrow,
if somebody gets it working before that, please post the patch :)

Regards,

Tony
