From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/12] DRA7xx PRCM, hwmod and DT data
Date: Wed, 21 Aug 2013 02:10:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308210203190.6426@utopia.booyaka.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46204 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab3HUCKK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 22:10:10 -0400
In-Reply-To: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com

Hi

On Tue, 9 Jul 2013, Rajendra Nayak wrote:

> This series adds the data files for DRA7xx devices for
> PRCM, hwmod and DT. This is dependent on the core support [1]
> patches for DRA7xx and leaves out the clock data since its
> on its way to DT [2]
> 
> The regbit headers for prm and cm are cleaned up post the
> autogeneration as 95% was seen to be currently unused
> (prm-regbits-7xx.h was 100% unused and hence removed)
> 
> These patches along with the core support patches are available at:
> git://github.com/rrnayak/linux.git for-3.12/dra-core-data

Is a public TRM available for this chip?

Can development boards be made available to the OMAP maintainers so we can 
ensure that the code, once merged, continues to work?


- Paul
