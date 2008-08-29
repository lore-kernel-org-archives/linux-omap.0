From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 0/3][OMAP 3/4] dspbridge latest patches
Date: Thu, 28 Aug 2008 20:23:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A534486D6A1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44115 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbYH2BYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 21:24:03 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7T1NuJi000553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 20:24:01 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7T1Nuvk026443
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 20:23:56 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Submitting the following patches, please apply them at the top of the reworked patches, (they're already placed in the latest tarball from omapzoom.org). I put them also here for whoever wants to comment on them.

Patch order:
0027-BRIDGE-use-likely-unlikely-for-status-checking.patch (Hiroshi.DOYU)
0028-BRIDGE-add-table-end-wcd.patch (Omar Ramirez)
0029-BRIDGE-wcd-sparse-user-space-warnings.patch (Fernando Guzman)

- omar
