From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc1-omap git] twl4030_keypad cleanup
Date: Fri, 23 Jan 2009 13:11:03 -0800
Message-ID: <200901231311.03982.david-b@pacbell.net>
References: <200901200051.47122.david-b@pacbell.net> <20090123201751.GC440@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:32254 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755338AbZAWVLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 16:11:06 -0500
In-Reply-To: <20090123201751.GC440@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: OMAP <linux-omap@vger.kernel.org>

On Friday 23 January 2009, Felipe Balbi wrote:
> This looks good. I also see this driver is going to mainline, so we're
> gonna have to drop this driver from l-o on 2.6.30 merge window, right ?

If by "we" you mean "Tony", I suppose so.  ;)

My notion is that this patch merges, and then I'll send
two patches:  (a) to OMAP, a rename patch; (b) to mainline,
submit the cleaned-up-and-renamed driver.

Then when it merges to mainline, there will be no deltas
between the driver versions, and Tony won't have to think
about such issues.

- Dave

