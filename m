From: Girish S G <girishsg@ti.com>
Subject: [PATCH 0/2] OMAP4: PM: Regulator state update
Date: Tue, 21 Jun 2011 19:24:36 -0500
Message-ID: <1308702276-12539-1-git-send-email-girishsg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39981 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939Ab1FUX3o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 19:29:44 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5LNThvf002092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:44 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5LNTh7g010563
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:43 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5LNTh5A003047
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:43 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Girish S G <girishsg@ti.com>

 - There are few regulators (LDO's) which needs to be kept always ON in the
system and few others can be handled by driver as per need basis. This series
summarizes all the LDO's state and updates the default behavior.

 - As of today un-used regulators are not getting turned OFF. Need to specify
explicitly that system has regulator constraints so that regulator core can
disable unused resources after late init call (The one's which are not getting
handled by any drivers).

Changes done for 4430sdp and omap4panda.

Girish S G (2):
  OMAP4:TWL6030: Regulator set the default behavior of LDO's
  OMAP: Regulator: Specify system has fully specified constraints

 arch/arm/mach-omap2/board-4430sdp.c    |    7 +++++++
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

