From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] Compile Errors and Warnings
Date: Thu, 13 Jan 2011 13:41:04 +0200
Message-ID: <1294918868-16263-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41759 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932891Ab1AMLlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:41:14 -0500
Received: by mail-yi0-f53.google.com with SMTP id 17so924461yib.40
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:41:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix a few compile error and warnings found
when building OMAP4-only kernel.

Felipe Balbi (4):
  arm: omap: clock: fix compile warning
  arm: omap: io: fix compile warning
  arm: omap: prm: fix compile error
  arm: omap: clockdomain: fix compile error

 arch/arm/mach-omap2/clock2xxx.h    |    4 ++--
 arch/arm/mach-omap2/clockdomain.h  |    3 ++-
 arch/arm/mach-omap2/io.c           |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   21 +++++++++++++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

-- 
1.7.3.4.598.g85356

