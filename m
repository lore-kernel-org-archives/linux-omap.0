From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: USB confusion
Date: Tue, 1 Sep 2009 19:28:02 +0300
Message-ID: <20090901162802.GB28157@nokia.com>
References: <4A9D0898.4000400@mlbassoc.com>
 <4A9D117D.2070105@mlbassoc.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52667 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbZIAQ2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 12:28:48 -0400
Content-Disposition: inline
In-Reply-To: <4A9D117D.2070105@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Tue, Sep 01, 2009 at 02:20:13PM +0200, ext Gary Thomas wrote:
> Following up on this, I made sure that CONFIG_USB_EHCI_HCD was defined.
> 
> Now I see these messages:
>    ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>    Clock usbhost_48m_fck didn't enable in 100000 tries
>    ehci-omap: probe of ehci-omap.0 failed with error -22
> 
> Any ideas what else I might be missing?

check what happens with that clock. Why is that timing out ?

I believe that message comes from clk fw. Maybe Paul could
give us some hint. Paul ?

-- 
balbi
