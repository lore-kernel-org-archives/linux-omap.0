From: David Brownell <david-b@pacbell.net>
Subject: omap_bl build breakage
Date: Mon, 20 Aug 2007 00:27:16 -0700
Message-ID: <200708200027.16789.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

In case anyone wants to fixit...

  CC [M]  drivers/video/backlight/omap_bl.o
drivers/video/backlight/omap_bl.c: In function 'omapbl_suspend':
drivers/video/backlight/omap_bl.c:79: error: 'struct backlight_device' has no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_resume':
drivers/video/backlight/omap_bl.c:88: error: 'struct backlight_device' has no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_set_power':
drivers/video/backlight/omap_bl.c:100: error: 'struct backlight_device' has no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_update_status':
drivers/video/backlight/omap_bl.c:110: error: 'struct backlight_device' has no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_get_intensity':
drivers/video/backlight/omap_bl.c:130: error: 'struct backlight_device' has no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_remove':
drivers/video/backlight/omap_bl.c:185: error: 'struct backlight_device' has no member named 'class_dev'
