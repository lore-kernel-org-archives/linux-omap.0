From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Tue, 11 Aug 2009 23:51:06 +0300
Message-ID: <20090811205106.GC13969@gandalf>
References: <20090808071705.GA11844@nokia.com>
 <1249914799.25044.4.camel@blitz>
 <20090810161605.GA4357@gandalf>
 <1249923607.31495.13.camel@blitz>
 <20090810170236.GA3528@gandalf>
 <1249925323.31495.31.camel@blitz>
 <20090810184818.GA4281@gandalf>
 <1249936961.31495.87.camel@blitz>
 <20090811063305.GB4573@nokia.com>
 <1250004077.18768.17.camel@blitz>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40882 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbZHKUvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 16:51:15 -0400
Content-Disposition: inline
In-Reply-To: <1250004077.18768.17.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: felipe.balbi@nokia.com, "me@felipebalbi.com" <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Tue, Aug 11, 2009 at 11:21:17AM -0400, Peter Barada wrote:
> Unfortunately, with the patch, and:
> 
> 1) modprobe musb_hdrc
> 2) modprobe g_ether
> 3) connect micro-a cable
> 4) echo 1 > /sys/devices/platform/musb_hdrc/connect
> 
> Nothing happens - no isr or output.

did you have anything at the other end of the micro-a cable ?

-- 
balbi
