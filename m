From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/5] ARM: OMAP: remove unnecessary locking in
 clk_get_rate()
Date: Wed, 4 Jun 2008 19:54:06 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806041949030.17359@utopia.booyaka.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com>  <1211323550-5318-2-git-send-email-khilman@mvista.com>  <1211323550-5318-3-git-send-email-khilman@mvista.com>  <1211323550-5318-4-git-send-email-khilman@mvista.com>
 <1211323550-5318-5-git-send-email-khilman@mvista.com>  <1211323550-5318-6-git-send-email-khilman@mvista.com>  <alpine.DEB.1.00.0806040058450.1170@utopia.booyaka.com>  <4846C44E.9090102@mvista.com> <20080604223019.GJ6992@atomide.com>  <48472F29.8000109@mvista.com>
 <1212625802.19234.24.camel@mort>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbYFEByI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 21:54:08 -0400
In-Reply-To: <1212625802.19234.24.camel@mort>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: ext Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hello,

On Thu, 5 Jun 2008, Igor Stoppa wrote:

> - if a dvfs change is responsible of changing the rate supplied to a
> driver which asked it with clk_get_rate(), the dvfs transition has no
> reason to happen in case it would violate the constraints set by clock
> users.

There aren't any such constraints in the current tree.

clk_set_rate() is mostly only useful for code that doesn't expect the 
clock rate to be changed by other code.  Pre- and post-clk-rate-change 
notifiers should fix this for code that does need to know clock rates 
precisely.


- Paul
