From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Thu, 21 Feb 2013 12:16:03 +0200
Message-ID: <20130221101603.GI23234@tbergstrom-lnx.Nvidia.com>
References: <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215064429.GA30038@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
 <20130220191638.GA25609@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:8770 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3BUKQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 05:16:26 -0500
Content-Disposition: inline
In-Reply-To: <20130220191638.GA25609@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

> 
> Also, IMHO reset should always be done during probe() so driver can be
> dead sure that we're starting from a known state. This is even more

Depends on the IP block. Eg: you might want to keep the screen showing the
contents drawn by the bootloader while booting the kernel and smoothly
change to a new image when userspace comes online. In that case you probably
don't want to blindly reset the display controller for example.

Cheers,

Peter.
