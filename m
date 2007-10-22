From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP FB drivers muck up the FB menu?
Date: Mon, 22 Oct 2007 20:40:22 +0200
Message-ID: <471CEE96.3070808@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020705050504070707040100"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705050504070707040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Please see below answer from Randy. Seems that it didn't find its way 
to the list because Randy isn't subscribed.

Randy: Thanks for explanation, investigation and patch!

Dirk

-------- Original Message --------
Subject: Re: OMAP FB drivers muck up the FB menu?
Date: Sun, 21 Oct 2007 21:55:06 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Organization: YPO4
To: dirk.behme@googlemail.com
CC: linux-omap-open-source@linux.omap.com

[I'm having problems sending email thru oracle.com, so I'm replying
from my personal account instead...]

Dirk Behme wrote:
> 
> In
> 
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.23-git15.log 
> 
> 
> I just found this:
> 
> -- cut --
> commit 0058f479e52d0c0718c843cb34223bc1bfce36e1
> Author: Randy Dunlap <randy.dunlap@oracle.com>
> Date:   Tue Oct 16 01:29:35 2007 -0700
> 
>     video gfx: fix menu ordering
> 
>     Move video graphics driver configs to fix menus:
> 
>     ...
>     The OMAP FB drivers still muck up the FB menu a bit, so I put
>       OMAP drivers at the end of the FB menu.
> 
>     ...
> -- cut --
> 
> Anybody with an idea what is meant there?

All of the frame buffer drivers should be listed (indented) under the menu
heading "Support for frame buffer devices".  If I TI_OMAP board type and
then view the Graphics Support menu, it looks like this:

   x x    [ ] Backlight & LCD device support  ---> 
           x x
   x x        Display device support  ---> 
           x x
   x x    <M> Lowlevel video output switch controls 
           x x
   x x    <*> Support for frame buffer devices 
           x x
   x x    [ ]   Enable firmware EDID (NEW) 
           x x
   x x    [ ]   Enable Video Mode Handling Helpers (NEW) 
           x x
   x x    [ ]   Enable Tile Blitting Support (NEW) 
           x x
   x x    ---   Frame buffer hardware drivers 
           x x
   x x    < >   Epson S1D13XXX framebuffer support (NEW) 
           x x
   x x    < > OMAP frame buffer support (EXPERIMENTAL) (NEW) 
           x x
   x x    < > Virtual Frame Buffer support (ONLY FOR TESTING!) (NEW) 
           x x
   x x        Console display driver support  ---> 
           x x
   x x    [ ] Bootup logo (NEW)  --->

This is usually caused by some missing config symbol(s) on the 
"depends on"
line, but I was not able to determine the exact cause of it in this case.

Notice how OMAP is not indented like the fb drivers above it.
Neither is the Virtual FB, but that's expected once a config symbol
above causes a problem.

In this menu, there were also problems with PMAGB_B and with
IBM_GXT4500.  After those were fixed, all FB drivers except for OMAP
are indented as expected.  If anyone has ideas or suggestions for how
to make the OMAP FB entry better, please send it.

[/me does more investigation and testing ...]

OK, I know what's happening.  In drivers/video/Kconfig, these lines:

if ARCH_OMAP
	source "drivers/video/omap/Kconfig"
endif

introduce a dependency on ARCH_OMAP for all config symbols in the
drivers/video/omap/Kconfig file.  NOTE:  The construct above does NOT
prevent kconfig from reading that file for all non-ARCH_OMAP architectures
or platforms.  It justs add a dependency.  In this case that added
dependency mucks up the FB menu (in not-so-technical terms).

This is easy enough to fix.  Patch is attached.  I'll submit it to the
linux-fbdev-devel@lists.sourceforge.net list now.

[Comment from Dirk: Attachment renamed to .txt to get it properly 
through my mailer and into list archive]

> In same changelog there is from Randy as well:
> 
> -- cut --
> commit e82ce352335b643755a7fa4130b11d6d7adcf10c
> Author: Randy Dunlap <randy.dunlap@oracle.com>
> Date:   Tue Oct 16 23:29:44 2007 -0700
> 
>     maintainers: linux-omap list is subscribers only
> 
>     You are not allowed to post to this mailing list, and your message 
> has been
>     automatically rejected.  If you think that your messages are being 
> rejected
>     in error, contact the mailing list owner at
>     linux-omap-open-source-owner@linux.omap.com.
> 
>     Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>     Cc: Tony Lindgren <tony@atomide.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> -- cut --
> 
> Randy: Did you like to contact linux-omap list regarding OMAP FB issue 
> and got a reject?

Yes, as quoted above.

Thanks,
---
~Randy


--------------020705050504070707040100
Content-Type: text/plain;
 name="fb-omap-depends.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fb-omap-depends.txt"

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix FB_OMAP dependencies so that the OMAP FB driver options are
presented correctly.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/Kconfig      |    4 +---
 drivers/video/omap/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.23-git13.orig/drivers/video/Kconfig
+++ linux-2.6.23-git13/drivers/video/Kconfig
@@ -1892,9 +1892,7 @@ config FB_VIRTUAL
 
 	  If unsure, say N.
 
-if ARCH_OMAP
-	source "drivers/video/omap/Kconfig"
-endif
+source "drivers/video/omap/Kconfig"
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
--- linux-2.6.23-git13.orig/drivers/video/omap/Kconfig
+++ linux-2.6.23-git13/drivers/video/omap/Kconfig
@@ -1,6 +1,6 @@
 config FB_OMAP
 	tristate "OMAP frame buffer support (EXPERIMENTAL)"
-	depends on FB
+	depends on FB && ARCH_OMAP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

--------------020705050504070707040100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020705050504070707040100--
