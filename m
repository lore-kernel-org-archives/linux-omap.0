From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 0/6] Idle status patches revisited
Date: Thu, 12 Nov 2009 19:02:33 +0200
Message-ID: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43784 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbZKLRTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 12:19:53 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

From: Tero Kristo <tero.kristo@nokia.com>

Following set implements checks for idle states of powerdomains, and
changes target cpuidle state according to those. This also includes as
a cleanup removal of some hacks from omap_sram_idle(), and also introduces
INACTIVE / ON state support for powerdomains which simplifies the code.

Applies on top of PM branch.


