From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to change freq of mmc2_clk to 48Mhz for OMAP35xx
Date: Wed, 8 Dec 2010 13:36:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012081330470.13430@utopia.booyaka.com>
References: <68E48EB0-25B0-4D1B-B7C3-587A521F309F@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51240 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab0LHUgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 15:36:04 -0500
In-Reply-To: <68E48EB0-25B0-4D1B-B7C3-587A521F309F@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, 8 Dec 2010, Elvis Dowson wrote:

>        What should I do to change the output frequency of mmc2_clk 
> signal to 48Mhz for the OMAP35xx processor?
> 
> Right now it is giving an output of 96MHz and the signal output looks 
> more like a sine wave than a square wave clock output signal.

Assuming you're using the mainline kernel, it doesn't look like the MMC 
driver changes its functional clock at all.  So perhaps your bootloader is 
programming it incorrectly?

I guess at some point we will need to reprogram all the clocks on boot 
also, to deal with buggy bootloaders...

Anyway, if you want to try changing it from the kernel side, you'll need 
code like this in the MMC driver or OMAP integration code (off the top of 
my head, untested):

struct clk *c;
c = clk_get(dev, "fck"); 
clk_set_rate(c, 48000000);
clk_put(c);

Please let me know if this doesn't work.


- Paul
