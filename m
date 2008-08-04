From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [UPDATE][PATCH 00/07][GIT 3/4+] Dspbridge cleanup patches
Date: Mon, 4 Aug 2008 12:21:32 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53081F16D9@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:53155 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759752AbYHDRVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 13:21:39 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74HLXqc024583
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 12:21:38 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m74HLWIv020001
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 12:21:33 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

The following set of patches, are used to fix some of the warnings and errors reported from various code check tools, like checkpatch and sparse.

They also remove some code that is now obsolete and try to make bridge code more understandable and clean, these patches are placed under:

http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=115

The patch order is:
BRD001-ARM-OMAP-checkpatch-cleanup.patch
BRD002-ARM-OMAP-compilation-fixes.patch
BRD003-ARM-OMAP-remove-unused-headers.patch
BRD004-ARM-OMAP-remove-unused-code.patch
BRD005-ARM-OMAP-remove-dynload-flags.patch
BRD006-ARM-OMAP-remove-commented-out-code.patch
BRD007-ARM-OMAP-renamingC55Procs.patch

Many thanks for your time.

Best Regards,

omar
