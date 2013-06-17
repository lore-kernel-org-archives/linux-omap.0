From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Mon, 17 Jun 2013 04:41:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306170439030.4477@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com> <51BB0EC1.908@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48356 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab3FQEl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 00:41:59 -0400
In-Reply-To: <51BB0EC1.908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 14 Jun 2013, Lokesh Vutla wrote:

> On Monday 10 June 2013 12:52 PM, Paul Walmsley wrote:
> 
> > * 3730 Beagle XM, am335xbone, CM-T3517: uart4_rx.uart4_rx mux failure
> >    - Cause unknown
> I am able to reproduce this issue on 37xx EVM using non-dt boot (dt boot
> doesn't throw this error). But this is not started with v3.10-rc, it has been
> present on older kernels also( I verified on 3.9 kernel).

Digging through my logs here, the message actually goes back to v3.5 at 
least.  Thanks for pointing this out.

> This is because that for all instances of uart, serial driver expects a 
> pad with default mode which is not the case for uart4 in 37xx EVM. 

I haven't looked into the issue.  Is it something that's easy to fix?  If 
so please send a patch.


- Paul
