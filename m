From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
Date: Tue, 21 Dec 2010 12:21:33 -0800
Message-ID: <20101221202133.GJ5829@atomide.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63434 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab0LUUVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 15:21:40 -0500
Content-Disposition: inline
In-Reply-To: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Jarkko Nikula <jhnikula@gmail.com> [101221 09:25]:
> Hi
> 
> Commit 60d24ee "Added video data to support tvout on rx51" broke the
> framebuffer on N900. Here are two patches where 1st one does a little cleanup
> to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
> are working.

Tomi, do you want to pick these three DSS/video related patches from Jarkko?

If so:

Acked-by: Tony Lindgren <tony@atomide.com>

else please ack and let me know if you want me to take them.

Regards,

Tony
