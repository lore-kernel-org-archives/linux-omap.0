From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 17:27:29 +0300
Message-ID: <20080924142728.GT5222@atomide.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com> <20080924.065137.142952786.Hiroshi.DOYU@nokia.com> <dfeb90390809240005xadef43dhb78c8ae214baab64@mail.gmail.com> <20080924071201.GE5222@atomide.com> <20080924075959.GF5222@atomide.com> <alpine.DEB.2.00.0809240202250.15312@utopia.booyaka.com> <20080924080652.GG5222@atomide.com> <alpine.DEB.2.00.0809240207480.15312@utopia.booyaka.com> <20080924083446.GH5222@atomide.com> <alpine.DEB.2.00.0809240805410.15312@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55035 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYIXO1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:27:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0809240805410.15312@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Arun KS <arunks@mistralsolutions.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [080924 17:06]:
> On Wed, 24 Sep 2008, Tony Lindgren wrote:
> 
> > How about this for a quick fix? It produces now a bunch of warnings
> > until omap1 clock uses offsets too.
> 
> Looks good to me.  Good to see that VIRTUAL_IO_ADDRESS flag gone -- 

OK, pushed with a minror change. I've marked DSP addresses as IOMEM.

Tony
