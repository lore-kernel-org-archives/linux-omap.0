From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex driver (rev. 4)
Date: Tue, 17 Jun 2008 10:22:46 +0300
Message-ID: <1213687366.14881.12.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32131 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYFQHVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:21:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: tony Lindgren <tony@atomide.com>, "ext-kalle.jokiniemi" <ext-kalle.jokiniemi@nokia.com>

Here is the latest patch set for SmartReflex driver.

Whats new:

- Dropped the reference patch, so now only 2 patches in the set (regdefs
and integration).

- Created custom clocks with special enable/disable calls. This enables
using the standard clk_enable/disable calls for smartreflex.

- Corrected some styling errors

- Changed omap_{read, write}l calls to __raw_{read, write}l calls.

- Removed custom debug messages, some changed to standard printks.

--
Kalle
