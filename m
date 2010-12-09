From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH 0/2] staging: tidspbridge: various cleanups
Date: Thu,  9 Dec 2010 23:47:36 +0200
Message-ID: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:49863 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426Ab0LIVrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 16:47:53 -0500
Received: by ewy10 with SMTP id 10so2162167ewy.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 13:47:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

This series is a reduced set of the previous one, containing only two
patches that were changed based on Omar's review:

http://marc.info/?l=linux-omap&m=129162731925095

Also rebased to the latest dspbridge branch from the
omapzoom.org git tree.

Ionut Nicu (2):
  staging: tidspbridge: rmgr/node.c code cleanup
  staging: tidspbridge: rmgr code cleanup

 drivers/staging/tidspbridge/rmgr/drv.c  |  171 ++++-----
 drivers/staging/tidspbridge/rmgr/node.c |  682 +++++++++++++++----------------
 drivers/staging/tidspbridge/rmgr/rmm.c  |  266 ++++++-------
 3 files changed, 509 insertions(+), 610 deletions(-)

-- 
1.7.3.2

