From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 modem support in 3.18-rc1
Date: Wed, 5 Nov 2014 21:39:18 +0100
Message-ID: <20141105203918.GA29199@amd>
References: <20141104205117.GA17606@amd>
 <20141105011122.GA30622@earth.universe>
 <20141105203151.GA24636@amd>
 <201411052137.31452@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53001 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbaKEUjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 15:39:20 -0500
Content-Disposition: inline
In-Reply-To: <201411052137.31452@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg

Hi!

> Hello, have you enabled CONFIG_PHONET?

Yes:

CONFIG_PHONET=y

And this:

# SPI Protocol Masters                                                                            
#                                                                                                 
# CONFIG_SPI_SPIDEV is not set                                                                    
# CONFIG_SPI_TLE62X0 is not set                                                                   
# CONFIG_SPMI is not set                                                                          
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#                                                                                                 
# HSI controllers                                                                                 
#                                                                                                 
CONFIG_OMAP_SSI=y
CONFIG_OMAP_SSI_PORT=y

#                                                                                                 
# HSI clients                                                                                     
#                                                                                                 
CONFIG_NOKIA_MODEM=y
CONFIG_SSI_PROTOCOL=y
CONFIG_HSI_CHAR=y
CONFIG_HSI_CMT_SPEECH=y

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
