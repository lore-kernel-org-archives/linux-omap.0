From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Subject: Re: [PATCH 0/2] power button repeat input events
Date: Mon, 14 Mar 2011 13:13:27 +0200
Message-ID: <20110314111327.GA10563@smart.research.nokia.com>
References: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
 <4D7A53FF.4060004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:38668 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab1CNLNa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 07:13:30 -0400
Content-Disposition: inline
In-Reply-To: <4D7A53FF.4060004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Fri, Mar 11, 2011 at 10:25:27PM +0530, ext Nishanth Menon wrote:
> 
> Denis Karpov wrote, on 03/11/2011 10:07 PM:
> >Hi,
> >
> >this patchset adds optional generation of repeat input events for
> >twl4030 power button. It adds optional platform data for
> >twl4030-pwrbutton and initializes it for RX51/N900 (default
> >behavior kept - repeated input events disabled).
> >
> >We are working on an OMAP3 with TWL5031 MFD. In one of the use
> >scenarios userspace wants to receive repeated input events from
> >long press of power button.
> 
> dumb question - is'nt this a userspace responsibility as far as power
> button is concerned? what is the benefit of providing repeat events
> like a generic keypad for the power button?

In our case userspace needs this to track the continuous button press 
of power button. 

Denis
