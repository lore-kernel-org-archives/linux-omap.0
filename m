From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/1] omap2/3: Update revision identification
Date: Tue, 28 Sep 2010 15:17:12 -0700
Message-ID: <20100928221711.GR3117@atomide.com>
References: <1285337073-11759-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63621 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab0I1WRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 18:17:15 -0400
Content-Disposition: inline
In-Reply-To: <1285337073-11759-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [100924 06:57]:
> The existing definitions for cpu revision used
> upper nibble in the bits[15:08]. With OMAP3630,
> definitions use lower nibble.
> 
> This patch unifies the definitions to start
> at lower nibble.

Thanks, will queue this for the upcoming merge window.

Tony
