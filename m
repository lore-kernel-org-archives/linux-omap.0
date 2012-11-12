From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Mon, 12 Nov 2012 14:06:22 -0800
Message-ID: <20121112220621.GQ6801@atomide.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <20121107173343.GF6801@atomide.com>
 <509B5B84.50605@compulab.co.il>
 <20121108162004.GA6801@atomide.com>
 <509F6CE3.50806@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28236 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752780Ab2KLWG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 17:06:27 -0500
Content-Disposition: inline
In-Reply-To: <509F6CE3.50806@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

* Igor Grinberg <grinberg@compulab.co.il> [121111 01:18]:
> On 11/08/12 18:20, Tony Lindgren wrote:
> > 
> > I guess what I'm after is just to avoid renaming the existing
> > timers in the board-*.c files and only rename the ones that
> > need gp timer only.
> 
> This means: get rid of the 32k to gptimer fall back.
> I've got your point, will cook something shortly.

Thanks that sounds reasonable to me.

Regards,

Tony
