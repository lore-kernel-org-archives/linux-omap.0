From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH] dwc3: linux/module.h included twice
Date: Wed, 15 Feb 2012 18:55:51 +0100
Message-ID: <1329328551-4957-1-git-send-email-danny.kukawka@bisect.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Danny Kukawka <dkukawka@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


drivers/usb/dwc3/core.c and drivers/usb/dwc3/dwc3-omap.c
included 'linux/module.h' twice, remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/usb/dwc3/core.c      |    1 -
 drivers/usb/dwc3/dwc3-omap.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7c9df63..eed4a5b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -51,7 +51,6 @@
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/module.h>
 
 #include "core.h"
 #include "gadget.h"
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 3274ac8..92cc7b8 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -46,7 +46,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/module.h>
 
 #include "core.h"
 #include "io.h"
-- 
1.7.8.3
