From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Tue, 17 Mar 2009 00:07:18 -0700
Message-ID: <200903170007.18908.david-b@pacbell.net>
References: <200903110518.34945.david-b@pacbell.net> <200903161233.06166.david-b@pacbell.net> <49BF4554.601@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n13b.bullet.mail.mud.yahoo.com ([68.142.207.222]:42413 "HELO
	n13b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753274AbZCQHHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2009 03:07:23 -0400
In-Reply-To: <49BF4554.601@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: OMAP <linux-omap@vger.kernel.org>

On Monday 16 March 2009, Adrian Hunter wrote:
> Also vsim (vmmc_aux) is not being found.

Elaborate please?  The regulator framework complains
if it's not there, even when that's not a bug.


