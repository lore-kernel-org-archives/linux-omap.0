From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2/3: Move McBSP fck alias to hwmod data
Date: Mon, 18 Jun 2012 10:04:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206181004050.9031@utopia.booyaka.com>
References: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49708 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab2FRQEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 12:04:21 -0400
In-Reply-To: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Thu, 14 Jun 2012, Peter Ujfalusi wrote:

> To keep the McBSP fck alias handling in sync among OMAP versions.
> Change the legacy implementation for OMAP2/3 regarding to McBSP fck alias.
> OMAP4 (and OMAP5) uses the hwmod data to specify the aliases for the fcks and
> it is also needed for the coming McBSP DT support.
> 
> Tested on OMAP3 BeagleBoard, compile tested it for OMAP2.

Thanks, queued for 3.6.


- Paul
