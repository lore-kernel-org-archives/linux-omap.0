From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [RFC PATCHv4 6/7] HSI: Add HSI API documentation
Date: Tue, 14 Dec 2010 12:09:42 +0200
Message-ID: <1292321383-30200-7-git-send-email-carlos.chinea@nokia.com>
References: <1292321383-30200-1-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292321383-30200-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add an entry for HSI in the device-drivers section of
the kernel documentation.

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 Documentation/DocBook/device-drivers.tmpl |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/DocBook/device-drivers.tmpl b/Documentation/DocBook/device-drivers.tmpl
index 22edcbb..877028a 100644
--- a/Documentation/DocBook/device-drivers.tmpl
+++ b/Documentation/DocBook/device-drivers.tmpl
@@ -433,4 +433,21 @@ X!Idrivers/video/console/fonts.c
 !Edrivers/i2c/i2c-core.c
   </chapter>
 
+  <chapter id="hsi">
+     <title>High Speed Synchronous Serial Interface (HSI)</title>
+
+     <para>
+	High Speed Synchronous Serial Interface (HSI) is a
+	serial interface mainly used for connecting application
+	engines (APE) with cellular modem engines (CMT) in cellular
+	handsets.
+
+	HSI provides multiplexing for up to 16 logical channels,
+	low-latency and full duplex communication.
+     </para>
+
+!Iinclude/linux/hsi/hsi.h
+!Edrivers/hsi/hsi.c
+  </chapter>
+
 </book>
-- 
1.7.1
