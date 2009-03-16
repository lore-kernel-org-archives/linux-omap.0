From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Mon, 16 Mar 2009 12:33:06 -0700
Message-ID: <200903161233.06166.david-b@pacbell.net>
References: <200903110518.34945.david-b@pacbell.net> <200903120222.02972.david-b@pacbell.net> <49BE65DE.90205@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:37672 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752098AbZCPTdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 15:33:09 -0400
In-Reply-To: <49BE65DE.90205@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: OMAP <linux-omap@vger.kernel.org>

On Monday 16 March 2009, Adrian Hunter wrote:
> The linker is not happy with built-in code trying to call functions in a module directly.

Hmm, I guess I mis-read something ... didn't know the MMC core
could be built as a module!

So the workaround is not to build it that way.  And the long-term
fix is to merge the mmc-twl4030 code into the hsmmc driver.

Any problem with using that workaround for a while?

- Dave

