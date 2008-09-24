From: <Tero.Kristo@nokia.com>
Subject: clk_disable_unused() is bugged
Date: Wed, 24 Sep 2008 13:19:41 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE39430890B53@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52119 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYIXKU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 06:20:27 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Hi,

clk_disable_unused (in plat-omap/clock.c) is bugged in latest kernel. It
checks whether ck->enable_reg is zero, and in most cases this happens to
be so (CM_FCLKEN = 0.) Seems to be caused by some late change to
clocktree where enable_reg fields are defined as module offsets, not
register addresses. This bug causes several clocks to remain enabled
after boot, and at least on OMAP3 it prevents retention.

Paul, you got a fix coming for this?

-Tero

