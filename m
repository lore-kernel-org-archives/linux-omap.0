From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP2xxx EAC build fix and sparse cleanup
Date: Thu, 04 Sep 2008 23:24:19 -0600
Message-ID: <20080905052312.28183.55601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38200 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYIEF07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:26:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series fixes a build bug in the EAC driver after the recent IO address
changes, and resolves some sparse warnings.

Compile-tested only.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---

 sound/arm/omap/eac.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

