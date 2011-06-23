From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/3] OMAP4: PRCM fixes
Date: Thu, 23 Jun 2011 18:45:41 +0200
Message-ID: <1308847544-2322-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57097 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759069Ab1FWQqH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 12:46:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul & Rajendra,

Here are a couple of fixes on PRCM header files and powerdomain data.

The series is based on v3.0-rc4 and tested on OMAP4430 ES2.1 + SDP.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.0.1/1_prcm_files_fixes

Regards,
Benoit


Benoit Cousson (3):
  OMAP4: pcrm: Fix errors in few defines name
  OMAP4: prm: Remove wrong clockdomain offsets
  OMAP4: powerdomain data: Fix core mem states and missing cefuse flag

 arch/arm/mach-omap2/cm1_44xx.h              |   28 +++++++++++-----------
 arch/arm/mach-omap2/cm2_44xx.h              |   23 ++++++++---------
 arch/arm/mach-omap2/powerdomains44xx_data.c |   25 ++++++++++---------
 arch/arm/mach-omap2/prm44xx.h               |   34 ++++++++------------------
 4 files changed, 49 insertions(+), 61 deletions(-)

