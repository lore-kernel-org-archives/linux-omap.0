From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 10/10] TI DSP BRIDGE: README
Date: Fri, 15 Aug 2008 09:47:04 +0300
Message-ID: <1218782824-12596-11-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-5-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-6-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-7-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-8-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-9-git-send-email-Hiroshi.DOYU@nokia.com>
 <1218782824-12596-10-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39028 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYHOGr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 02:47:26 -0400
In-Reply-To: <1218782824-12596-10-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, x00omar@ti.com, x0023949@ti.com, soni.trilok@gmail.com, felipe.contreras@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Initial port from omapzoom
	http://omapzoom.org/gf/project/omapbridge

For details,
http://omapzoom.org/gf/project/omapbridge/docman/?subdir=3

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 Documentation/tidspbridge/README |   70 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/tidspbridge/README

diff --git a/Documentation/tidspbridge/README b/Documentation/tidspbridge/README
new file mode 100644
index 0000000..df6d371
--- /dev/null
+++ b/Documentation/tidspbridge/README
@@ -0,0 +1,70 @@
+                        Linux DSP/BIOS Bridge release
+
+DSP/BIOS Bridge overview
+========================
+
+DSP/BIOS Bridge is designed for platforms that contain a GPP and one or more
+attached DSPs.  The GPP is considered the master or "host" processor, and the
+attached DSPs are processing resources that can be utilized by applications
+and drivers running on the GPP.
+
+The abstraction that DSP/BIOS Bridge supplies, is a direct link between a GPP
+program and a DSP task.  This communication link is partitioned into two
+types of sub-links:  messaging (short, fixed-length packets) and data
+streaming (multiple, large buffers).  Each sub-link operates independently,
+and features in-order delivery of data, meaning that messages are delivered
+in the order they were submitted to the message link, and stream buffers are
+delivered in the order they were submitted to the stream link.
+
+In addition, a GPP client can specify what inputs and outputs a DSP task
+uses. DSP tasks typically use message objects for passing control and status
+information and stream objects for efficient streaming of real-time data.
+
+GPP Software Architecture
+=========================
+
+A GPP application communicates with its associated DSP task running on the
+DSP subsystem using the DSP/BIOS Bridge API. For example, a GPP audio
+application can use the API to pass messages to a DSP task that is managing
+data flowing from analog-to-digital converters (ADCs) to digital-to-analog
+converters (DACs).
+
+From the perspective of the GPP OS, the DSP is treated as just another
+peripheral device.   Most high level GPP OS typically support a device driver
+model, whereby applications can safely access and share a hardware peripheral
+through standard driver interfaces.  Therefore, to allow multiple GPP
+applications to share access to the DSP, the GPP side of DSP/BIOS Bridge
+implements a device driver for the DSP.
+
+Since driver interfaces are not always standard across GPP OS, and to provide
+some level of interoperability of application code using DSP/BIOS Bridge
+between GPP OS, DSP/BIOS Bridge provides a standard library of APIs which
+wrap calls into the device driver.   So, rather than calling GPP OS specific
+driver interfaces, applications (and even other device drivers) can use the
+standard API library directly.
+
+DSP Software Architecture
+=========================
+
+For DSP/BIOS, DSP/BIOS Bridge adds a device-independent streaming I/O (STRM)
+interface, a messaging interface (NODE), and a Resource Manager (RM) Server.
+The RM Server runs as a task of DSP/BIOS and is subservient to commands
+and queries from the GPP.  It executes commands to start and stop DSP signal
+processing nodes in response to GPP programs making requests through the
+(GPP-side) API.
+
+DSP tasks started by the RM Server are similar to any other DSP task with two
+important differences:  they must follow a specific task model consisting of
+three C-callable functions (node create, execute, and delete), with specific
+sets of arguments, and they have a pre-defined task environment established
+by the RM Server.
+
+Tasks started by the RM Server communicate using the STRM and NODE interfaces
+and act as servers for their corresponding GPP clients, performing signal
+processing functions as requested by messages sent by their GPP client.
+Typically, a DSP task moves data from source devices to sink devices using
+device independent I/O streams, performing application-specific processing
+and transformations on the data while it is moved.  For example, an audio
+task might perform audio decompression (ADPCM, MPEG, CELP) on data received
+from a GPP audio driver and then send the decompressed linear samples to a
+digital-to-analog converter.
-- 
1.5.5.1.357.g1af8b

