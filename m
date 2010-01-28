From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: McSPI questions pertaining to GPIO chip select support
Date: Wed, 27 Jan 2010 23:25:43 -0500
Message-ID: <1264652679-sup-5758@ben-laptop>
References: <1264016711-sup-309@ben-laptop> <1264651770-sup-5197@ben-laptop> <4B610F49.9070705@billgatliff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f182.google.com ([209.85.221.182]:59588 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0A1EZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 23:25:46 -0500
Received: by qyk12 with SMTP id 12so150957qyk.21
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 20:25:46 -0800 (PST)
In-reply-to: <4B610F49.9070705@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael Hennerich <michael.hennerich@analog.com>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general <spi-devel-general@lists.sourceforge.net>

Excerpts from Bill Gatliff's message of Wed Jan 27 23:15:05 -0500 2010:
> Ben Gamari wrote:
> > As I am writing this, it now occurs to me that perhaps the chip doesn't
> > start SPI_CLK until it has data to send.
> 
> ... or receive.  This is indeed the case.
> 
Thanks for your prompt reply. Hopefully you'll see a patch from me about
this in the next few days. I'm assuming this functionality would be
welcome in mainline?

- Ben
