From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [omapzoom] Dspbridge binaries
Date: Fri, 22 Aug 2008 20:51:42 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53445FC113@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42687 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYHWBvu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 21:51:50 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7N1piCn014790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 22 Aug 2008 20:51:49 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7N1pivN025349
	for <linux-omap@vger.kernel.org>; Fri, 22 Aug 2008 20:51:44 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

You can find dspbridge binaries uploaded into omapzoom site:

http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=132

Base images (.dof64P) are statically linked DSP executables loaded on the DSP when system boots up, dynamic libraries (.dll64P) are DSP object files that can be loaded into virtually any address on the DSPloading examples. For more information please refer to the Readme file (in the previous link) or db_linux_rguide.pdf found at:

http://omapzoom.org/gf/project/omapbridge/docman/?subdir=3

- omar
