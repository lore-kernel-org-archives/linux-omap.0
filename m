From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] Group and resource assignments for TWL4030
Date: Tue, 10 Feb 2009 15:11:34 +0200
Message-ID: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19724 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZBJNLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 08:11:52 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1ADBTiM017418
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 15:11:49 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch introduces support for board specific group assignments of TWL4030
resources. The resource type and type2 fields can also be specified.

Peter 'p2' De Schrijver (1):
  Group and resource assignments for TWL4030

 drivers/mfd/twl4030-power.c |   95 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/twl4030.h |   41 ++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)

