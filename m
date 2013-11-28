From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory
 mapped.
Date: Thu, 28 Nov 2013 17:32:58 +0530
Message-ID: <529730F2.5070807@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-13-git-send-email-sourav.poddar@ti.com> <20131126131138.GJ14725@sirena.org.uk> <5296D37C.2020003@ti.com> <20131128104922.GK14725@sirena.org.uk> <5297242B.3040807@ti.com> <20131128115934.GE27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37399 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab3K1MD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Nov 2013 07:03:27 -0500
In-Reply-To: <20131128115934.GE27568@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com

On Thursday 28 November 2013 05:29 PM, Mark Brown wrote:
> On Thu, Nov 28, 2013 at 04:38:27PM +0530, Sourav Poddar wrote:
>> On Thursday 28 November 2013 04:19 PM, Mark Brown wrote:
>>> Removing the mapping isn't going to stop another context which has
>>> obtained a handle on the map trying to look at the mapping.
>> hmm..so the  'memcpy' part should be made atomic.(if possible?).
> Or holding the memory region should prevent normal SPI use (so any users
> ought to drop the memory region when they don't need it).
hmm.ok i will unmap the memory region when not in use.
> I'm still a bit surprised there's no DMA controllers for this...
Yes, but thats the truth :(
