From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.14-rc1
Date: Mon, 10 Feb 2014 18:02:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402101801170.30435@utopia.booyaka.com>
References: <alpine.DEB.2.02.1402101733340.30435@utopia.booyaka.com> <52F913A5.7040207@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54665 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbaBJSCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 13:02:10 -0500
In-Reply-To: <52F913A5.7040207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, 10 Feb 2014, Nishanth Menon wrote:

> On 02/10/2014 11:48 AM, Paul Walmsley wrote:
> [...]
> > Boot to userspace:
> >     FAIL ( 1/10): 2430sdp
> 
> Comparing boot logs I reported
> http://marc.info/?l=linux-omap&m=139144642318949&w=2 Vs
> http://www.pwsan.com/omap/testlogs/test_v3.14-rc1/20140210035354/boot/2430sdp/2430sdp_log.txt
> 
> I see that bootargs are different -> I was attempting to boot sdp2430
> with nfs boot which seems to work fine for me, I believe you are
> attempting mmc boot here.

Yep.  My 2430SDP's Ethernet interface flaked out a month or two ago, so, 
switched it to serial booting.  Hey, better test coverage from us ;-)


- Paul
