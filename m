From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/1] OMAP3: I2C: Enable I2C wakeups
Date: Tue, 18 Nov 2008 17:43:13 +0200
Message-ID: <1227022994-8288-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33047 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbYKRPlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 10:41:18 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

The following patch configures the I2C_WE registers for omap3xxx devices.
Leaving the I2C_WE registers unconfigured causes I2C operations to freeze
for long periods if CPU idle is enabled (device enters WFI).

The patch depends on following patches:

ext Paul Walmsley (2):
      OMAP: I2C: convert 'rev1' flag to generic 'rev' u8
      OMAP2/3 I2C: reprogram OCP_SYSCONFIG register after reset



