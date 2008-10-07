From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2/2 rc8-omap-git] twl4030-core irq simplification
Date: Tue, 7 Oct 2008 02:18:10 -0700
Message-ID: <200810070218.10819.david-b@pacbell.net>
References: <200810062043.35080.david-b@pacbell.net> <20081007085912.GG21037@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:36413 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751951AbYJGJSM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 05:18:12 -0400
In-Reply-To: <20081007085912.GG21037@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Tony Lindgren wrote:
> Pushed.

Cool.  Now, once the pwrirq updates get sorted out, there
will be only two main steps left in my plan:

 - Rework the twl4030 core SIH init.  Basically, use a
   different IRQ setup data structure, which will be kept
   around for later use by ...

 - New generic SIH IRQ handling code using that data, and
   looking much like the current GPIO stuff (in current GIT,
   after you merged the patch updating it) -- but sharable
   between at least GPIO and pwrirq, and replacing pwrirq.

I'm going to hold back on sending that stuff out until at
least next week, to let things shake out a bit more.   Find
the i2c-omap issue; sort the Overo puzzle; etc.

- Dave

