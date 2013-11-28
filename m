From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 02/17] spi/spi.h: Add configure from slave support.
Date: Thu, 28 Nov 2013 10:17:38 +0530
Message-ID: <5296CAEA.3030002@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-3-git-send-email-sourav.poddar@ti.com> <20131126102951.GX14725@sirena.org.uk> <52948451.3060706@ti.com> <20131126122159.GB14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54191 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471Ab3K1EsG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 23:48:06 -0500
In-Reply-To: <20131126122159.GB14725@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com

On Tuesday 26 November 2013 05:51 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 04:51:53PM +0530, Sourav Poddar wrote:
>> On Tuesday 26 November 2013 03:59 PM, Mark Brown wrote:
>>>> +	void	(*configure_from_slave)(struct spi_device *spi, u8 *val);
>>> Clearly this is far too unstructured to be useful, this is only ever
>>> going to work with one specific combination of slave and master since
>>> there's absolutely no semantics defined.
>> I thought "val" might be good enuf, and this can be filled with whatever
>> data that need to be used from slave into master(irrespective of
>> slave and master?).
> The name isn't the issue, it's the fact that you're passing a completely
> unspecified blob of data.
May be, what you are suggesting here is to we should define a flash 
information
structure and should pass that structure here ?

