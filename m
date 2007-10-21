From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] musb_hdrc: Improve tusb clocking,
	add musb_platform_wakeup()
Date: Sun, 21 Oct 2007 16:20:50 -0700
Message-ID: <119300885686-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: musb-2007-10-21
References: musb-2007-10-21
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

Attached series improves cleans up musb_gadget_ep0 a bit, improves
tusb clock handling, and introduces musb_platform_wakeup().

Tested on tusb.

BTW, regarding sending these patches upstream, I probably won't have time
to prepare the series and do the necessary clean-up for next few weeks
because of some work stuff I need to deal with.

Regards,

Tony
