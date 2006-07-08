From: Jonathan McDowell <noodles@earth.li>
Subject: ARM: OMAP: omapfb: Fix 444 mode after recent LCD changes
Date: Sat, 8 Jul 2006 23:55:51 +0100
Message-ID: <20060708225551.GA26313@earth.li>
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

The recent changes to the LCD driver have broken the 444 mode (where a
12 bit panel is driven from 16 bits in memory). This one liner fixes it
for me.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff -ruNp -X linux-2.6.17-e3-05/Documentation/dontdiff linux-2.6.17-e3-05/drivers/video/omap/omapfb_main.c linux-2.6.17-e3-06/drivers/video/omap/omapfb_main.c
--- linux-2.6.17-e3-05/drivers/video/omap/omapfb_main.c	2006-07-08 18:39:14.963928000 +0100
+++ linux-2.6.17-e3-06/drivers/video/omap/omapfb_main.c	2006-07-08 23:46:51.969142000 +0100
@@ -420,6 +420,7 @@ static int set_color_mode(struct omapfb_
 		plane->color_mode = OMAPFB_COLOR_CLUT_8BPP;
 		return 0;
 	case 12:
+		var->bits_per_pixel = 16;
 		plane->color_mode = OMAPFB_COLOR_RGB444;
 		return 0;
 	case 16:
-----

J.

-- 
Revd. Jonathan McDowell, ULC | Every bug you find is the last one.
