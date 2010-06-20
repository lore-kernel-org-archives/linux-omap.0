From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/5] arm: omap: switch over to gpio_set_debounce
Date: Mon, 21 Jun 2010 00:12:28 +0300
Message-ID: <20100620211225.GA16870@gandalf>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
 <1274090554-19420-4-git-send-email-felipe.balbi@nokia.com>
 <AANLkTikeS8VtXbO5iOgvDMxy7QIxrbfzS4Hob_BsHylj@mail.gmail.com>
 <20100617044502.GB4237@nokia.com>
 <AANLkTikf8S0ixtDTXftuhhCIM1cbRJlgYoU27drvUwUH@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44175 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab0FTVMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jun 2010 17:12:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikf8S0ixtDTXftuhhCIM1cbRJlgYoU27drvUwUH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Sun, Jun 20, 2010 at 08:03:45PM +0300, Grazvydas Ignotas wrote:
> gpio-keys platform data already has 'debounce_interval' member, which
> is used to setup timer (if nonzero) in the driver. So I maybe it would
> be better to modify gpio-keys to try to set debounce, and if that
> fails make it fall back to it's current timer-based debounce
> functionality?

makes sense to me.

-- 
balbi
