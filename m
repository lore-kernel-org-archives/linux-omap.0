From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Thu, 10 Mar 2011 06:16:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100616240.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <4D78CAFC.4080502@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35416 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab1CJNQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 08:16:46 -0500
In-Reply-To: <4D78CAFC.4080502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 10 Mar 2011, Rajendra Nayak wrote:

> On Thursday 10 March 2011 05:48 PM, Paul Walmsley wrote:
> > This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> > so I've dropped it from the integration branch until it can be
> > debugged.  Could you check it, please?
> > 
> > The tag "integration-2.6.39-20110310-008" of
> > git://git.pwsan.com/linux-integration boots fine; it's got everything
> > but this patch.  Then when this patch is applied, I2C problems show
> > up, and root (on MMC) doesn't mount.
> 
> Looks like you are missing this patch which should fix the i2c
> timeouts..
> http://marc.info/?l=linux-omap&m=129924561819873&w=2

Thanks, let's see if Ben is planning to merge it for 2.6.39.


- Paul
