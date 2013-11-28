From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 06/17] spi/qspi: Add support to switc to memory mapped
 operation.
Date: Thu, 28 Nov 2013 10:09:40 +0530
Message-ID: <5296C90C.2060306@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-7-git-send-email-sourav.poddar@ti.com> <20131126125740.GG14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52356 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab3K1EkJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 23:40:09 -0500
In-Reply-To: <20131126125740.GG14725@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com

On Tuesday 26 November 2013 06:27 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 01:05:02PM +0530, Sourav Poddar wrote:
>
>> +void enable_qspi_memory_mapped(struct ti_qspi *qspi)
>> +void disable_qspi_memory_mapped(struct ti_qspi *qspi)
> These are driver internal functions so they should be static.  It'd also
> be more normal to put the qspi_ at the start of the name though it's not
> too big a deal.
Ok. will change.
