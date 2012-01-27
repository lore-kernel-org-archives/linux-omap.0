From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix MMC2 loopback clock handling
Date: Thu, 26 Jan 2012 16:16:38 -0800
Message-ID: <20120127001638.GF29812@atomide.com>
References: <1326378405-27632-1-git-send-email-notasas@gmail.com>
 <4F0EFAC1.2080003@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53355 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab2A0AQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 19:16:41 -0500
Content-Disposition: inline
In-Reply-To: <4F0EFAC1.2080003@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120112 06:50]:
> On 01/12/12 16:26, Grazvydas Ignotas wrote:
> > Currently MMC2 setup code can only enable loopback clock and
> > relies on reset value for boards that need to have it disabled.
> > This causes a problem with certain bootloaders that always enable
> > that clock, resulting with unwanted bootloader dependencies.
> > 
> > Fix this by making it disable the clock if board data says so.
> > 
> > Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks applying into fixes.

Tony
