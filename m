From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv3 0/6] Idle status patches revisited again
Date: Fri, 15 Jan 2010 14:46:51 +0200
Message-ID: <1263559617-663-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24326 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab0AOKzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:55:31 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

From: Tero Kristo <tero.kristo@nokia.com>

Improvements / fixes compared to previous version:

- Added pwrdm next_state cache initialization to patch 1
- Fixed changelog for patch 1
- Added FCLK checks to patch 5 (now checks both idlest and fclk)
- Added more info to changelog for patch 5

-Tero


