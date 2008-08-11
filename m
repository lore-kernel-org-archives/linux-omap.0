From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Mon, 11 Aug 2008 01:50:25 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808110145370.10219@utopia.booyaka.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>  <1218016428.25235.11.camel@pc1117.cambridge.arm.com>  <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>  <20080807073035.GA10255@flint.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>  <20080807192531.GF5737@flint.arm.linux.org.uk>  <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>  <20080807212033.GH5737@flint.arm.linux.org.uk>
 <1218195889.12256.31.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49502 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYHKHu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 03:50:26 -0400
In-Reply-To: <1218195889.12256.31.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Fri, 8 Aug 2008, Catalin Marinas wrote:

> There are already CPUs with weaker memory ordering model than ARM (e.g.
> Alpha) and they are supported by Linux. Of course, there may be problems
> with drivers since most of them are developed in x86.

For the OMAP SoC, most of the drivers are specific to ARM.  The devices 
just aren't available for x86 or other architectures.  (With a few 
exceptions - smc91x and MUSB are the two that come to mind.)


- Paul
