From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Retu watchdog clean-up and fix to make it behave
Date: Mon, 12 May 2008 17:35:15 -0700
Message-ID: <1210638918-26644-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54575 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbYEMAfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 20:35:18 -0400
In-Reply-To: retu-2008-05-12-173514
References: retu-2008-05-12-173514
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi all,

These patches clean retu watchdog code a bit, and make it behave like
a standard Linux watchdog device. The cost is about 250 bytes larger
kernel.

I'm also planning to remove the non-standard watchdog behaviour unless
somebody has good arguments why we should keep it.

Regards,

Tony

