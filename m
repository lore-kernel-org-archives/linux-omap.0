From: Paul Walmsley <paul@pwsan.com>
Subject: Re: AM3517 USB and OTG issues 3.9-rc1 kernel.
Date: Sun, 31 Mar 2013 00:19:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310018350.6436@utopia.booyaka.com>
References: <F690310232FDDF4AB457E8B3EF90DDE07A474399@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35720 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab3CaATX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 20:19:23 -0400
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE07A474399@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sat, 30 Mar 2013, Marc Murphy wrote:

> Hello All,
> I have a question about the updates/changes that have been made to the USB OTG support in the latest 3.9-rc1 kernel
> 
> My platform is using an AM3517 processor and I am in the progress of 
> moving from 3.6 to 3.9 kernel because I need some of the iio support in 
> the latest 3.9 kernel. The last hurdle I have is in trying to get the 
> USB OTG support working in HOST mode, as I am using it to connect a 
> storage device to.
> 
> If I configure the kernel in the same way as I do for 3.6 it doesn't bring the interface up.

Maybe try resending this and cc Felipe Balbi <balbi@ti.com> and 
<linux-usb@vger.kernel.org>?


- Paul
