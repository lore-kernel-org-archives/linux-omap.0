From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap voltage cleanup for v3.2 merge window
Date: Tue, 20 Sep 2011 14:21:20 -0700
Message-ID: <20110920212120.GJ2937@atomide.com>
References: <20110917015419.GD2937@atomide.com>
 <201109202206.24931.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:12358 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751560Ab1ITVVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 17:21:24 -0400
Content-Disposition: inline
In-Reply-To: <201109202206.24931.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [110920 12:32]:
> On Saturday 17 September 2011, Tony Lindgren wrote:
> > Please pull omap voltage cleanup series:
> > 
> > git://github.com/tmlind/linux.git voltage
> > 
> > This has a dependency to the cleanup part 1 series. As
> > this contains some voltage fixes too, it's a separate
> > series. You can either pull it into cleanup or keep it
> > separate.
> 
> Hi Tony,
> 
> I've pulled it into the for-next branch, but haven't
> made up my mind how it I will send it upstream.
> I definitely think it's good that you sent it to me
> as a separate series, given the number of patches in it.

OK thanks. FYI, most of the voltage stuff can eventually
become just a regular device driver. But that depends on
some other changes, like PRCM interrupt driver.

Regards,

Tony
