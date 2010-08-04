From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] [omap1] omap7xx clocks, mux, serial fixes
Date: Wed, 4 Aug 2010 13:13:28 +0300
Message-ID: <20100804101328.GF9881@atomide.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
 <1280762976-17284-4-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55543 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab0HDKNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:13:04 -0400
Content-Disposition: inline
In-Reply-To: <1280762976-17284-4-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds in the necessary clocks and mux pins for UART
> control on omap7xx devices.  I also made a change in the serial
> code to only try and initialize two UARTs in omap_serial_init, as
> these devices don't have three.

This I have already queued up in omap-for-linus.

Regards,

Tony
