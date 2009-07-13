From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCHv2 1/4] DSPBRIDGE: Fix macros that break when inside an
 if/else
Date: Mon, 13 Jul 2009 15:42:12 +0300
Message-ID: <4A5B2BA4.1090506@nokia.com>
References: <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com> <1247488726-14960-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46483 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbZGMMm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jul 2009 08:42:27 -0400
In-Reply-To: <1247488726-14960-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "x0095840@ti.com" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>

I still get following warnings from checkpatch.pl:

WARNING: suspect code indent for conditional statements (0, 2)
#45: FILE: drivers/dsp/bridge/pmgr/wcd.c:151:
+do {						\
+  if (DSP_SUCCEEDED(status)) {			\

WARNING: suspect code indent for conditional statements (2, 4)
#46: FILE: drivers/dsp/bridge/pmgr/wcd.c:152:
+  if (DSP_SUCCEEDED(status)) {			\
+    if (unlikely((src) == NULL) ||		\

ERROR: code indent should use tabs where possible
#49: FILE: drivers/dsp/bridge/pmgr/wcd.c:155:
+        GT_1trace(WCD_debugMask, GT_7CLASS,^I\$

WARNING: suspect code indent for conditional statements (0, 2)
#57: FILE: drivers/dsp/bridge/pmgr/wcd.c:163:
+do {						\
+  if (DSP_SUCCEEDED(status)) {			\

WARNING: suspect code indent for conditional statements (2, 4)
#58: FILE: drivers/dsp/bridge/pmgr/wcd.c:164:
+  if (DSP_SUCCEEDED(status)) {			\
+    if (unlikely((dest) == NULL) ||		\

ERROR: code indent should use tabs where possible
#61: FILE: drivers/dsp/bridge/pmgr/wcd.c:167:
+        GT_1trace(WCD_debugMask, GT_7CLASS,^I\$

ERROR: code indent should use tabs where possible
#62: FILE: drivers/dsp/bridge/pmgr/wcd.c:168:
+          "copy_to_user failed, dest=0x%x\n", dest);^I\$

ERROR: code indent should use tabs where possible
#63: FILE: drivers/dsp/bridge/pmgr/wcd.c:169:
+        (status) = DSP_EPOINTER ;^I^I\$

total: 4 errors, 4 warnings, 48 lines checked

I have used 2 spaces instead of a tab for indentation so that line
won't exceed 80 columns limit, and we still maintain good amount of
readability with this macro.

Cheers,
Ameya.
