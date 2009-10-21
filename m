From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] Fix broken NAND on Amstrad Delta
Date: Wed, 21 Oct 2009 12:53:50 +0200
Message-ID: <200910211253.51518.jkrzyszt@tis.icnet.pl>
References: <200910210239.55194.jkrzyszt@tis.icnet.pl> <20091021005134.GE16230@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:48180 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbZJUKyQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 06:54:16 -0400
In-Reply-To: <20091021005134.GE16230@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

Wednesday 21 October 2009 02:51:35 Tony Lindgren wrote:
>
> Let's just remove the omap_cfg_reg() calls from mach-omap1/serial.c, and
> add them to the board-*.c files like you suggest above. We should be able
> to find which ports to mux by looking at the enabled_uarts mask in the
> commit mentioned above.

Tony,
I can prepare a patch if you haven't started working on it yet, but please do 
me a favour and give your comments on another, old but still not answered 
subject:

http://www.spinics.net/lists/linux-omap/msg17692.html
I have just checked that temporary solution still applies cleanly on top of 
2.6.32-rc5 and corrects the problem of otherwise unusable ASoC over McBSP1 on 
my Amstrad Delta.

Thanks,
Janusz
