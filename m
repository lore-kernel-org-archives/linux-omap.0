From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] musb_hdrc: Replace MGC_ with MUSB_, misc OPT test fixes
Date: Fri, 17 Aug 2007 04:44:37 -0700
Message-ID: <118735108469-git-send-email-tony@atomide.com>
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

Hi all,

Attached patch series gets rid of the last MGC_ occurances
replacing them with MUSB_ as these variables are MUSB driver
specific and not common to all Mentor drivers.

Also few HS OPT fixes that make the tests run reliably
even the same tests are run multiple times.

Tested on tusb.

Regards,

Tony
