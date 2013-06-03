From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc1
Date: Mon, 3 Jun 2013 08:55:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306030854520.4635@utopia.booyaka.com>
References: <alpine.DEB.2.00.1305192159080.2656@utopia.booyaka.com> <alpine.DEB.2.00.1305192219240.2656@utopia.booyaka.com> <874ndwmdis.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33683 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3FCIzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 04:55:45 -0400
In-Reply-To: <874ndwmdis.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 21 May 2013, Kevin Hilman wrote:

> I also just noticed that 3730beaglexm has stopped waking from suspend
> via RTC (non-DT boot.)  Waking from UART console still works.
> 
> Worked fine on v3.9, so there's a regressions somewhere.

Thanks Kevin, noted this in the logs.  Please let me know when it starts 
working again.


- Paul
