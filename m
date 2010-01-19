From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCHv2 1/1] OMAP3: PM: Fix compilation issue of omap opp layer
 functions
Date: Tue, 19 Jan 2010 19:39:57 +0530
Message-ID: <4B55BD35.5030001@ti.com>
References: <1263909486-30967-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab0ASOKH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 09:10:07 -0500
In-Reply-To: <1263909486-30967-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> This patch removes the compilation error when compiling
> kernel with CONFIG_PM=N. The problem was that omap3_pm_init_opp_table
> was not defined if CONFIG_PM=N.
NAK. See reply to your other thread.
