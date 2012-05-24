From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/4] omap legacy full speed usb cleanup for v3.6
Date: Thu, 24 May 2012 14:02:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205241401070.2572@utopia.booyaka.com>
References: <20120521185323.927.88012.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38738 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966191Ab2EXUCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 16:02:03 -0400
In-Reply-To: <20120521185323.927.88012.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com

On Mon, 21 May 2012, Tony Lindgren wrote:

> This series removes the old legacy fulls speed support for
> omap2 as it's pretty much only used for omap1 only.
> 
> For omap2, only n8x0 seems to have active development, and
> that has the external high speed tusb chip instead.

Just FYI, full speed host USB exists on OMAP4.  It's in section 23.13 of 
the TRM and we have a hwmod for it.  No idea if anyone is actually using 
it.


- Paul
