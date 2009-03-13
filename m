From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] Group and resource assignments for TWL4030
Date: Fri, 13 Mar 2009 17:33:10 +0200
Message-ID: <1236958391-17197-1-git-send-email-peter.de-schrijver@nokia.com>
References: <20090306001625.GF6784@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44481 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758436AbZCMPdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 11:33:20 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2DFWtCQ014547
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 17:33:15 +0200
In-Reply-To: <20090306001625.GF6784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch introduces support for board specific group assignments of TWL4030
resources. The resource type and type2 fields can also be specified.

Peter 'p2' De Schrijver (1):
  Group and resource assignments for TWL4030

 drivers/mfd/twl4030-power.c |   96 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/twl4030.h |   41 ++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

