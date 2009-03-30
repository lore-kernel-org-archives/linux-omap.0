From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: Don't warn user about expected behaviour in mmc-twl4030
Date: Mon, 30 Mar 2009 13:53:43 -0700
Message-ID: <200903301353.44087.david-b@pacbell.net>
References: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:24480 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751928AbZC3Uxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2009 16:53:47 -0400
In-Reply-To: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Monday 30 March 2009, Mark Brown wrote:
> The approach that's being taken by the mmc-twl4030 driver to disabling
> regulators is a normal and supported one 

So when are you going to fix the regulator docs to report that:

	ALL regulator consumers must start by enabling and
	then disabling the regulator.

The regulator framework is still broken in this respect.
(Not that you want to hear that, but it's still true.)
