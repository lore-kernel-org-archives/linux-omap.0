From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4: crypto acceleration (AES, SHA, ...)
Date: Mon, 17 Sep 2012 13:38:22 -0700
Message-ID: <20120917203821.GX4521@atomide.com>
References: <20120913215707.GA22825@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11861 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755137Ab2IQUiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 16:38:24 -0400
Content-Disposition: inline
In-Reply-To: <20120913215707.GA22825@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [120913 14:58]:
> Hi,
> 
> Are there plans to add crypto acceleration support to OMAP4? Has
> this hardware component been removed from OMAP4? I tried to load the
> code written for OMAP3 on my Pandaboard, but it just outputs
> "platform not supported":
> 
> [    0.370513] omap_init_sham: platform not supported
> [    0.375488] omap_init_aes: platform not supported

I recall hearing at some point that these are now available
only in the secure mode? Maybe somebody from TI could
check this?

Regards,

Tony
