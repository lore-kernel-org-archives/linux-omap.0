From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [RESUBMIT][PATCH 0/8][GIT 3/4+] Bridge cleanup patches
Date: Wed, 6 Aug 2008 11:20:29 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53081F1BB8@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:49608 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292AbYHFQUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 12:20:37 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76GKV1G032145
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:20:36 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m76GKUxt027917
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:20:30 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id m76GKUkR012099
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:20:30 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

These are the latest set of patches that contain changes to dspbridge code. They are used to fix some of the warnings and errors reported from various code check tools, like checkpatch and sparse.

They also remove some code that is now obsolete and try to make bridge code more understandable and clean.

The patch order is:
BRD001-ARM-OMAP-checkpatch-cleanup.patch
BRD002-ARM-OMAP-compilation-fixes.patch
BRD003-ARM-OMAP-remove-unused-headers.patch
BRD004-ARM-OMAP-remove-unused-code.patch
BRD005-ARM-OMAP-remove-dynload-flags.patch
BRD006-ARM-OMAP-remove-commented-out-code.patch
BRD007-ARM-OMAP-remove_CFG_GetDSPProcs.patch
BRD008-ARM-OMAP-add-debug-option.patch (on behalf of Felipe Contreras)

You can find them at:

http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseBrowse&frs_package_id=16

- omar
