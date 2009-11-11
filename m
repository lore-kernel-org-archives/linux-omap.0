From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/3] omap3: cm-t35 updates
Date: Wed, 11 Nov 2009 13:19:29 +0200
Message-ID: <cover.1257937910.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54097 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862AbZKKLZy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 06:25:54 -0500
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N8BKq-00070g-1t
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 05:26:00 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 105559A035A
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 13:19:34 +0200 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Here are several small updates for CM-T35 board.

Changes since commit e7e7a613eded2732b68496f69ff8fc34f16e1dd0:
  Tony Lindgren (1):
          Linux-omap rebuilt: Processor support for new omaps merged

Mike Rapoport (3):
  omap3: cm-t35: update led polarity
  omap3: cm-t35: use matrix_keyboard
  omap3: cm-t35: add support for baseboard ehternet

 arch/arm/mach-omap2/board-cm-t35.c |   71 ++++++++++++++++++++++++++----------
 1 files changed, 51 insertions(+), 20 deletions(-)

