From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add
 read_reset_sources pdata function pointer
Date: Thu, 25 Oct 2012 18:38:05 +0300
Message-ID: <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:37526 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759683Ab2JYPiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 11:38:08 -0400
Content-Disposition: inline
In-Reply-To: <20121016013213.21844.20016.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

Hi,

On Mon, Oct 15, 2012 at 07:32:33PM -0600, Paul Walmsley wrote:
> The OMAP watchdog timer driver directly calls a function exported by
> code in arch/arm/mach-omap2.  This is not good; it tightly couples
> this driver to the mach-omap2 integration code.  Instead, add a
> temporary platform_data function pointer to abstract this function
> call.  A subsequent patch will convert the watchdog driver to use this
> function pointer.

Why a function is needed? Reset cause won't change until the next reset,
so it should be enough to read it once during the init and store it into
the platform data.

A.
