From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Thu, 21 Feb 2013 13:09:43 +0100
Message-ID: <87txp5hnqw.fsf@dell.be.48ers.dk>
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
	<20130221101603.GI23234@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57939 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab3BUMJs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 07:09:48 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so7425850wey.33
        for <linux-omap@vger.kernel.org>; Thu, 21 Feb 2013 04:09:47 -0800 (PST)
In-Reply-To: <20130221101603.GI23234@tbergstrom-lnx.Nvidia.com> (Peter De
	Schrijver's message of "Thu, 21 Feb 2013 12:16:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

>>>>> "Peter" == Peter De Schrijver <pdeschrijver@nvidia.com> writes:

 >> 
 >> Also, IMHO reset should always be done during probe() so driver can be
 >> dead sure that we're starting from a known state. This is even more

 Peter> Depends on the IP block. Eg: you might want to keep the screen
 Peter> showing the contents drawn by the bootloader while booting the
 Peter> kernel and smoothly change to a new image when userspace comes
 Peter> online. In that case you probably don't want to blindly reset
 Peter> the display controller for example.

Indeed. Another recent example was gpio pins (controlling stuff like
reset signals) where the bootloader had already set things up correctly
and the reset caused pins to toggle.

-- 
Bye, Peter Korsgaard
