From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc4
Date: Wed, 7 Nov 2012 17:32:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211071728310.20704@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com> <509A96DA.2010003@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48482 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab2KGRc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 12:32:58 -0500
In-Reply-To: <509A96DA.2010003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 7 Nov 2012, Jon Hunter wrote:

> On 11/04/2012 08:46 PM, Paul Walmsley wrote:
>
> > * 4460pandaes: boot fails early
> >   - Appears to be due to X-loader problems here
> >   - Need to note the X-loader version so we know it's broken
> 
> Are you still planning to investigate this further or migrate to a new
> bootloader?

Yes.  The problem with the current boot setup is that the new 
bootloader is breaking as well! :-(

This can be seen by comparing:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/boot/4460pandaes/4460pandaes_log.txt

(the old bootloader)

with

http://www.pwsan.com/omap/testlogs/test_v3.7-rc4/20121104142910/boot/4460pandaes/4460pandaes_log.txt

(the new bootloader)

Dealing with this will require hands-on access, and unfortunately, right 
now I am traveling and away from my testbed.  Next week, will take a 
closer look.

> With 4460 and 3.7-rc4, I am seeing that resume from suspend is not
> working (not sure when this broke though). I am just curious if anyone
> else sees this. My u-boot version is v2012.10.

If you have the chance, it would be useful to know if any of the v3.7-rcs 
worked.  Otherwise, will look at this next week.


- Paul
