From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 19/19] MAINTAINERS: Add OMAP2/3 DSS and
	OMAPFB maintainer
Date: Mon,  9 Nov 2009 13:45:26 +0200
Message-ID: <1257767126-12059-20-git-send-email-tomi.valkeinen@nokia.com>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-2-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-3-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-4-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-5-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-6-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-7-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-8-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-9-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-10-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-11-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-12-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-13-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-14-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-15-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-16-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-17-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-18-git-send-email-tomi.valkeinen@nokia.com>
	<1257767126-12059-19-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1257767126-12059-19-git-send-email-tomi.valkeinen@nokia.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 MAINTAINERS |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd633a6..0939a2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3853,6 +3853,23 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/video/omap/
 
+OMAP DISPLAY SUBSYSTEM SUPPORT (DSS2)
+M:	Tomi Valkeinen <tomi.valkeinen@nokia.com>
+L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/video/omap2/dss/
+F:	drivers/video/omap2/vrfb.c
+F:	drivers/video/omap2/vram.c
+F:	Documentation/arm/OMAP/DSS
+
+OMAP FRAMEBUFFER SUPPORT (FOR DSS2)
+M:	Tomi Valkeinen <tomi.valkeinen@nokia.com>
+L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/video/omap2/omapfb/
+
 OMAP MMC SUPPORT
 M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
 L:	linux-omap@vger.kernel.org
-- 
1.6.5.1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
