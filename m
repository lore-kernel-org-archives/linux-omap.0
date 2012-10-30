From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 09:27:28 -0700
Message-ID: <20121030162727.GG11908@atomide.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23457 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934000Ab2J3Q1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 12:27:33 -0400
Content-Disposition: inline
In-Reply-To: <508FE8BA.1080404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > 
> > MMC is dependent on EDMA-DMA conversion patches from Matt, which he has 
> > already submitted to the list recently. So MMC support will come along with
> > EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it goes.

This is a bogus dependency, the MMC driver needs to also work
without DMA.

Regards,

Tony
