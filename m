From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 5/5] ARM: OMAP: remove unnecessary locking
	in	clk_get_rate()
Date: Thu, 05 Jun 2008 03:30:02 +0300
Message-ID: <1212625802.19234.24.camel@mort>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com>
	 <1211323550-5318-2-git-send-email-khilman@mvista.com>
	 <1211323550-5318-3-git-send-email-khilman@mvista.com>
	 <1211323550-5318-4-git-send-email-khilman@mvista.com>
	 <1211323550-5318-5-git-send-email-khilman@mvista.com>
	 <1211323550-5318-6-git-send-email-khilman@mvista.com>
	 <alpine.DEB.1.00.0806040058450.1170@utopia.booyaka.com>
	 <4846C44E.9090102@mvista.com> <20080604223019.GJ6992@atomide.com>
	 <48472F29.8000109@mvista.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51284 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762699AbYFEAfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 20:35:34 -0400
In-Reply-To: <48472F29.8000109@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Hi,

On Wed, 2008-06-04 at 17:11 -0700, ext Kevin Hilman wrote:

> The same can happen even with the locking.  If someone asks for the 
> rate, and then another thread changes the rate right after, the thread 
> who asked for the rate has an out-of-date value.

I don't understand how this would materialize in practice:

- if the rate is beign changed by 2 threads from the same driver, then
the driver itself needs to take care of its internal state and coherency

- if 2 different drivers are contending the same clock, then 2 children
clocks should be created and the clock fw would take care of failing the
request of the 2nd child, if it is incompatible with the rate set by the
1st one

- if a dvfs change is responsible of changing the rate supplied to a
driver which asked it with clk_get_rate(), the dvfs transition has no
reason to happen in case it would violate the constraints set by clock
users.

Does this make sense?

-- 
Cheers, Igor

---

Igor Stoppa
Nokia Devices R&D - Helsinki
