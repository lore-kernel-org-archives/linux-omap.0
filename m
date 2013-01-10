From: Nishanth Menon <nm@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc2
Date: Thu, 10 Jan 2013 14:36:47 -0600
Message-ID: <20130110203646.GA7490@kahuna>
References: <alpine.DEB.2.00.1301101953270.15648@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40577 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754651Ab3AJUgs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jan 2013 15:36:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301101953270.15648@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On 19:54-20130110, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.8-rc2.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.8-rc2/20130103093341/
> 
> Failing tests: needing local investigation (may be due to testbed issues)
> -------------------------------------------------------------------------
> 
> Boot tests:
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
>   - Not yet part of the automated test suite
>   * May be due to an old U-boot with FDT support problems used here?
>     Pending local investigation and re-test
> 
Tested on AM335x A5 rev of bone board:
Could be older u-boot build. booting to ramdisk seems to work on rc2 and
3 (with omap2plus_defconfig)
http://www.hastebin.com/demafogebe.coffee

Comes up to ramdisk at least.
-- 
Regards,
Nishanth Menon
