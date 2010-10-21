From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] omap: am3517: fix build break
Date: Thu, 21 Oct 2010 14:50:06 +0530
Message-ID: <1287652806-1067-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Patch usb-am35x-add-musb-support.patch in greg's USB queue
adds backan include of <plat/control.h>. This file was renamed
by another commit in the omap tree and the file was already
fixed to reflect this.

Remove this include to fix up a build break.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
---
Build break observed with linux-next as of 20101021.

Greg, okay with me to fold this into the original patch
if the others in copy agree. It's a trivial enough change.

The patch that renamed plat/control.h is this one:
http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=4814ced5116e3b73dc4f63eec84999739fc8ed11

 arch/arm/mach-omap2/board-am3517evm.c |    1 -
 1 file changed, 1 deletion(-)

Index: mainline/arch/arm/mach-omap2/board-am3517evm.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-am3517evm.c
+++ mainline/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,7 +35,6 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/display.h>
-#include <plat/control.h>
 
 #include "mux.h"
 #include "control.h"
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
