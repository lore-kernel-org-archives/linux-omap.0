From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/3] ARM: OMAP2: HACK: hardcode hsmmc2 input clock source
 for N950/N9
Date: Mon, 23 Sep 2013 21:03:50 +0300
Message-ID: <20130923180350.GA17450@blackmetal.musicnaut.iki.fi>
References: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
 <1379771142-29087-2-git-send-email-aaro.koskinen@iki.fi>
 <20130923173843.GI2684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:41489 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab3IWSEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Sep 2013 14:04:00 -0400
Content-Disposition: inline
In-Reply-To: <20130923173843.GI2684@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>

Hi,

On Mon, Sep 23, 2013 at 10:38:43AM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [130921 06:56]:
> > Without this the eMMC (root file system) cannot be used on N950/N9.
> > Any ideas for a proper solution?

> Can you please update this patch on the quirks series I posted
> few days ago?

Ok, will do (sorry I missed that series).

Thanks,

A.
