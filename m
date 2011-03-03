From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ldp: Fix regulator mapping for ads7846 TS controller
Date: Wed, 2 Mar 2011 17:00:03 -0800
Message-ID: <20110303010002.GF20560@atomide.com>
References: <1298552202-28307-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29977 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1CCBAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 20:00:09 -0500
Content-Disposition: inline
In-Reply-To: <1298552202-28307-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [110224 04:54]:
> On the OMAP3430LDP board, the ads7846 touchscreen controller
> is powered by VAUX1 regulator (supplying 3.0v).
> Fix this mapping in the board file, and hence prevent
> the ads7846 driver init to fail with the below error..
> 
> ads7846 spi1.0: unable to get regulator: -19

Applying for the merge window.

Tony
