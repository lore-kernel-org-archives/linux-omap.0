From: Tony Lindgren <tony@atomide.com>
Subject: Re: UART driver DMA support
Date: Fri, 18 Apr 2008 09:40:17 -0700
Message-ID: <20080418164016.GE12099@atomide.com>
References: <75b29de30804172215v72ea18f4n61ec097b35f378bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54283 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbYDRQkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 12:40:19 -0400
Content-Disposition: inline
In-Reply-To: <75b29de30804172215v72ea18f4n61ec097b35f378bd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rajeev seetharam <rseetharam@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* rajeev seetharam <rseetharam@gmail.com> [080417 22:16]:
> Hi ,
> 
> I am using the OMAP2EVM board based on OMAP2430  and using Linux - 2.6.23
> Is the DMA support available as part of the UART driver.

Well there's an omap specific serial driver in works, which should
make it easy to add DMA support eventually. No idea on when it will be
available though, but some earlier patches are available at:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-April/009537.html

AFAIK nobody is working on adding DMA to it yet, so that might be
worth doing.

Tony
