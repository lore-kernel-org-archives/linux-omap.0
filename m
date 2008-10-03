From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] usb: add back otg_get_transceiver
Date: Sat, 4 Oct 2008 02:56:39 +0300
Message-ID: <20081003235637.GI10743@frodo>
References: <1223043350-17588-1-git-send-email-felipe.balbi@nokia.com> <20081003143132.GG6251@atomide.com> <e5e6ade50810031304x6aa4a6dfj5b92e730221d85f1@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57165 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbYJCX5D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 19:57:03 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810031304x6aa4a6dfj5b92e730221d85f1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Oct 03, 2008 at 01:04:27PM -0700, Nathan Monson wrote:
> On Fri, Oct 3, 2008 at 7:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Balbi <felipe.balbi@nokia.com> [081003 17:18]:
> >> make twl4030_usb transceiver reach musb.
> >
> > Pushed until you have something in mainline.
> 
> Now that this is in linux-omap git, my BeagleBoard no longer boots due
> to a null dereference in musb_platform_init (*x).
> 
> Applying "i2c: change twl4030-usb back to subsys_initcall" from
> earlier today allows the kernel to boot.

expected behavior without that patch applied. musb tries to get a
transceiver that doesn't exist yet since twl4030 is probing after musb.

-- 
balbi
