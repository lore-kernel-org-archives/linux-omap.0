From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 0/3] sti driver patches
Date: Thu, 11 Jun 2009 11:46:56 +0300
Message-ID: <1244710019-14564-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27916 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbZFKIuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 04:50:08 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n5B8o4hi024326
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 03:50:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

While trying to get sti in shape for mainlnie I came to
the idea of making it a bus driver so sti-console and
sti-netlink could register to it.

How do you guys feel about the idea ?

The following 3 patches are not for merging yet, there's
still lots of work to do but you can take a nitpick of
how would that look.

Felipe Balbi (3):
  sti: cleanup to merge
  sti: make it a bus driver
  sti: netlink: convert to register to new bus

 arch/arm/plat-omap/include/mach/sti.h |   96 ++++++---
 drivers/misc/sti/sdti.c               |  372 +++++++++++++++++++++++++++-----
 drivers/misc/sti/sti-netlink.c        |   70 ++++++-
 3 files changed, 437 insertions(+), 101 deletions(-)

