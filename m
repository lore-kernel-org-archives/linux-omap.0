From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP reaction facing a multiple devices definition by muxing
Date: Fri, 30 Oct 2009 10:37:44 -0700
Message-ID: <20091030173743.GZ7180@atomide.com>
References: <1256892728.14448.6.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63545 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932695AbZJ3Rhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 13:37:41 -0400
Content-Disposition: inline
In-Reply-To: <1256892728.14448.6.camel@dell-desktop.example.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: max <mboure@ubiquiet.com>
Cc: linux-omap@vger.kernel.org

* max <mboure@ubiquiet.com> [091030 01:58]:
> Hello,
> 
> I have a question concerning the mux and the OMAP's reaction.
> 
> How does the omap reacts when you define a register for a specific
> device that is already initiated as primary mode of another register ?
> For example CONTROL_PADCONF_UART1_ defines the uart1 in primary mode but
> when you mux the register CONTROL_PADCONF_MCBSP_CLKS into mode 5 (and
> the other apropiate registers for the uart1) how does the OMAP reacts ?
> 
> Thank you for your answer. 

AFAIK, it just reroutes the signal and that's it. The muxing system
does not affect the omap internal state, it's there just to route the
signals to the limited number of pins.

Regards,

Tony
