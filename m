From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: N9/N950: fix boot hang with 3.14-rc1
Date: Thu, 13 Feb 2014 15:22:49 -0800
Message-ID: <20140213232249.GQ28216@atomide.com>
References: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
 <52FA83DE.70504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46566 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751902AbaBMXXL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 18:23:11 -0500
Content-Disposition: inline
In-Reply-To: <52FA83DE.70504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [140211 12:13]:
> On 02/09/2014 06:12 AM, Aaro Koskinen wrote:
> > N9/N950 does not boot anymore with 3.14-rc1, because SoC compatible
> > property is missing. Fix that.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applying both into omap-for-v3.14/fixes thanks.

Tony
