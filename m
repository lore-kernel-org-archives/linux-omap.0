From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH][RFC] OMAP3: PM: Adding OSWR support
Date: Fri, 28 Aug 2009 09:06:37 -0700
Message-ID: <20090828160636.GK25828@atomide.com>
References: <1251391962-11217-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65333 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZH1QGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 12:06:37 -0400
Content-Disposition: inline
In-Reply-To: <1251391962-11217-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

* Thara Gopinath <thara@ti.com> [090827 09:54]:
> This patch adds OSWR support for MPU/CORE domains in CPUidle.
> Two new C states are being added to the existing C states
> which makes the new states look like below.

Please explain what OSWR means, the patch description should be clear
to everybody. I guess you mean Open SWitch Retention?

Tony
