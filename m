From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 00/07][GIT 3/4+] Bridge cleanup patches
Date: Mon, 4 Aug 2008 11:01:38 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530804B562@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43348 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034AbYHDQBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 12:01:46 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74G1ea3017669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 11:01:45 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m74G1dgq011521
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 11:01:40 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


I removed the attached patches as this mail got rejected by size limit.

Also patches 1 and 6 got rejected:
BRD001-ARM-OMAP-checkpatch-cleanup.patch (183 KB)
BRD006-ARM-OMAP-remove-commented-out-code.patch (197 KB)

These patches are just for cleanup but your feedback would be of great help, so I'll be splitting these to fit the size limit, hope this is ok.

Regards,

omar

-----Original Message-----
From: Ramirez Luna, Omar
Sent: Monday, August 04, 2008 9:54 AM
To: 'linux-omap@vger.kernel.org'
Subject: [PATCH 00/07][GIT 3/4+] Bridge cleanup patches

Hi,

The following set of patches, are used to fix some of the warnings and errors reported from various code check tools, like checkpatch and sparse.

They also remove some code that is now obsolete and try to make bridge code more understandable and clean.

The patch order is:
BRD001-ARM-OMAP-checkpatch-cleanup.patch
BRD002-ARM-OMAP-compilation-fixes.patch
BRD003-ARM-OMAP-remove-unused-headers.patch
BRD004-ARM-OMAP-remove-unused-code.patch
BRD005-ARM-OMAP-remove-dynload-flags.patch
BRD006-ARM-OMAP-remove-commented-out-code.patch
BRD007-ARM-OMAP-renamingC55Procs.patch

Regards,

omar
