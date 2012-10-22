From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Mon, 22 Oct 2012 17:17:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210221716000.13464@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> <50856FEB.30900@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56751 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab2JVRRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 13:17:53 -0400
In-Reply-To: <50856FEB.30900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jon

On Mon, 22 Oct 2012, Jon Hunter wrote:

> On 10/20/2012 04:26 PM, Paul Walmsley wrote:
> 
> ...
> 
> > Other:
> > 
> > * 4430es2panda:	omap_hwmod: l3_instr: _wait_target_disable failed
> >   - Unknown cause; could be due to the lack of hierarchical enable/disable
> >     in hwmod code
> 
> I am not seeing this on my omap4430 panda. I have an OMAP4430 ES2.3 and
> I am using u-boot release 2012.10. What do you have?

It's documented in the bootlog:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/boot/4430es2panda/4430es2panda_log.txt

It's "U-Boot 2012.07-00136-g755de79 (Aug 24 2012 - 14:19:44)" on an 
OMAP4430 ES2.0.


- Paul
