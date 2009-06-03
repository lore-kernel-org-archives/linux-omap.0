From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [ANNOUNCE] TI dspbridge Omapzoom tree
Date: Wed, 3 Jun 2009 17:18:28 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040F3FC45F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49131 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbZFCWSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 18:18:33 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n53MIUnF029979
	for <linux-omap@vger.kernel.org>; Wed, 3 Jun 2009 17:18:35 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n53MIUZA013149
	for <linux-omap@vger.kernel.org>; Wed, 3 Jun 2009 17:18:30 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n53MIUsO018895
	for <linux-omap@vger.kernel.org>; Wed, 3 Jun 2009 17:18:30 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi,

The new dspbridge omapzoom tree has been set in place, you can clone it from:

    git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge.git
or
    http://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge.git

In this tree you will find the latest set of TI DSP BRIDGE patches, which are
based on linux-omap kernel tree. The branch layout is as follows:

  master                tracking L-O master
  bridge-pm-2.6.28      branched from omap-2.6.28, pulled linux-omap-pm
                        pm-2.6.28 on top, + bridge patches
  bridge-pm-2.6.29      branched from L-O pm branch + bridge patches

Special thanks to Hiroshi Doyu and Ameya Palande, and to all who have
contributed with comments and patches.

For the new dspbridge tree, I took the logical set of patches which was ported
long time back[1] along with the new stuff, reworked what we had to migrate to
this baseline and already sent the patches to the list, those patches can be
found in the new tree.

Best Regards,

Omar

---
[1] http://marc.info/?l=linux-omap&m=121878286205991&w=2

