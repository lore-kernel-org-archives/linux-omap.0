From: Brian Swetland <swetland@google.com>
Subject: omapfb -- panel initialization inflexibility
Date: Fri, 2 Dec 2005 19:42:19 -0800
Message-ID: <20051203034219.GA1516@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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


I have an lcd panel connected to a omap730 based system that *requires*
that MCK, HSYNC, and VSYNC are active when it is powered on.  It will
not initialize correctly otherwise.

I've modified my omapfb driver so that there is a new OMAP_LCDC_*
flag (OMAP_LCDC_PANEL_INIT_AFTER_LCDC) that determines if the
enable hook is called where it is in the existing driver, or if
it is called after omapfb_set_update_mode() returns.

Any objections to this workaround?  Any suggestions for a better
name for the flag?  Is there a better value than 0x200 for the flag?

Thanks,

Brian
