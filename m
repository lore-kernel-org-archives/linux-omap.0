From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 03/17] spi/qspi: parse register by name.
Date: Thu, 28 Nov 2013 10:15:14 +0530
Message-ID: <5296CA5A.90304@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-4-git-send-email-sourav.poddar@ti.com> <20131126103029.GY14725@sirena.org.uk> <5294835D.5090902@ti.com> <20131126122442.GC14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab3K1Epo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 23:45:44 -0500
In-Reply-To: <20131126122442.GC14725@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com

On Tuesday 26 November 2013 05:54 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 04:47:49PM +0530, Sourav Poddar wrote:
>
>> I have added "reg-names" property in dt bindings. (17/17) patch of
>> this series has that info.
> Do device tree binding changes early on in the series rather than at the
> end, one of the things that gets reviewed for is binding updates.
>
> Your code should also cope with the existing bindings, falling back on
> the current behaviour if it can't get the names or the extra resources.
My current code only has a single resouce, hence "*_byname* variants
was not used. With extra resources, I am switching to "byname" variants,
So, if a particular resource name is not found, it should just bypass 
that, thinking
the resource is not required and should not resort to existing bindings..
