From: Tony Lindgren <tony@atomide.com>
Subject: Re: DT support for Overo?
Date: Wed, 29 Aug 2012 16:23:30 -0700
Message-ID: <20120829232330.GE1303@atomide.com>
References: <503DE344.5090909@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48254 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab2H2XXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 19:23:34 -0400
Content-Disposition: inline
In-Reply-To: <503DE344.5090909@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Steve Sakoman <steve@sakoman.com>, andy.doan@linaro.org, linux-omap@vger.kernel.org

* Florian Vaussard <florian.vaussard@epfl.ch> [120829 02:46]:
> Hello,
> 
> Before doing the work twice, is someone working on the arm/dts for the overo
> board? I found a first support in the linaro tree [1], but is there
> any active
> work to complete this support and push it upstream? I am preparing a
> daughter
> board with some specific hardware, thus I could give some help with the
> conversion effort.

Great, go for it! The DMA engine binding is still missing as well as
bindings for some drivers. But your should be able to get basic things
going quite easily.

Regards,

Tony
 
> [1] http://patches.linaro.org/833/
