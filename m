From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/2] OMAP2xxx EAC build fix and sparse cleanup
Date: Thu, 04 Sep 2008 23:50:48 -0600
Message-ID: <20080905054959.5272.63450.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33925 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbYIEF6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:58:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series fixes a build bug in the EAC driver after the recent IO address
changes, and resolves some sparse warnings.  Updated to use ioremap().

Compile-tested only.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---

 arch/arm/mach-omap2/devices.c |    4 ++--
 sound/arm/omap/eac.c          |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

