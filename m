From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Arm device tree wonder
Date: Tue, 30 Aug 2011 19:30:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108301910390.26173@utopia.booyaka.com>
References: <1314734987.11994.YahooMailNeo@web132211.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42405 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab1HaBa7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 21:30:59 -0400
In-Reply-To: <1314734987.11994.YahooMailNeo@web132211.mail.ird.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Beaumon <pierre.beaumon@yahoo.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

On Tue, 30 Aug 2011, Pierre Beaumon wrote:

> Also I believe one big arm problem is a lack of common infrastructure 
> that lead to code duplication. Some machine try to do too much things. 
> omap2 (mach-omap2 + plat-omap) is about 80 KSLOC over 400KSLOC (76 mach 
> + plat directories). That 8 times bigger than the average 
> ((80/2)/(400/76))! There are either common stuff that should be shared, 
> or some stuff should be moved in drivers.

Here are some additional data points you might consider adding to your 
analysis:

- Consider taking into account what percentage of those lines are for 
  SoC-specific device data files.  Where should those files be moved, 
  before a DT (or other data format) conversion?

- Consider comparing the number of on-chip devices supported by the core 
  OMAP code to the number of devices supported by the average SoC core 
  code, in mainline.

- Consider accounting for the extra code and data needed for fine-grained 
  power management, compared to the average SoC core code, assuming the
  SoC supports it.

- Consider taking into account the number of OMAP variants supported by 
  the core OMAP code (at least thirty, not counting silicon revision 
  differences, which can be significant) compared to the average SoC.

- Consider comparing the number of boards supported by the core OMAP code
  to the number supported by the average SoC code.  To what other shared
  directory or drivers/ subdirectory should these files be moved to,
  before a DT conversion?

To be sure, there's a fair amount of OMAP core code that should be moved 
out to drivers.  My guess is about 10-15% of the current total.  Work 
along those lines is proceeding.  If you're offering to help, we could use 
it.

But I don't think that the way to deal with the remaining 85-90% of the 
core code and data is quite as simple as your rough summary suggests.


- Paul
