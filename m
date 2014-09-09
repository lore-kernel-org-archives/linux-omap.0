From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: cm-t54: fix serial console power supply.
Date: Mon, 8 Sep 2014 17:18:18 -0700
Message-ID: <20140909001817.GC10785@atomide.com>
References: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
 <1409835773-22782-2-git-send-email-lifshitz@compulab.co.il>
 <alpine.DEB.2.02.1409041539540.23951@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29620 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbaIIASY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 20:18:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1409041539540.23951@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140904 08:44]:
> On Thu, 4 Sep 2014, Dmitry Lifshitz wrote:
> 
> > LDO8 regulator is used for act led and serial cosole power supply.
> > 
> > Its DT status is declared as "disabled", however the serial console was
> > functional until Commit 318dbb02b ("regulator: palmas: Fix SMPS
> > enable/disable/is_enabled") wich properly turns off LDO8 on boot.
> > 
> > Fix serial cosole power supply (and act led) on boot by turning LDO8 on.
> > 
> > Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> 
> Tested-by: Paul Walmsley <paul@pwsan.com>

Applying this into omap-for-v3.17/fixes-v2, the second into
omap-for-v3.18/dt thanks.

Tony
