From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: McSPI questions pertaining to GPIO chip select support
Date: Wed, 27 Jan 2010 22:15:05 -0600
Message-ID: <4B610F49.9070705@billgatliff.com>
References: <1264016711-sup-309@ben-laptop> <1264651770-sup-5197@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:48874 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab0A1EO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 23:14:27 -0500
Received: by iwn16 with SMTP id 16so344105iwn.5
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 20:14:25 -0800 (PST)
In-Reply-To: <1264651770-sup-5197@ben-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael Hennerich <michael.hennerich@analog.com>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general <spi-devel-general@lists.sourceforge.net>

Ben Gamari wrote:
> As I am writing this, it now occurs to me that perhaps the chip doesn't
> start SPI_CLK until it has data to send.

... or receive.  This is indeed the case.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com

