From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OMAP 3530 without a PMIC
Date: Wed, 23 Feb 2011 12:06:49 -0800
Message-ID: <20110223200648.GA2534@opensource.wolfsonmicro.com>
References: <0bfe01cbd363$e8ff6a91$cb0a10ac@sypris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47675 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754665Ab1BWUGa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 15:06:30 -0500
Content-Disposition: inline
In-Reply-To: <0bfe01cbd363$e8ff6a91$cb0a10ac@sypris.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 23, 2011 at 09:14:10AM -0500, Boswell, Patrick wrote:

Don't top post and please fix your mail client to word wrap within
paragraphs.

> I will check that out Mark.

> I did notice that there was discussion a while back about "dummy
> regulators". I think that might work -- has anyone tried this
> approach?

That's implemented but isn't really relevant if you're not using
regulators on your system.  It's also a bit of a stopgap solution - it
papers over the issue at runtime but ideally the code would make it
clear that everything is working correctly.
