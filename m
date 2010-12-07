From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
 into OMAP2/3-specific files
Date: Tue, 7 Dec 2010 13:37:11 +0000
Message-ID: <20101207133710.GW4698@rakim.wolfsonmicro.main>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
 <20101207012516.3708.87606.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40422 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754056Ab0LGNhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 08:37:13 -0500
Content-Disposition: inline
In-Reply-To: <20101207012516.3708.87606.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, Dec 06, 2010 at 06:25:17PM -0700, Paul Walmsley wrote:
> In preparation for adding OMAP4-specific PRCM accessor/mutator
> functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specific
> files.  Most of what was in mach-omap2/{cm,prm}.{c,h} has now been
> moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
> OMAP2xxx/3xxx-specific.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
