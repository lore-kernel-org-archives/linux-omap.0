From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V2] misc : ROHM BH1780GLI Ambient light sensor Driver
Date: Wed, 2 Jun 2010 14:05:28 +0100
Message-ID: <20100602140528.06013fee@lxorguk.ukuu.org.uk>
References: <39216.10.24.255.17.1274699065.squirrel@dbdmail.itg.ti.com>
	<20100601131244.7164b43c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44955 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750749Ab0FBM6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 08:58:46 -0400
In-Reply-To: <20100601131244.7164b43c.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hemanth V <hemanthv@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Jonathan Cameron <jic23@cam.ac.uk>, Wolfram Sang <w.sang@pengutronix.de>

> Is there any standardisation of the ABIs whcih these drivers offer?  If
> so, does this new driver comply with that?

There was an attempt to sort this out but Linux vetoed it because he is
under the delusion that light sensors are input devices. That doesn't
work in many use cases as you have to go ask them the light level and the
polling needed for input events keeps wrecks your idle behaviour when you
need to sample them when required instead. Instead therefore the API is
random and the devices appear in random ways and classes.

We have some intel drivers to submit as well as and when sanity prevails.

Alan
