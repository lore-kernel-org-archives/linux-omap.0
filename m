From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: TSC2004 touch driver
Date: Wed, 2 Jul 2008 01:12:37 +0300
Message-ID: <20080701221237.GJ9696@kedavra.cpe.vivax.com.br>
References: <1214935195.22345.452.camel@blackhole> <1214938569.30276.784.camel@sax-lx.fischerfamily.org> <1214948527.22345.463.camel@blackhole>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42549 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYGAWMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 18:12:55 -0400
Content-Disposition: inline
In-Reply-To: <1214948527.22345.463.camel@blackhole>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: todd.fischer@ridgerun.com, linux-omap@vger.kernel.org

On Tue, Jul 01, 2008 at 05:42:07PM -0400, Peter Barada wrote:
> The TSC2004 is I2C, wheras the ADS7846 is SPI.  I've found a TSC2003
> driver written by Bill Gatliff for 2.4, but was wondering if anyone had
> a better starting point.
> 
> Also, any idea where I can find a "snap" (as in source) of the kernel
> work-in-progress, or is it all in the git trees?

there is tsc2005 in linux-omap.
look at drivers/input/touchscreen/tsc2005.c

if it helps you somehow, it's there :p

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
