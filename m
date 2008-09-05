From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 0/2] OMAP2xxx EAC build fix and sparse cleanup
Date: Fri, 05 Sep 2008 01:37:14 -0600
Message-ID: <20080905073522.7741.76584.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYIEISb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 04:18:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, jarkko.nikula@nokia.com

This series fixes a build bug in the EAC driver after the recent IO address
changes, and resolves some sparse warnings.  Updated to use ioremap(). 
Thanks to Jarkko Nikula <jarkko.nikula@nokia.com> for testing and Russell
King <linux@arm.linux.org.uk> for review.

Compile-tested only.

- Paul

---


 arch/arm/mach-omap2/devices.c |    4 ++--
 sound/arm/omap/eac.c          |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

