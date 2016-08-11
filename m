From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] tools: iio: fix iio build error by adding KBUILD_OUTPUT support to makefile
Date: Thu, 11 Aug 2016 11:31:24 +0530
Message-ID: <20160811060124.6604-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Current make doesn't have support to pass kernel built directory
to find events.h kernel header file, so adding support for
KBUILD_OUTPUT support to Makefile.

$ make CROSS_COMPILE=arm-linux-gnueabihf- -C tools/iio
make: Entering directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_event_monitor.o iio_event_monitor.c
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_utils.o iio_utils.c
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o lsiio.o lsiio.c
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_generic_buffer.o iio_generic_buffer.c
arm-linux-gnueabihf-gcc   lsiio.o iio_utils.o   -o lsiio
arm-linux-gnueabihf-gcc   iio_generic_buffer.o iio_utils.o   -o iio_generic_buffer
iio_event_monitor.c:28:30: fatal error: linux/iio/events.h: No such file or directory
 #include <linux/iio/events.h>
                               ^
compilation terminated.
<builtin>: recipe for target 'iio_event_monitor.o' failed
make: *** [iio_event_monitor.o] Error 1
make: Leaving directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---

With this fix I am able to build the iio tools

$ make CROSS_COMPILE=arm-linux-gnueabihf- -C tools/iio KBUILD_OUTPUT=`pwd`
make: Entering directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o iio_event_monitor.o iio_event_monitor.c
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o iio_utils.o iio_utils.c
arm-linux-gnueabihf-gcc   iio_event_monitor.o iio_utils.o   -o iio_event_monitor
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o lsiio.o lsiio.c
arm-linux-gnueabihf-gcc   lsiio.o iio_utils.o   -o lsiio
arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o iio_generic_buffer.o iio_generic_buffer.c
arm-linux-gnueabihf-gcc   iio_generic_buffer.o iio_utils.o   -o iio_generic_buffer
make: Leaving directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'

---
 tools/iio/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 5446d62..0ec3ea0 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,5 +1,6 @@
 CC = $(CROSS_COMPILE)gcc
-CFLAGS += -Wall -g -D_GNU_SOURCE
+KBUILD_OUTPUT ?= /lib/modules/$(shell uname -r)/build
+CFLAGS += -Wall -g -D_GNU_SOURCE -I$(KBUILD_OUTPUT)/usr/include
 
 BINDIR=usr/bin
 INSTALL_PROGRAM=install -m 755 -p
-- 
2.9.2.664.ga0a1831
