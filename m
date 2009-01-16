From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Question on how to best access a chip on init that needs VAUX1
	power?
Date: Fri, 16 Jan 2009 15:10:35 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D6A15FE@dlee02.ent.ti.com>
References: <1232134287.347.44.camel@blackhole>
	 <13B9B4C6EF24D648824FF11BE8967162036D6A1527@dlee02.ent.ti.com>
 <1232139902.347.64.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761359AbZAPVKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 16:10:43 -0500
In-Reply-To: <1232139902.347.64.camel@blackhole>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> > u-boot also has simple utility to read from mtd which has u-boot environment
> where you could have stored it away.
>
> Ultimately I should just pull the block of data in u-boot, extract what
> I need for u-boot, and then pass it to the kernel.  Outside of creating
> a specific ATAG for this, what's the best way to pass a block of data
> from u-boot to the kernel?

Outside of ATAG I don't know what the best way is.  There were some omap specific tags which were recently deemed not the right way.

You should inquire on u-boot list and see what some of the ports there do.

As a thought the on chip SRAM would provide an easy way to pass the information up.

Regards,
Richard W.
