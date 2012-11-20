From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 159/493] usb: remove use of __devinit
Date: Tue, 20 Nov 2012 16:44:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211201642540.1692-100000@iolanthe.rowland.org>
References: <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42297 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751754Ab2KTVoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 16:44:14 -0500
In-Reply-To: <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Peter Korsgaard <jacmet@sunsite.dk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Li Yang <leoli@freescale.com>, Geoff Levand <geoff@infradead.org>, Wan ZongShun <mcuos.com@gmail.com>, Olav Kongas <ok@artecdesign.ee>, Lennert Buytenhek <kernel@wantstofly.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>

For all the __devinit* annotations and all the EHCI, OHCI, and UHCI 
drivers:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

