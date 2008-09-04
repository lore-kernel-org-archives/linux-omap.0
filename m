From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 17:16:00 -0700
Message-ID: <200809031716.00681.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <20080902221501.GD23085@atomide.com> <20080903180142.GS23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:47999 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752259AbYIDAQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 20:16:04 -0400
In-Reply-To: <20080903180142.GS23085@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On Wednesday 03 September 2008, Tony Lindgren wrote:
> My OSK is booting just fine here with current mainline and the
> omap_osk_5912_defconfig. This is the current head at
> 2.6.27-rc5-00100-gec0c15a. Have you checked if yours boots with
> the mainline omap_osk_5912_defconfig?

Today's root seems to work:  no "sudden death" before the kernel
banner shows.  I'll see if it still works after I turn it into
something more useful.  For now I'm assuming one of the recent
ARM merges helped somehow.

- Dave

