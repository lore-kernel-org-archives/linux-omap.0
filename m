From: Tony Lindgren <tony@atomide.com>
Subject: Re: Gadget regression with enabling of MUSB babble interrupt handling
Date: Thu, 19 Jun 2014 03:31:01 -0700
Message-ID: <20140619103100.GB29055@atomide.com>
References: <20140619095655.GA29055@atomide.com>
 <53A2B6B0.2040804@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39545 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757281AbaFSKbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2014 06:31:06 -0400
Content-Disposition: inline
In-Reply-To: <53A2B6B0.2040804@zonque.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, george.cherian@ti.com

* Daniel Mack <daniel@zonque.org> [140619 03:10]:
> (+ George)
> 
> On 06/19/2014 11:56 AM, Tony Lindgren wrote:
> > Looks like commit ca88fc2ef0d7 (usb: musb: add a work_struct
> > to recover from babble errors) causes MUSB gadgets to stop
> > enumerating at least on omap3. Reverting the the commit fixes
> > the issue.
> 
> Hmm, so do you see babble errors occuring?

Not that I noticed of.
 
> Also, there are some more patches for musb and babble error recovery on
> the usb list, namely the ones starting here in v6:
> 
>   http://marc.info/?l=linux-usb&m=140109627505065&w=4
> 
> Care to give them a try?

I can confirm that "[PATCH v6 1/5] usb: musb: core: Handle Babble
condition only in HOST mode" fixes the issue for me. Also the
explanation in the patch description explains why it breaks, and
probably for all gadgets too because "BABBLE and RESET share the
same interrupt" so it's RESET in peripheral mode.

But that also raises a question: Were these patches merged for
v3.16 ever even tested in peripheral mode?

Regards,

Tony
