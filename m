From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Add support for Variscite OMAP4460
 System-On-Module
Date: Mon, 5 Mar 2012 10:41:42 -0800
Message-ID: <20120305184142.GI12083@atomide.com>
References: <1326898096-4899-1-git-send-email-uri.y@variscite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14765 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab2CESls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 13:41:48 -0500
Content-Disposition: inline
In-Reply-To: <1326898096-4899-1-git-send-email-uri.y@variscite.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uri Yosef <uri.y@variscite.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, oren@variscite.com, uri.yosef@gmail.com, Uri Yosef <uri@embedox.com>

Hi,

* Uri Yosef <uri.y@variscite.com> [120118 06:13]:
> From: Uri Yosef <uri@embedox.com>
> 
> Add support for Variscite OMAP4460 System-On-Module and development kit board.
> Working: LCD, HDMI, USB, UART, Ethernet.

For reference, we're trying to remove board-*.c files by
changing over to device tree. So new board-*.c files will
be merged. You might want to look at booting your board
using board-generic.c and a related .dts file.

While this transition is happening, I can carry some
board-*.c files in the testing-board branch until devices
start working sufficiently for board-generic.c to be
usable.

Regards,

Tony
