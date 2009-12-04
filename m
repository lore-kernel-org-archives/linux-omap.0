From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv2 0/6] Idle status patches revisited
Date: Fri,  4 Dec 2009 10:52:55 +0200
Message-ID: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28554 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbZLDIz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 03:55:56 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nB48tYC7011940
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 10:56:00 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nB48tm67013537
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 10:55:49 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Improvements compared to previous set:

- Fixed wrong pwrdm state check on IO chain arming on patch 2
- Improved changelog on patch 2 & 4
- Moved FCLK checks inside clockdomain code from powerdomain code in patch 5
- Some style changes on patch 6

Still, I believe there is no simple way of implementing the idle status
check by using the usecounts inside clock framework. It would probably be
possible by adding a new usecount variable that would be updated according
to slightly different rules, but this also looks bit complicated compared
to the need.

-Tero


