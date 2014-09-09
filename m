From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: Remove stray ARCH_HAS_OPP references
Date: Mon, 8 Sep 2014 17:20:55 -0700
Message-ID: <20140909002054.GE10785@atomide.com>
References: <1409998456-28066-1-git-send-email-broonie@kernel.org>
 <540B15E1.6090604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56065 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753533AbaIIAU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 20:20:59 -0400
Content-Disposition: inline
In-Reply-To: <540B15E1.6090604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [140906 07:11]:
> On 09/06/2014 05:14 AM, Mark Brown wrote:
> >OPP is now a normal kernel library selected by its users rather than a
> >feature that architectures need to enable so ARCH_HAS_OPP serves no
> >function any more - remove the selects.
> >
> >Signed-off-by: Mark Brown <broonie@kernel.org>
... 
 
> Acked-by: Nishanth Menon <nm@ti.com>

Applying into omap-for-v3.18/soc thanks.

Tony 
