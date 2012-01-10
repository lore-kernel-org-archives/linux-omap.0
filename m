From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] MAINTAINERS: List i2c-omap and i2c-davinci drivers
Date: Tue, 10 Jan 2012 15:36:40 +0100
Message-ID: <20120110153640.0d30a643@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This will ensure that the right people and lists are notified when
these drivers are modified.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
If there are no objections, I'll send this to Linus quickly.

 MAINTAINERS |    3 +++
 1 file changed, 3 insertions(+)

--- linux-3.3-rc0.orig/MAINTAINERS	2012-01-10 15:24:37.000000000 +0100
+++ linux-3.3-rc0/MAINTAINERS	2012-01-10 15:27:28.000000000 +0100
@@ -4673,6 +4673,8 @@ Q:	http://patchwork.kernel.org/project/l
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 S:	Maintained
 F:	arch/arm/*omap*/
+F:	drivers/i2c/busses/i2c-omap.c
+F:	include/linux/i2c-omap.h
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
@@ -5945,6 +5947,7 @@ L:	davinci-linux-open-source-VycZQUHpC/O5NxqcuzA5kA@public.gmane.org
 Q:	http://patchwork.kernel.org/project/linux-davinci/list/
 S:	Supported
 F:	arch/arm/mach-davinci
+F:	drivers/i2c/busses/i2c-davinci.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu-W8zweXLXuWQS+FvcfC7Uqw@public.gmane.org>


-- 
Jean Delvare
