From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 1/2] mcx: very basic support for HTKW mcx board
Date: Fri, 16 Dec 2011 17:37:40 -0800
Message-ID: <20111217013740.GF6464@atomide.com>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com>
 <1323910383-1184-2-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44139 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752752Ab1LQBhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 20:37:42 -0500
Content-Disposition: inline
In-Reply-To: <1323910383-1184-2-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

* Ilya Yanok <yanok@emcraft.com> [111214 16:21]:
> Very basic support for HTKW mcx board. Able to boot via board-generic
> and ramdisk/initramfs, however most of peripherals is unsupported.
> Produces tons of twl4030 related errors as this board doesn't have
> twl4030 installed.

Please resend with linux-arm-kernel and devicetree-discuss
lists in Cc. We need an ack from the devicetree people for this.

Tony
