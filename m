From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Thu, 15 Jan 2009 10:21:38 -0800
Message-ID: <200901151021.38538.david-b@pacbell.net>
References: <20090115154327.GF4128@atomide.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:40451 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754743AbZAOSVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 13:21:40 -0500
In-Reply-To: <20090115154327.GF4128@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 15 January 2009, Tony Lindgren wrote:
> I've updated our git tree to v2.6.29-rc1,

  CC      arch/arm/mach-omap2/usb-musb.o
arch/arm/mach-omap2/usb-musb.c:47: error: 'INT_243X_HS_USB_MC' undeclared here (not in a function)
arch/arm/mach-omap2/usb-musb.c:51: error: 'INT_243X_HS_USB_DMA' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/usb-musb.o] Error 1

... just FYI.  I won't have time to sort that out for a few
hours yet, so if someone else has a patch that'd be good.

