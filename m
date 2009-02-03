From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()
	function
Date: Wed, 4 Feb 2009 00:28:42 +0200
Message-ID: <20090203222842.GB6214@frodo>
References: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com> <20090203204235.GH7215@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51769 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZBCW2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 17:28:50 -0500
Content-Disposition: inline
In-Reply-To: <20090203204235.GH7215@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kim Kyuwon <chammoru@gmail.com>, linux-omap@vger.kernel.org, ????????? <kyungmin.park@samsung.com>, ????????? <q1.kim@samsung.com>

On Tue, Feb 03, 2009 at 12:42:36PM -0800, Tony Lindgren wrote:
> * Kim Kyuwon <chammoru@gmail.com> [090131 00:22]:
> > USB should be suspended with interrupt disabled[1]. If USB is suspended with
> > interrupt enabled and connected to host PC, a kernel panic would occur When
> > it wakes up. Because, after the arch_suspend_enable_irqs() function is called
> > in the suspend_enter() function, USB Interrupt handler is called, even though
> > USB controller is still not resumed! All devices are resumed after the
> > device_resume() is called.
> 
> Please send the usb patches to the linux-usb@vger.kernel.org list
> with linux-omap list Cc'd.

and Cc me as well and David Brownell

-- 
balbi
