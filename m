From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 0/2] SDTI fixes
Date: Fri,  9 Jan 2009 09:52:31 +0200
Message-ID: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28081 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbZAIHws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 02:52:48 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n097px5K022829
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 09:52:29 +0200
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n097pfA7025740
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 09:51:41 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

These patches fixes the problem with sdti-console, where it stops to
work after PM is initialized.

arch/arm/mach-omap2/clockdomains.h |    6 +++-
arch/arm/mach-omap2/pm34xx.c       |   12 +++++++--
drivers/misc/sti/sdti.c            |   48 ++++++++++++++++++++++++++++---------
3 files changed, 52 insertions(+), 14 deletions(-)
