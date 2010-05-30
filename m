From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap udc driver problem with beagle board
Date: Sun, 30 May 2010 19:00:48 +0300
Message-ID: <20100530160047.GA7704@gandalf>
References: <4C0235AD.70008@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37997 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0E3QAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 May 2010 12:00:12 -0400
Content-Disposition: inline
In-Reply-To: <4C0235AD.70008@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
Cc: felipe.balbi@nokia.com, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Linux Embedded <linux-embedded@vger.kernel.org>, tony@atomide.com

On Sun, May 30, 2010 at 11:53:49AM +0200, Marco Stornelli wrote:
> Hi,
> 
> I'm using the kernel 2.6.34 with the beagle board rev. c4. I have got
> some problems with the ethernet gadget to use nfs over usb. The problem
> is with the usb. When the g_ether driver register itself, the omap udc
> driver returns ENODEV because the kernel didn't call the probe for
> this driver. Looking at the code, it seems the problem is in board
> specific management of the usb. There isn't the registration of the
> platform device to match the omap udc platform driver. It should be done
> in the omap_usb_init() but in case of beagle board this function is
> never called, so omap udc driver cannot work. Is it a regression? Is
> there any workaround?

beagle board uses musb. You shouldn't be relying on the udc controller.
Your Kconfig is just wrong.

-- 
balbi
