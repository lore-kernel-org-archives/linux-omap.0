From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Reg: USB: ehci-omap: Suspend the controller during idle.
Date: Tue, 6 Aug 2013 21:50:14 +0800
Message-ID: <20130806135014.GA1048@kroah.com>
References: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52097 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3HFNuO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 09:50:14 -0400
Content-Disposition: inline
In-Reply-To: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bharathraj Nagaraju <bharathraj.nagaraju@sasken.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "keshava_mgowda@ti.com" <keshava_mgowda@ti.com>, "khilman@ti.com" <khilman@ti.com>, "rogerq@ti.com" <rogerq@ti.com>

On Tue, Aug 06, 2013 at 06:25:32PM +0530, Bharathraj Nagaraju wrote:
>   Dear All,
> 
>   We are working on omap4470 based device,kernel-3.0.31 is running on this.

Have you tried the 3.10 kernel for this?  I think you might find that
this already is resolved there, as lots of pm USB work has happened in
the past 2+ years since 3.0 was released.

thanks,

greg k-h
