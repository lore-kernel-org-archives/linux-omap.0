From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP: fix USB regression on Nokia boards
Date: Thu, 15 Aug 2013 23:58:24 -0700
Message-ID: <20130816065805.GA7656@atomide.com>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
 <20130815191808.GA3067@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25183 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3HPG6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 02:58:35 -0400
Content-Disposition: inline
In-Reply-To: <20130815191808.GA3067@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130815 12:25]:
> Hi,
> 
> On Tue, Aug 06, 2013 at 08:06:14PM +0300, Aaro Koskinen wrote:
> > USB subsystem changes broke the USB peripheral/gadget on N800, N810 and
> > RX-51/N900 during the merge window. We need to fix this in board files. I
> > tested all these with 3.11-rc4 + g_ether + ssh.
> 
> Ping?

Applying into omap-for-v3.11/fixes thanks.

Tony
