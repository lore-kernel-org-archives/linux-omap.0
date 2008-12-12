From: Tony Lindgren <tony@atomide.com>
Subject: Revert "OMAP: HSMMC: Implement scatter-gather emulation"
Date: Thu, 11 Dec 2008 18:00:23 -0800
Message-ID: <20081212020021.GH10664@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59768 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000AbYLLCAX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 21:00:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi all,

Looks like Juha's MMC scatter-gather patch breaks at least overo when
using 4 data lines. It seems to work when using only 1 data line.
So I've reverted patch 038d0d2f64cc1f03bfaf1d5f22d9eacf33926a51 for now.

Any ideas? Maybe some timings issue?

Regards,

Tony
