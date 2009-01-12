From: Peter Barada <peterb@logicpd.com>
Subject: Missing USB OTG ID interrupt../
Date: Mon, 12 Jan 2009 14:39:05 -0500
Message-ID: <1231789145.14918.31.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:43226 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755015AbZALTjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 14:39:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On the current PM tree (2.6.28-rc8, revision 2beb9b4b) I have USB OTG
working - I see a device plugged in on boot, and it detaches when I pull
the cable, but it doesn't appear again when I reinsert the cable.

Any ideas on why the device doesn't show up again?

-- 
Peter Barada <peterb@logicpd.com>
