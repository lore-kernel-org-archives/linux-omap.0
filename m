From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: fix TWL4030 COR bit polarity for BCI SIH block
Date: Tue, 5 Oct 2010 08:52:20 -0700
Message-ID: <20101005155220.GF3117@atomide.com>
References: <1285680139-19092-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63220 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab0JEPwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 11:52:23 -0400
Content-Disposition: inline
In-Reply-To: <1285680139-19092-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

* Grazvydas Ignotas <notasas@gmail.com> [100928 06:14]:
> The chip TRM documentation contradicts itself about this bit, page 174
> of swcu050e says bit should be 0 for clear-on-read behavior, while
> page 487 says it should be 1. Testing shows it should be 1, so set
> the .set_cor flag accordingly. This is needed for upcoming BCI
> charging driver to function.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Acked-by: Tony Lindgren <tony@atomide.com>
